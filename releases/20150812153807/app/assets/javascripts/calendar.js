//= require moment
//= require fullcalendar

$(function() {
    $('#calendar').fullCalendar({  
    	eventSources: [ 
    		{
    			url: 'student/events'
    		},
    		{
    			url: 'student/homework_events',
    			color: 'green'
    		}
    	],
    	firstDay: 1,
    	height: 500
    });
});