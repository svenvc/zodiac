instance creation
openConnectionToHostNamed: hostName port: portNumber
	| platformSocket socketStream hostIPAddress |
	platformSocket := Socket newTCP.
	socketStream := self on: platformSocket.
	hostIPAddress := NetNameResolver addressForName: hostName timeout: socketStream timeout.
	(hostIPAddress isNil or: [ hostIPAddress = SocketAddress zero ])
		ifTrue: [ ^ NameLookupFailure signalFor: hostName ].
	^ socketStream 
		connectTo: hostIPAddress port: portNumber;
		yourself