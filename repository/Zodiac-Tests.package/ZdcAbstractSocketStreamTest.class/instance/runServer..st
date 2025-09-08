private
runServer: block
	| serverSocket semaphore |
	serverSocket := self serverSocketOn: 0.
	self assert: serverSocket notNil.
	serverPort := serverSocket port.
	
	semaphore := Semaphore new.
	[
	semaphore signal.
	[ block cull: serverSocket cull: semaphore ]
		ensure: [
			serverSocket closeAndDestroy.
			semaphore signal ] ] forkAt: self serverPriority.
	semaphore wait.
	^ semaphore