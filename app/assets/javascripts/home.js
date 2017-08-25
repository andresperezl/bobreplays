var ytPlayer;
var videoId;
var startTime;
function onYouTubeIframeAPIReady() {
  getCurrentVideo();
}
function getNewVideo(event){
  // Request the next video when the current one has ended
  if (event.data == YT.PlayerState.ENDED) {
    $.ajax({
      url: "/video/playing",
      dataType: "json",
      success: function(data){
        videoId = data["videoId"];
        startTime = new Date(data["start_time"]);
        var offset = Math.round(((new Date()) - startTime)/1000);
        ytPlayer.loadVideoById({
          videoId: videoId,
          startSeconds: offset
        });
      }
    });
  }
}

function getCurrentVideo(){
  $.ajax({
    url: "/video/playing",
    dataType: "json",
    success: function(data){
      videoId = data["videoId"];
      startTime = new Date(data["start_time"]);
      var offset = Math.round(((new Date()) - startTime)/1000);
      ytPlayer = new YT.Player('ytPlayer', {
        height: false,
        width: false,
        videoId: data["videoId"],
        playerVars:{
          start: offset,
          autoplay: 1
        },
        // Trigger when the current video has ended
        events: {
          'onStateChange' : getNewVideo
        }
        
      });
    }

  });
}

var streamSize = 9;
var chatSize = 3;
var optionsMenu = $("#optionsMenu");
var optionsWrapper = $("#optionsWrapper");
var chatOnLeft = $("input[type='checkbox']#chatOnLeft");
function setRatio(stream, chat){
  $("#ytPlayer").removeClass();
  $("#twitchChat").removeClass();
  $("#ytPlayer").addClass("col-md-" + stream);
  if(chatOnLeft.is(":checked")){
     $("#ytPlayer").addClass("col-md-push-" + chat);
  }
  if(chat > 0){
    $("#twitchChat").show();
    $("#twitchChat").addClass("col-md-" + chat);
    if(chatOnLeft.is(":checked")){
      $("#twitchChat").addClass("col-md-pull-" + stream);
    }
  } else {
    $("#twitchChat").hide();
  }
  streamSize = stream;
  chatSize = chat;
}

$(function(){
  //Effects
  optionsMenu.fadeTo(0,0);
  $("#navLogo").fadeTo(0, 0.1);
  $("#optionsContainer").mouseover(function(){
    $("#navLogo").fadeTo(500,1);
    optionsMenu.fadeTo(500, 1);          
  })
  $("#optionsContainer").mouseleave(function(){
    $("#navLogo").fadeTo(500, 0.1);
    optionsMenu.fadeTo(500, 0);        
  });
  chatOnLeft.change(function(){
    setRatio(streamSize, chatSize);
  });

  //YT Player Load
  var tag = document.createElement('script');
  tag.src = "https://www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
})

