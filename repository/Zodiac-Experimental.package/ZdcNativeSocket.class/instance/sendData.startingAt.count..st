accessing
sendData: bytes startingAt: index count: count
	^ nativeSocket
		sendData: bytes 
		startingAt: index 
		count: count