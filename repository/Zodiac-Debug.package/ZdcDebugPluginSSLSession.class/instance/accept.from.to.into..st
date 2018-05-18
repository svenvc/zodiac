operations
accept: srcBuf from: start to: stop into: dstBuf
	"Start or continue the server handshake using the given input token"

	| result |
	self before: 'SSL Plugin Accept' source: srcBuf from: start to: stop destination: dstBuf. 
	result := super accept: srcBuf from: start to: stop into: dstBuf.
	self after: 'SSL Plugin Accepted' result: result destination: dstBuf.
	^ result