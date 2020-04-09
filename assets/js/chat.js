let Chat = {
  init(socket, chatId){
    socket.connect()
    this.onReady(socket, chatId);
  },

  onReady(socket, chatId){

    let msgContainer = document.getElementById("msg-container")
    let msgInput = document.getElementById("msg-input")
    let btnInput = document.getElementById("btn-input")

    let chatChannel = socket.channel("chats:" + 2)
    chatChannel.join()
      .receive("ok", res => console.log("Joined successfully, okay!", res))
      .receive("error", reason => console.log("Failed to join the channel: ", reason))

    // handle response
    chatChannel.on("new_chat", res=>{
      console.log(res)
      this.renderMessage(msgContainer, res)
    })

    btnInput.addEventListener("click", e => {
      chatChannel.push("new_chat", {
        "chat_message": {
          "message": msgInput.value,
          "user_id": 1,
          "chat_id": 1
        }
      }).receive("error", reason => console.log(reason))

      msgInput.value = ""
    })
  },

  renderMessage(msgContainer, res){
    console.log(res.chat_message.message)
    let div = document.createElement("div")
    div.innerHTML = `
      <span> <strong>Philani:</strong> </span> ${res.chat_message.message}`
    msgContainer.appendChild(div)
    msgContainer.scrollTop = msgContainer.scrollHeight
  }
}

export default Chat
