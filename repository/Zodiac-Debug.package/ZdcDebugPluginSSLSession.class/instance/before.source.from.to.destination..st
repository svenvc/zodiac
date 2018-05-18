private
before: operation source: source from: start to: stop destination: destination
	ZdcObjectLog default
		add: ((ZdcSSLSessionOperationStart message: operation)
				source: source copy;
				start: start;
				stop: stop;
				destination: destination copy;
				yourself)