//= require moment
//= require fullcalendar

$(function() {
    $('#calendar').fullCalendar({  
    	events: 'student/unit_events',
    	firstDay: 1
    });
});