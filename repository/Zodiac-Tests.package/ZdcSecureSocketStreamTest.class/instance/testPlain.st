tests
testPlain
	| query stream request response |
	self isNativeSSLPluginPresent ifFalse: [ ^ self ].
	query := 'Smalltalk'.
	stream := ZdcSecureSocketStream openConnectionToHostNamed: 'duckduckgo.com' port: 443.
	request := nil.
	response := [
		request := String streamContents: [ :out |
			out << 'GET /?q=' << query << ' HTTP/1.1' << String crlf.
			out << 'Host: duckduckgo.com' << String crlf.
			out << 'Connection: close' << String crlf.
			out << String crlf ].
		stream connect.
		stream nextPutAll: request asByteArray.
		stream flush.
		stream upToEnd asString.
	] ensure: [ stream close ].
	self assert: (response includesSubstring: '200 OK').
	self assert: (response includesSubstring: 'Duck').
	self assert: (response includesSubstring: query)