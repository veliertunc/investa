import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game"
export default class extends Controller {
  static targets = ["question", "yesBox", "noBox", "character", "dialog"];

  connect() {
    // Define the yes/no questions array.
    this.questions = [
      "Do you want to help others?",
      "Who have vision and big ideas?",
      "Who have vision and big ideas?",
    ];

    this.currentQuestionIndex = 0;
    this.answers = [];
    this.showQuestion();
    // Start falling animation for the boxes.
    this.animateBoxes();
    // Bind the moveCharacter method to preserve context.
    this.boundMoveCharacter = this.moveCharacter.bind(this);
    // Listen for arrow key presses.
    window.addEventListener("keydown", this.boundMoveCharacter);
  }

  showQuestion() {
    // Show current question or end game if finished.
    if (this.currentQuestionIndex < this.questions.length) {
      this.questionTarget.textContent = this.questions[this.currentQuestionIndex];
    } else {
      this.endGame();
    }
  }

  animateBoxes() {
    // Reset and trigger the falling animation on the yes/no boxes.
    this.yesBoxTarget.classList.remove("falling");
    this.noBoxTarget.classList.remove("falling");
    void this.yesBoxTarget.offsetWidth;
    void this.noBoxTarget.offsetWidth;
    this.yesBoxTarget.classList.add("falling");
    this.noBoxTarget.classList.add("falling");

    // After the falling animation (3 seconds), record the answer.
    setTimeout(() => {
      const characterRect = this.characterTarget.getBoundingClientRect();
      const gameArea = this.element.querySelector(".relative");
      const gameRect = gameArea.getBoundingClientRect();
      // Determine answer based on whether the character is left (Yes) or right (No) of center.
      const characterCenter = characterRect.left + characterRect.width / 2;
      const gameCenter = gameRect.left + gameRect.width / 2;
      const answer = characterCenter < gameCenter;
      this.answers.push(answer);
      console.log("Answer recorded: ", answer);
      this.currentQuestionIndex++;
      this.showQuestion();
      // Trigger next falling animation if questions remain.
      if (this.currentQuestionIndex < this.questions.length) {
        this.animateBoxes();
      }
    }, 3000);
  }

  moveCharacter(event) {
    const step = 20;
    const gameArea = this.element.querySelector(".relative");
    const gameRect = gameArea.getBoundingClientRect();
    // Get the current left position relative to the game area.
    let leftPos = parseInt(this.characterTarget.style.left) || (gameRect.width / 2);
    if (event.key === "ArrowLeft") {
      leftPos = Math.max(0, leftPos - step);
    } else if (event.key === "ArrowRight") {
      leftPos = Math.min(gameRect.width - this.characterTarget.width, leftPos + step);
    }
    this.characterTarget.style.left = leftPos + "px";
  }

  endGame() {
    // Remove keydown listener.
    window.removeEventListener("keydown", this.boundMoveCharacter);
    // Use showModal() on the dialog with the given ID.
    this.dialogTarget.showModal();
    console.log("Game over! Answers: ", this.answers);
  }
}
