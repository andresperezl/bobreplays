var ytPlayer;
function onYouTubeIframeAPIReady() {
  ytPlayer = new YT.Player('ytPlayer', {
    height: false,
    width: false,
    videoId: 'O345c46mFqY',
    playerVars:{
      start: 3600,
      autoplay: 1
    }
    
  })
}

$(function(){
  var tag = document.createElement('script');
  tag.src = "https://www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
})