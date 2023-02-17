tests - compact
testCompactDoNothing
	| ioBuffer |
	ioBuffer := ZdcIOBuffer on: (ByteArray new: 10).
	self assert: ioBuffer isEmpty.
	self assert: ioBuffer availableForReading equals: 0.
	self assert: ioBuffer availableForWriting equals: 10.
	ioBuffer compact.
	self assert: ioBuffer isEmpty.
	self assert: ioBuffer availableForReading equals: 0.
	self assert: ioBuffer availableForWriting equals: 10.
	1 to: 6 do: [ :each | ioBuffer nextPut: each ].
	self deny: ioBuffer isEmpty.
	self assert: ioBuffer availableForReading equals: 6.
	self assert: ioBuffer availableForWriting equals: 4.
	ioBuffer compact.
	self deny: ioBuffer isEmpty.
	self assert: ioBuffer availableForReading equals: 6.
	self assert: ioBuffer availableForWriting equals: 4