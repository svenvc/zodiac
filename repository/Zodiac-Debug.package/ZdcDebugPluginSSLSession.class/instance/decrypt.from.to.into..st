operations
decrypt: srcBuf from: start to: stop into: dstBuf
	"Decrypt the input in srcBuf from start to stop into dstBuf."

	| result |
	self before: 'SSL Plugin Decrypt' source: srcBuf from: start to: stop destination: dstBuf. 
	result := super decrypt: srcBuf from: start to: stop into: dstBuf.
	self after: 'SSL Plugin Decrypted' result: result destination: dstBuf.
	^ result