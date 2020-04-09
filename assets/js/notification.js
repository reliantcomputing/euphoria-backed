let  Notification = {
  init(socket, packageId){
    socket.connect()
    this.onReady(socket, packageId);
  },

  onReady(socket, packageId){

    let robotNotificationChannel = socket.channel("notifications:robot:" + 2)
    robotNotificationChannel.join()
      .receive("ok", res => console.log("Joined successfully, okay!", res))
      .receive("error", reason => console.log("Failed to join the channel: ", reason))

    // handle response
    robotNotificationChannel.on("new_team_notification", res=>{
      console.log(res)
    })

    robotNotificationChannel.push("new_team_notification", {
      team_notification: {
        "package_id": 1,
        "notification": "Real time team notification",
        "user_id": 1,
        "is_viewed": false,
        "created_at": new Date().getMilliseconds
      }
    }).receive("error", reason => console.log(reason))
    .receive("ok", res => console.log(Date.now))

  }
}

export default Notification
