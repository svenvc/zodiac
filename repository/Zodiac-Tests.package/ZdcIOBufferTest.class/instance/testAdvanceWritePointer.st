tests
testAdvanceWritePointer
	| ioBuffer offset |
	ioBuffer := ZdcIOBuffer on: (ByteArray new: 10).
	self assert: ioBuffer isEmpty.
	offset := ioBuffer freeSpaceStart.
	1 to: 6 do: [ :each |
		ioBuffer buffer at: offset + each - 1 put: each ].
	ioBuffer advanceWritePointer: 6.
	self deny: ioBuffer isEmpty.
	self assert: ioBuffer availableForReading equals: 6.
	self assert: ioBuffer contents equals: #[1 2 3 4 5 6]