printing
printFieldsOn: stream
	super printFieldsOn: stream.
	stream nextPutAll: ' -> '; print: result