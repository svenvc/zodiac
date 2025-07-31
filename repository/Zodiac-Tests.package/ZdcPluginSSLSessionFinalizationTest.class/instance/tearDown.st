running
tearDown

	client ifNotNil: [ client close ].
	clone ifNotNil: [
		[ clone destroy ]
			on: PrimitiveFailed
			do: [ "I ignore, because if the test works... it has been alread done"
			#ignore ] ].

	super tearDown