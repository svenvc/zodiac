testing
testSimple
	| client |
	(client := ZnClient new)
		https;
		host: 's3-eu-west-1.amazonaws.com';
		addPath: 'public-stfx-eu';
		addPath: ('test-', 2050 asString, '.txt');
		get;
		close.
	self assert: client isSuccess.
	self assert: client response contentType equals: ZnMimeType textPlain.
	self assert: client response contentLength equals: 2050.
	self 
		assert: client contents 
		equals: (ZnHTTPSTests generateTestData: 2050)