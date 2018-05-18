testing
isConnected
	^ nativeSocket isConnected
		and: [ nativeSocket isOtherEndClosed not ]