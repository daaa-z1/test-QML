import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {
    width: 360
    height: 360
    color: "lightblue"

    ProgressBar {
        id: progressBar
        width: 200
        height: 20
        value: 0
        to: 0
        from: 100
        anchors.centerIn: parent

        Timer {
            interval: 50; running: true; repeat: true
            onTriggered: {
                progressBar.value += 1
                if (progressBar.value === progressBar.maximumValue) {
                    progressBar.value = progressBar.minimumValue
                }
            }
        }
    }
}
