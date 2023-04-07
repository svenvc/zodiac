initialize-release
skipRequireStartSSL
	"Normally, the server advertises is capabilities before the upgrade from plain to TLS.
	It should list STARTTLS as one of its capabilities. If not, we signal an error.
	The option skipRequireStartTLS allows for this test to be skipped,
	assuming STARTTLS capability even though it was not advertised."

	skipRequireStartTLS := true