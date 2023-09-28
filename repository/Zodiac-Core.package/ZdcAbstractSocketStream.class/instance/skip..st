stream in
skip: count
	"Skip over count bytes.
	This is an inefficient abstract implementation skipping bytes one by one."

	count < 0 ifTrue: [ self error: 'cannot skip backwards' ].
	count timesRepeat: [ self next ]