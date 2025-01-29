// app/javascript/controllers/conversation_controller.js
import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  static targets = ["messages"]

  connect() {
    this.subscription = consumer.subscriptions.create(
      { channel: "ConversationChannel", id: this.data.get("id") },
      {
        received: (data) => {
          if (data.sender_id !== this.data.get("currentUserId")) {
            this.messagesTarget.insertAdjacentHTML('beforeend', data.html)
            this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
          }
        }
      }
    )
  }

  submit(e) {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault()
      e.target.form.requestSubmit()
    }
  }

  disconnect() {
    this.subscription.unsubscribe()
  }
}
