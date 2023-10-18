import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "LabJack U6 AIN0 Reader"

    Button {
        id: button
        text: "Read AIN0"
        onClicked: labjack.readAIN0()
    }

    Label {
        id: label
        text: "AIN0: " + labjack.ain0
        anchors.top: button.bottom
    }
}
