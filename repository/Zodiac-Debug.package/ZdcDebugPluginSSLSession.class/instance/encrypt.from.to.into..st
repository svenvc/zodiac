operations
encrypt: srcBuf from: start to: stop into: dstBuf
	"Encrypt the input in srcBuf from start to stop into dstBuf."

	| result |
	self before: 'SSL Plugin Encrypt' source: srcBuf from: start to: stop destination: dstBuf. 
	result := super encrypt: srcBuf from: start to: stop into: dstBuf.
	self after: 'SSL Plugin Encrypted' result: result destination: dstBuf.
	^ result