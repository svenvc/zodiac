initialization
destroy

	"Destroys the platform handle in the VM plugin"

	handle ifNil: [ ^ self ].
	self primitiveSSLDestroy: handle.
	handle := nil