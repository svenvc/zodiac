tests
testWriting
	| ioBuffer |
	ioBuffer := ZdcIOBuffer on: (ByteArray new: 10).
	self assert: ioBuffer isEmpty.
	self assert: ioBuffer size isZero.
	self assert: ioBuffer availableForWriting equals: 10.
	1 to: 6 do: [ :each | ioBuffer nextPut: each ].
	self assert: ioBuffer contents equals: #[1 2 3 4 5 6].
	self assert: ioBuffer size equals: 6.
	self assert: ioBuffer availableForWriting equals: 4.
	7 to: 10 do: [ :each | ioBuffer nextPut: each ].
	self assert: ioBuffer isFull.
	self should: [ ioBuffer nextPut: 1 ] raise: Error