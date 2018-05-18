private
after: operation result: result destination: destination
	ZdcObjectLog default
		add: ((ZdcSSLSessionOperationStop message: operation)
				result: result;
				destination: destination copy;
				yourself)