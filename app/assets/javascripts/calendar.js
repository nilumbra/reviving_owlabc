//= require moment
//= require fullcalendar

$(function() {
    $('#calendar').fullCalendar({  
    	eventSources: [ 
    		{
    			url: 'student/unit_events'
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