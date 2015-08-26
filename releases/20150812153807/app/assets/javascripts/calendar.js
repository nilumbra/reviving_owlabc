//= require moment
//= require fullcalendar

$(function() {
    $('#calendar').fullCalendar({  
    	events: 'student/unit_events',
    	firstDay: 1
    	// [
		   //  {
		   //      title  : 'event1',
		   //      start  : '2015-08-01'
		   //  },
		   //  {
		   //      title  : 'event2',
		   //      start  : '2015-08-08',
		   //      end    : '2015-08-12'
		   //  },
		   //  {
		   //      title  : 'event3',
		   //      start  : '2015-08-07T12:30:00',
		   //      allDay : false // will make the time show
		   //  }
     //    ]
});
    });