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
        maximumValue: 100
        minimumValue: 0
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
