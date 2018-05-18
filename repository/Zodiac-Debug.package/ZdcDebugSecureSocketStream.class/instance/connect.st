ssl
connect
	self logMessage: 'SSL Stream Connect'.
	super connect.
	self logMessage: 'SSL Stream Connected'