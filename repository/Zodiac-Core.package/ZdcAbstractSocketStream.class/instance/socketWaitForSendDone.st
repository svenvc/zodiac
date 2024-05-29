private - socket
socketWaitForSendDone
	"Compatibility shim for Pharo <11, where #waitForSendDone: returns a boolean
	indicating success, rather than signaling exceptions on failure.
	A true return (in P11) or nothing/self (in P12) both indicate success,
	so check for specifically false."

	(socket waitForSendDoneFor: self timeout) == false ifTrue: [
		ConnectionTimedOut signal: 'Data send timed out.' ]