accessing
socketClass
	^ socketClass ifNil: [ socketClass := Socket ]