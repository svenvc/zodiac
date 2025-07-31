initialization
initialize
	"Initialize the receiver"

	super initialize.

	[ handle := self primitiveSSLCreate ]
		on: (ZdcUtils exceptionSet: #( #SocketError #PrimitiveFailed ))
		do: [ :exception | "Give a more human friendly error message"
			ZdcPluginMissing signal ].

	self finalizationRegistry add: self.

	self logging: false