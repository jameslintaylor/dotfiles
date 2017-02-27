module.exports = {

	config: {

		shell: '/usr/local/bin/fish',

		fontSize: 12,
		fontFamily: 'Share Tech Mono, Source Code Pro, Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',
		cursorColor: 'white',
		cursorShape: 'BLOCK',

		// ANSI 16 color override based on https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
		
		backgroundColor: '#002b36',
		foregroundColor: '#93a1a1',

		colors: {
			lightBlack: '#002b36',
			black: '#073642',
			lightGreen: '#586e75',
			lightYellow: '#657b83',
			lightBlue: '#839496',
			lightCyan: '#93a1a1',
			white: '#eee8d5',
			lightWhite: '#fdf6e3',
			yellow: '#b58900',
			lightRed: '#cb4b16',
			red: '#d30102',
			magenta: '#d33682',
			lightMagenta: '#6c71c4',
			blue: '#268bd2',
			cyan: '#2aa198',
			green: '#859900'
		},

		modifierKeys: {
			altIsMeta: true
		},

		hyperTabs: {
			border: true,
			activityColor: 'yellow',
		},

		hypertermCrosshair: {
			color: 'rgba(255, 255, 255, 0.05)',
		},

		hyperBorder: {
			borderWidth: '3px',
		}
	},

	plugins: [
		'hyper-tabs-enhanced',
		'hyperborder',
		'hyper-blink',
		'hyperterm-cursor',
		'hyperterm-crosshair',
	],

	// in development, you can create a directory under
	// `~/.hyperterm_modules/local/` and include it here
	// to load it and avoid it being `npm install`ed
	localPlugins: [
		'playground'
	]
};
