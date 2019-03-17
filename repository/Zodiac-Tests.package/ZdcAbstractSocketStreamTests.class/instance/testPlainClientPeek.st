testing
testPlainClientPeek
	| dataSent first peek peekForFalse peekForTrue second clientStream semaphore |
	dataSent := #[ 6 5 4 3 2 1 ].
	semaphore := self runServer: [ :serverSocket :mySemaphore | | clientSocket serverStream |
		clientSocket := serverSocket waitForAcceptFor: 10.
		serverStream := self referenceSocketStreamOn: clientSocket.
		serverStream nextPutAll: dataSent.
		serverStream close.
		mySemaphore signal ].
	clientStream := self openConnectionToHost: #[ 127 0 0 1 ] port: self port.
	first := clientStream next.
	peek := clientStream peek.
	peekForFalse := clientStream peekFor: 32.
	peekForTrue := clientStream peekFor: 5.
	second := clientStream next.
	clientStream close.
	semaphore wait.
	self assert: first equals: 6.
	self assert: peek equals: 5.
	self deny: peekForFalse.
	self assert: peekForTrue.
	self assert: second equals: 4.
	semaphore wait