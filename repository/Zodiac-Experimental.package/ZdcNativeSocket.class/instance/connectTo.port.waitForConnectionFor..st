initialize-release
connectTo: hostAddress port: portNumber waitForConnectionFor: seconds
	^ nativeSocket
		connectTo: hostAddress 
		port: portNumber 
		waitForConnectionFor: seconds