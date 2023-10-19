import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 200
    title: "LabJack U6 AIN0 Reader"

    Rectangle {
        anchors.fill: parent
        color: "lightgray"

        Text {
            anchors.centerIn: parent
            text: "AIN0 Value: " + u6Value
        }
    }
}
