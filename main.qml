import QtQuick 2.11
import QtQuick.Controls 2.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "LabJack U6 AIN0 Reader"

    Rectangle {
        width: parent.width
        height: parent.height

        Text {
            text: "AIN0 Value: " + labjackReader.ain0.toFixed(2)
            anchors.centerIn: parent
        }
    }
}
