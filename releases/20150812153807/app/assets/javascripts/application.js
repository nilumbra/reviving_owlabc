//= require jquery
//= require jquery_ujs

//= require semantic-ui
//= require jquery.countdown.min
//= require cocoon
//= require sweet-alert

$('.ui.accordion').accordion();

$('.ui.checkbox').checkbox();
$('.menu .ui.dropdown').dropdown({on: 'hover'});

$('table.sortable').tablesort();
$('.progress').progress();


var $menu = $('.sidebar.menu')

$menu.sidebar('setting', 'transition', 'overlay');

$('.launch.button, .view-ui, .launch.item')
.on('click', function(event) {
  $menu.sidebar('toggle');
  event.preventDefault();
});


$(".search.icon").click(function(){
  // $(this).parent('form').submit()
  $(this).parents('form').submit()
});

$(document).ready(function(){
  $("form").submit(function(e){
    $("form").addClass('loading')
  });

  $('.right.menu.open').on("click",function(e){
        e.preventDefault();
    $('.ui.vertical.menu').toggle();
  });

  $('.ui.dropdown').dropdown();
})
