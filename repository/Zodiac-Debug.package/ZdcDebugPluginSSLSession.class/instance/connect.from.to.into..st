operations
connect: srcBuf from: start to: stop into: dstBuf
	"Start or continue the client handshake using the given input token"

	| result |
	self before: 'SSL Plugin Connect' source: srcBuf from: start to: stop destination: dstBuf. 
	result := super connect: srcBuf from: start to: stop into: dstBuf.
	self after: 'SSL Plugin Connected' result: result destination: dstBuf.
	^ result