@RestResource(UrlMapping='/api/v1/attendees/*')
global class AttendeeAPI {
	private static void handleRequest(){
		RouteAttendee router = new RouteAttendee();
		router.execute();
	}
	@HttpGet
	global static void handleGet() {
		handleRequest();
	}

	@HttpPost
	global static void handlePost() {
		handleRequest();
	}

	@HttpPut
	global static void handlePut() {
		handleRequest();
	}

	@HttpDelete
	global static void handleDelete() {
		handleRequest();
	}
}
