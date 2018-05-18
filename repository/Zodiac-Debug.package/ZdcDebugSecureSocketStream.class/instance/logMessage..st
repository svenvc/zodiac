private
logMessage: message
	ZdcObjectLog default
		add: (ZdcLogEvent message: message)