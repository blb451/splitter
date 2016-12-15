App.newsfeed = App.cable.subscriptions.create "NewsfeedChannel",
  connected: ->
    console.log('connected')

  disconnected: ->
    console.log('disconnected')

  received: (data) ->
    console.log('received data' + data)
    $('#combined_news').prepend data['newsfeed']
