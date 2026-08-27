
import QtQuick
import Quickshell

Item {
    id: root

    readonly property string home: Quickshell.env("HOME")
    readonly property string xdgRuntimeDir: Quickshell.env("XDG_RUNTIME_DIR")

    readonly property string cacheDir: home + "/.cache/quickshell"
    readonly property string stateDir: home + "/.local/state/quickshell"
    readonly property string runDir: (xdgRuntimeDir !== "" ? xdgRuntimeDir : "/tmp") + "/quickshell"
    readonly property string logDir: runDir + "/logs"

    function getCacheDir(widgetName) {
        var envPath = Quickshell.env("QS_CACHE_" + widgetName.toUpperCase());
        return envPath !== ""
            ? envPath
            : cacheDir + "/" + widgetName;
    }

    function getStateDir(widgetName) {
        var envPath = Quickshell.env("QS_STATE_" + widgetName.toUpperCase());
        return envPath !== ""
            ? envPath
            : stateDir + "/" + widgetName;
    }

    function getRunDir(widgetName) {
        var envPath = Quickshell.env("QS_RUN_" + widgetName.toUpperCase());
        return envPath !== ""
            ? envPath
            : runDir + "/" + widgetName;
    }

    function getLogDir(widgetName) {
        var envPath = Quickshell.env("QS_LOG_" + widgetName.toUpperCase());
        return envPath !== ""
            ? envPath
            : logDir + "/" + widgetName;
    }
}
