@RestResource(UrlMapping='/api/v1/events/*')
global class EventAPI {
	private static void handleRequest(){
		RouteEvent router = new RouteEvent();
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
