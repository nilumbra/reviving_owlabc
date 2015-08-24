//=require jquery.prettyPhoto

function initPrettyPhoto(){
  $("a[rel^='prettyPhoto']").prettyPhoto({show_title:false});
}
$(document).ready(function(){
  initPrettyPhoto();
});