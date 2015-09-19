// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  $("#filterBtn").click(function(){
    window.location = "/matches/1/" + encodeURIComponent($("#filterText").val());
  })
  $("#filterText").keypress(function(e){
    if(e.keyCode == 13){
      $("#filterBtn").click();
    }
  })
});