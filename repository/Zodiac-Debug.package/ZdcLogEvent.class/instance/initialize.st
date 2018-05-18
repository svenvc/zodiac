initialize-release
initialize 
	super initialize.
	timestamp := DateAndTime now asUTC.
	pid := ZnUtils currentProcessID