printing
printO: stream
	super printOn: stream.
	stream nextPut: $(.
	self printFieldsOn: stream.
	stream nextPut: $)