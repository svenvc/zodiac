tests
testString
	| ioBuffer |
	ioBuffer := ZdcIOBuffer on: (String new: 10).
	($a to: $f) do: [ :each | ioBuffer nextPut: each ].
	self assert: ioBuffer contents equals: 'abcdef'.
	($a to: $f) do: [ :each | self assert: ioBuffer next equals: each ]