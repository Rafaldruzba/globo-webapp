const surpriseButton = document.querySelector("#surpriseButton");
const surpriseMessage = document.querySelector("#surpriseMessage");
const buttonLabel = document.querySelector("#buttonLabel");

surpriseButton.addEventListener("click", () => {
  const isOpen = surpriseButton.getAttribute("aria-expanded") === "true";

  surpriseButton.setAttribute("aria-expanded", String(!isOpen));
  surpriseMessage.hidden = isOpen;
  buttonLabel.textContent = isOpen
    ? "Otwórz małą niespodziankę"
    : "Schowaj wiadomość";
});
