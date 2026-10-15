pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    // ============================================================
    // AUDIO
    // ============================================================

    property string volPercent: "0%"
    property string volIcon: "󰕾"
    property bool isMuted: false

    Process {
        id: audioPoller
        running: true

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/audio_fetch.sh"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let txt = this.text.trim();

                if (txt !== "") {
                    try {
                        let data = JSON.parse(txt);

                        root.volPercent = data.volume.toString() + "%";
                        root.volIcon = data.icon;
                        root.isMuted = data.is_muted === "true";
                    } catch (e) {}
                }

                audioWaiter.running = false;
                audioWaiter.running = true;
            }
        }
    }

    Process {
        id: audioWaiter

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/audio_wait.sh"
        ]

        onExited: {
            audioPoller.running = false;
            audioPoller.running = true;
        }
    }


    // ============================================================
    // NETWORK
    // ============================================================

    property string wifiStatus: "Off"
    property string wifiIcon: "󰤮"
    property string wifiSsid: ""
    property string ethStatus: "Ethernet"

    Process {
        id: networkPoller
        running: true

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/network_fetch.sh"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let txt = this.text.trim();

                if (txt !== "") {
                    try {
                        let data = JSON.parse(txt);

                        root.wifiStatus = data.status;
                        root.wifiIcon = data.icon;
                        root.wifiSsid = data.ssid;
                        root.ethStatus = data.eth_status;
                    } catch (e) {}
                }

                networkWaiter.running = false;
                networkWaiter.running = true;
            }
        }
    }

    Process {
        id: networkWaiter

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/network_wait.sh"
        ]

        onExited: {
            networkPoller.running = false;
            networkPoller.running = true;
        }
    }


    // ============================================================
    // BLUETOOTH
    // ============================================================

    property string btStatus: "Off"
    property string btIcon: "󰂲"
    property string btDevice: ""

    Process {
        id: btPoller
        running: true

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/bt_fetch.sh"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let txt = this.text.trim();

                if (txt !== "") {
                    try {
                        let data = JSON.parse(txt);

                        root.btStatus = data.status;
                        root.btIcon = data.icon;
                        root.btDevice = data.connected;
                    } catch (e) {}
                }

                btWaiter.running = false;
                btWaiter.running = true;
            }
        }
    }

    Process {
        id: btWaiter

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/bt_wait.sh"
        ]

        onExited: {
            btPoller.running = false;
            btPoller.running = true;
        }
    }


    // ============================================================
    // BATTERY
    // ============================================================

    property string batPercent: "100%"
    property string batIcon: "󰁹"
    property string batStatus: "Unknown"

    Process {
        id: batteryPoller
        running: true

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/battery_fetch.sh"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let txt = this.text.trim();

                if (txt !== "") {
                    try {
                        let data = JSON.parse(txt);

                        root.batPercent = data.percent.toString() + "%";
                        root.batIcon = data.icon;
                        root.batStatus = data.status;
                    } catch (e) {}
                }

                batteryWaiter.running = false;
                batteryWaiter.running = true;
            }
        }
    }

    Process {
        id: batteryWaiter

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/battery_wait.sh"
        ]

        onExited: {
            batteryPoller.running = false;
            batteryPoller.running = true;
        }
    }


    // ============================================================
    // KEYBOARD
    // ============================================================

    property string kbLayout: "us"

    Process {
        id: kbPoller
        running: true

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/kb_fetch.sh"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let txt = this.text.trim();

                if (txt !== "")
                    root.kbLayout = txt;

                kbWaiter.running = false;
                kbWaiter.running = true;
            }
        }
    }

    Process {
        id: kbWaiter

        command: [
            "bash", "-c",
            "~/.config/quickshell/watchers/kb_wait.sh"
        ]

        onExited: {
            kbPoller.running = false;
            kbPoller.running = true;
        }
    }


    // ============================================================
    // CHASSIS
    // ============================================================

    property bool isDesktop: false

   Process {
        id: chassisDetector
        running: true

        command: [
            "bash", "-c",
            "if ls /sys/class/power_supply/BAT* >/dev/null 2>&1; then echo laptop; else echo desktop; fi"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.isDesktop = this.text.trim() === "desktop";
            }
        }
    }
    // ============================================================
    // WORKSPACES
    // ============================================================

    ListModel {
        id: workspacesModel

        property int activeIndex: 0
    }

    property alias workspaces: workspacesModel

    Process {
        id: wsDaemon
        running: true

        command: [
            "bash", "-c",
            "~/.config/quickshell/scripts/workspaces.sh"
        ]
    }

    Process {
        id: wsReader
        running: true

        command: [
            "cat",
            Caching.getRunDir("workspaces") + "/workspaces.json"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                const txt = this.text.trim();

                if (txt === "")
                    return;

                try {
                    const newData = JSON.parse(txt);

                    while (workspacesModel.count < newData.length) {
                        workspacesModel.append({
                            "wsId": "",
                            "wsState": ""
                        });
                    }

                    while (workspacesModel.count > newData.length) {
                        workspacesModel.remove(workspacesModel.count - 1);
                    }

                    let newActive = -1;

                    for (let i = 0; i < newData.length; i++) {
                        const state = newData[i].state;
                        const id = newData[i].id.toString();

                        if (state === "active")
                            newActive = i;

                        if (workspacesModel.get(i).wsState !== state) {
                            workspacesModel.setProperty(
                                i,
                                "wsState",
                                state
                            );
                        }

                        if (workspacesModel.get(i).wsId !== id) {
                            workspacesModel.setProperty(
                                i,
                                "wsId",
                                id
                            );
                        }
                    }

                    if (
                        newActive !== -1 &&
                        workspacesModel.activeIndex !== newActive
                    ) {
                        workspacesModel.activeIndex = newActive;
                    }

                } catch (e) {}
            }
        }
    }

    Process {
        id: wsWatcher
        running: true

        command: [
            "bash", "-c",
            "inotifywait -qq -e close_write,modify " +
            Caching.getRunDir("workspaces") +
            "/workspaces.json"
        ]

        onExited: {
            wsReader.running = false;
            wsReader.running = true;

            running = false;
            running = true;
        }
    }


    // ============================================================
    // MUSIC / MPRIS
    // ============================================================

    property var musicData: ({
        "status": "Stopped",
        "title": "",
        "artist": "",
        "artUrl": "",
        "timeStr": ""
    })

    property string displayTitle: ""
    property string displayTime: ""
    property string displayArtUrl: ""

    property bool isMediaActive:
        musicData.status !== "Stopped" &&
        musicData.title !== ""

    onMusicDataChanged: {
        if (
            musicData &&
            musicData.status !== "Stopped" &&
            musicData.title !== ""
        ) {
            displayTitle = musicData.title;
            displayTime = musicData.timeStr || "";
            displayArtUrl = musicData.artUrl || "";
        }
    }

    Process {
        id: musicForceRefresh
        running: true

        command: [
            "bash", "-c",
            "bash ~/.config/quickshell/music/music_info.sh"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                const txt = this.text.trim();

                if (txt === "")
                    return;

                try {
                    root.musicData = JSON.parse(txt);
                } catch (e) {}
            }
        }
    }

    Process {
        id: mprisWatcher
        running: true

        command: [
            "bash", "-c",
            "dbus-monitor --session " +
            "\"type='signal',interface='org.freedesktop.DBus.Properties'," +
            "member='PropertiesChanged',arg0='org.mpris.MediaPlayer2.Player'\" " +
            "\"type='signal',interface='org.mpris.MediaPlayer2.Player'," +
            "member='Seeked'\" " +
            "2>/dev/null | grep -m 1 'member=' >/dev/null || sleep 2"
        ]

        onExited: {
            musicForceRefresh.running = false;
            musicForceRefresh.running = true;

            running = false;
            running = true;
        }
    }

    // Update the displayed playback position locally.
    // This avoids running playerctl once every second.
    Timer {
        id: musicClock

        interval: 1000
        repeat: true
        running: root.musicData &&
                 root.musicData.status === "Playing"

        onTriggered: {
            if (
                !root.musicData ||
                root.musicData.status !== "Playing"
            ) {
                return;
            }

            if (
                !root.musicData.timeStr ||
                root.musicData.timeStr.indexOf(" / ") === -1
            ) {
                return;
            }

            const parts = root.musicData.timeStr.split(" / ");

            if (parts.length !== 2)
                return;

            const posParts = parts[0].split(":").map(Number);
            const lenParts = parts[1].split(":").map(Number);

            let posSecs;

            if (posParts.length === 3) {
                posSecs =
                    posParts[0] * 3600 +
                    posParts[1] * 60 +
                    posParts[2];
            } else {
                posSecs =
                    posParts[0] * 60 +
                    posParts[1];
            }

            let lenSecs;

            if (lenParts.length === 3) {
                lenSecs =
                    lenParts[0] * 3600 +
                    lenParts[1] * 60 +
                    lenParts[2];
            } else {
                lenSecs =
                    lenParts[0] * 60 +
                    lenParts[1];
            }

            if (isNaN(posSecs) || isNaN(lenSecs))
                return;

            posSecs = Math.min(posSecs + 1, lenSecs);

            const minutes = Math.floor(posSecs / 60);
            const seconds = posSecs % 60;

            const posStr =
                (minutes < 10 ? "0" : "") +
                minutes +
                ":" +
                (seconds < 10 ? "0" : "") +
                seconds;

            const nextData = Object.assign({}, root.musicData);

            nextData.timeStr =
                posStr + " / " + parts[1];

            nextData.positionStr = posStr;

            if (lenSecs > 0) {
                nextData.percent =
                    (posSecs / lenSecs) * 100;
            }

            root.musicData = nextData;
        }
    }


    // ============================================================
    // RECORDING
    // ============================================================

    property bool isRecording: false

    Process {
        id: recPoller
        running: true

        command: [
            "bash", "-c",
            "if [ -s " +
            Caching.getCacheDir("recording") +
            "/rec_pid ] && kill -0 $(cat " +
            Caching.getCacheDir("recording") +
            "/rec_pid) 2>/dev/null; " +
            "then echo 1; else echo 0; fi"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.isRecording =
                    this.text.trim() === "1";
            }
        }
    }

    Process {
        id: recWatcher
        running: true

        command: [
            "bash", "-c",
            "inotifywait -qq " +
            "-e create,delete,modify,close_write " +
            Caching.getCacheDir("recording") +
            "/ 2>/dev/null || sleep 2"
        ]

        onExited: {
            recPoller.running = false;
            recPoller.running = true;

            running = false;
            running = true;
        }
    }


    // ============================================================
    // UPDATES
    // ============================================================

    property bool updateAvailable: false
    property bool forceUpdateShow: false

    property bool isUpdateVisible:
        updateAvailable || forceUpdateShow

    Process {
        id: updatePoller
        running: true

        command: [
            "bash", "-c",
            "if [ -f " +
            Caching.getCacheDir("updater") +
            "/update_pending ]; " +
            "then echo 1; else echo 0; fi"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.updateAvailable =
                    this.text.trim() === "1";
            }
        }
    }

    Process {
        id: updateWatcher
        running: true

        command: [
            "bash", "-c",
            "inotifywait -qq " +
            "-e create,delete,close_write " +
            Caching.getCacheDir("updater") +
            "/ 2>/dev/null || sleep 5"
        ]

        onExited: {
            updatePoller.running = false;
            updatePoller.running = true;

            running = false;
            running = true;
        }
    }


    // ============================================================
    // CURRENT WIDGET
    // ============================================================

    property string activeWidget: ""

    Process {
        id: widgetPoller
        running: true

        command: [
            "bash", "-c",
            "cat " +
            Caching.runDir +
            "/current_widget 2>/dev/null || echo ''"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.activeWidget =
                    this.text.trim();
            }
        }
    }

    Process {
        id: widgetWatcher
        running: true

        command: [
            "bash", "-c",
            "while [ ! -f " +
            Caching.runDir +
            "/current_widget ]; do " +
            "sleep 1; done; " +
            "inotifywait -qq " +
            "-e modify,close_write " +
            Caching.runDir +
            "/current_widget"
        ]

        onExited: {
            widgetPoller.running = false;
            widgetPoller.running = true;

            running = false;
            running = true;
        }
    }


    // ============================================================
    // SETTINGS
    // ============================================================

    property bool showHelpIcon: true
    property int workspaceCount: 8

    Process {
        id: settingsReader
        running: true

        command: [
            "bash", "-c",
            "cat ~/.config/hypr/settings.json " +
            "2>/dev/null || echo '{}'"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                const txt = this.text.trim();

                if (
                    txt === "" ||
                    txt === "{}"
                ) {
                    return;
                }

                try {
                    const parsed = JSON.parse(txt);

                    if (
                        parsed.topbarHelpIcon !== undefined
                    ) {
                        root.showHelpIcon =
                            parsed.topbarHelpIcon;
                    }

                    if (
                        parsed.workspaceCount !== undefined
                    ) {
                        root.workspaceCount =
                            parsed.workspaceCount;
                    }

                } catch (e) {}
            }
        }
    }

    Process {
        id: settingsWatcher
        running: true

        command: [
            "bash", "-c",
            "while [ ! -f " +
            "~/.config/hypr/settings.json ]; do " +
            "sleep 1; done; " +
            "inotifywait -qq " +
            "-e modify,close_write " +
            "~/.config/hypr/settings.json"
        ]

        onExited: {
            settingsReader.running = false;
            settingsReader.running = true;

            running = false;
            running = true;
        }
    }
}
