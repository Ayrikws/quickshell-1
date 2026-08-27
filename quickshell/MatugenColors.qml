import QtQuick
import Quickshell
import Quickshell.Io

Item {
	id: root


				property color base: "#1f1f28"
				property color mantle: "#181820"
				property color crust: "#121219"
				property color text: "#dcd7ba"
				property color subtext0: "#a6a69c"
				property color subtext1: "#c8c093"
				property color surface0: "#2a2a37"
				property color surface1: "#363646"
				property color surface2: "#54546d"
				property color overlay0: "#727169"
				property color overlay1: "#7e788e"
				property color overlay2: "#938aa9"
				property color blue: "#7e9cd8"
				property color sapphire: "#7fb4ca"
				property color peach: "#ffa066"
				property color green: "#98bb6c"
				property color red: "#c34043"
				property color mauve: "#e4d5ac"
				property color pink: "#d27e99"
				property color yellow: "#e6c384"
				property color maroon: "#e82424"
				property color teal: "#6a9589"	
				property string rawJson: ""

	Process {
		id: themeReader
		command: ["cat", "/tmp/qs_colors.json"]
		stdout: StdioCollector {
			onStreamFinished: {
				let txt = this.text.trim();
				if (txt !== "" && txt !== root.rawJson) {
					root.rawJson = txt;
					try {
						let c = JSON.parse(txt);
						if (c.base) root.base = c.base;
						if (c.mantle) root.mantle = c.mantle;
						if (c.crust) root.crust = c.crust;
						if (c.text) root.text = c.text;
						if (c.subtext0) root.subtext0 = c.subtext0;
						if (c.subtext1) root.subtext1 = c.subtext1;
						if (c.surface0) root.surface0 = c.surface0;
						if (c.surface1) root.surface1 = c.surface1;
						if (c.surface2) root.surface2 = c.surface2;
						if (c.overlay0) root.overlay0 = c.overlay0;
						if (c.overlay1) root.overlay1 = c.overlay1;
						if (c.overlay2) root.overlay2 = c.overlay2;
						if (c.blue) root.blue = c.blue;
						if (c.sapphire) root.sapphire = c.sapphire;
						if (c.peach) root.peach = c.peach;
						if (c.green) root.green = c.green;
						if (c.red) root.red = c.red;
						if (c.mauve) root.mauve = c.mauve;
						if (c.pink) root.pink = c.pink;
						if (c.yellow) root.yellow = c.yellow;
						if (c.maroon) root.maroon = c.maroon;
						if (c.teal) root.teal = c.teal;
					} catch(e) {}
				}
			}
		}
	}

	Timer {
		interval: 1000 
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: themeReader.running = true
	}
}
