testing
testSecureSocketStreamClass
	self
		assert: ZnNetworkingUtils default secureSocketStreamClass 
		equals: ZdcDebugSecureSocketStream