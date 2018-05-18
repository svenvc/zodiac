printing
printFieldsOn: stream
	timestamp printYMDOn: stream.
	stream nextPut: $T.
	timestamp printHMSOn: stream.
	stream nextPut: $. .
	timestamp nanoSecond printOn: stream base: 10 length: 9 padded: true.
	stream space; nextPut: $$; print: pid.
	message ifNotNil: [
		stream
			space;
			nextPutAll: message ]