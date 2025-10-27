baselines
baseline: spec
	<baseline>
	spec for: #'common' do: [
		spec 
			package: 'Zodiac-Core';
			package: 'Zodiac-Debug';
			package: 'Zodiac-Extra';
			package: 'Zodiac-Experimental';
			package: 'Zodiac-Tests'.
		spec 
			group: 'Core' with: #('Zodiac-Core');
			group: 'Extra' with: #('Zodiac-Extra');
			group: 'Experimental' with: #('Zodiac-Experimental');
			group: 'Debug' with: #('Zodiac-Debug');
			group: 'Tests' with: #('Zodiac-Tests');
			group: 'default' with: #('Core' 'Extra' 'Tests') ]