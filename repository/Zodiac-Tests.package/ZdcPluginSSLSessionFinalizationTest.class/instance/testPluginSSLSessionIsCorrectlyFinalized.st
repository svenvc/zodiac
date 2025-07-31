tests
testPluginSSLSessionIsCorrectlyFinalized

	| previousState afterState |
	client := ZnClient new.
	client url: 'https://www.google.com'.
	client method: #GET.
	client execute.
	client response.

	clone := client connection sslSession clone.

	previousState := clone serverName.

	client := nil.
	3 timesRepeat: [ Smalltalk garbageCollect ].

	afterState := clone serverName.

	self deny: previousState equals: afterState