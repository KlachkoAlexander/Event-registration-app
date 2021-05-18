@isTest
public with sharing class CharityNavigatorDataMockImpl implements HttpCalloutMock {
	protected Integer code;
	protected String status;
	protected String body;
	protected Map<String, String> responseHeaders;

	private static final Integer DEFAULT_CODE = 200;
	private static final String DEFAULT_STATUS = 'OK';
	private static final String DEFAULT_BODY = '';
	private static final Map<String, String> DEFAULT_HEADERS = new Map<String, String>{
		'Content-Type:' => 'application/json'
	};
	public CharityNavigatorDataMockImpl(Integer code, String status, String body, Map<String, String> responseHeaders) {
		this.code = code;
		this.status = status;
		this.body = body;
		this.responseHeaders = responseHeaders;
	}
	public CharityNavigatorDataMockImpl(String body) {
		this(DEFAULT_CODE, DEFAULT_STATUS, body, DEFAULT_HEADERS);
	}
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setBody(this.body);
        res.setStatusCode(this.code);
		res.setStatus(this.status);
		for (String key : this.responseHeaders.keySet()) {
			res.setHeader(key, this.responseHeaders.get(key));
		}
        return res;
    }
}
