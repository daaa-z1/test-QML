import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: "Contoh Aplikasi"

    Grid {
        columns: 3
        spacing: 20
        anchors.centerIn: parent

        Dial {
            id: voltageDial
            from: 0
            to: 220
            value: 110
            stepSize: 1
            snapMode: Dial.SnapOnRelease
        }

        Dial {
            id: currentDial
            from: 0
            to: 1000
            value: 500
            stepSize: 1
            snapMode: Dial.SnapOnRelease
        }

        Dial {
            id: pressureDial
            from: 0
            to: 100
            value: 50
            stepSize: 1
            snapMode: Dial.SnapOnRelease
        }
    }
}
