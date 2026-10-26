##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region = var.region
}

##################################################################################
# LOCALS
##################################################################################

locals {

  common_tags = {
    Environment = var.environment
    BillingCode = var.billing_code
  }

  name_prefix = "${var.prefix}-${var.environment}"

}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_instance" "main" {
  count         = length(data.tfe_outputs.networking.nonsensitive_values.public_subnets)
  ami           = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type = var.instance_type
  subnet_id     = data.tfe_outputs.networking.nonsensitive_values.public_subnets[count.index]
  vpc_security_group_ids = [
    aws_security_group.webapp_http_inbound_sg.id,
    aws_security_group.webapp_ssh_inbound_sg.id,
    aws_security_group.webapp_outbound_sg.id,
  ]

  key_name = module.ssh_keys.key_pair_name

  tags = merge(local.common_tags, {
    "Name" = "${local.name_prefix}-webapp-${count.index}"
  })

}

resource "null_resource" "webapp" {
  count = length(aws_instance.main)

  triggers = {
    instance_id = aws_instance.main[count.index].id
    bootstrap   = filesha256("${path.module}/templates/userdata.sh")
    html        = filesha256("${path.module}/site/index.html")
    css         = filesha256("${path.module}/site/styles.css")
    javascript  = filesha256("${path.module}/site/app.js")
  }

  provisioner "file" {
    source      = "${path.module}/templates/userdata.sh"
    destination = "/tmp/userdata.sh"
  }

  provisioner "remote-exec" {
    inline = ["mkdir -p /tmp/site"]
  }

  provisioner "file" {
    source      = "${path.module}/site/index.html"
    destination = "/tmp/site/index.html"
  }

  provisioner "file" {
    source      = "${path.module}/site/styles.css"
    destination = "/tmp/site/styles.css"
  }

  provisioner "file" {
    source      = "${path.module}/site/app.js"
    destination = "/tmp/site/app.js"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /tmp/userdata.sh",
      "sudo install -d -o nginx -g nginx /usr/share/nginx/html",
      "sudo cp -R /tmp/site/. /usr/share/nginx/html/",
      "sudo chown -R nginx:nginx /usr/share/nginx/html",
      "sudo nginx -t && sudo systemctl reload nginx",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    port        = "22"
    host        = aws_instance.main[count.index].public_ip
    private_key = module.ssh_keys.private_key_openssh
  }

}

resource "null_resource" "application_config" {
  count = length(aws_instance.main) > 0 ? 1 : 0

  triggers = {
    web_server_names = join(",", aws_instance.main.*.id)
    config_template  = filesha256("${path.module}/templates/application.config.tpl")
  }

  provisioner "file" {
    content = templatefile("${path.module}/templates/application.config.tpl", {
      hosts     = aws_instance.main.*.private_dns
      site_name = "${local.name_prefix}-taco-wagon"
      api_key   = var.api_key
    })
    destination = "/home/ec2-user/application.config"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    port        = 22
    host        = aws_instance.main[0].public_ip
    private_key = module.ssh_keys.private_key_openssh
  }
}

resource "aws_lb" "main" {
  name               = "${local.name_prefix}-webapp"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webapp_http_inbound_sg.id]
  subnets            = data.tfe_outputs.networking.nonsensitive_values.public_subnets

  enable_deletion_protection = false

  tags = local.common_tags
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_target_group" "main" {
  name        = "${local.name_prefix}-webapp"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = data.tfe_outputs.networking.nonsensitive_values.vpc_id
}

resource "aws_alb_target_group_attachment" "main" {
  count            = length(aws_instance.main.*.id)
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.main[count.index].id
}
