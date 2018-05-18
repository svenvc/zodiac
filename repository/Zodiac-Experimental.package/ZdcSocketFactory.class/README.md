I am ZdcSocketFactory.

My class side is a facade, my instance side is a factory.

Use my #newTCP class method to instanciate new TCP sockets.

See the ZdcAbstractSocketStream 'private socket' method category 
for the protocol expected from sockets:

	#connectTo:port:waitForConnectionFor:
	#close
	#isConnected
	#isOtherEndClosed
	#dataAvailable
	#sendSomeData:startIndex:count:
	#primSocket:receiveDataInto:startingAt:count:
	#waitForDataFor:
	#waitForSendDoneFor:
	
This is based on the existing methods of Socket, a protocol with nicer names 
could probably be added in the future. Possibly using a wrapper.