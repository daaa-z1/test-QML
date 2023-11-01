import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property real value: 0
    property real minValue: 0
    property real maxValue: 100
    property alias text: valueText.text

    width: 100
    height: 100

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"
        border.color: "#3498db"
        border.width: 3
        radius: Math.min(width, height) / 2 - 10

        Rectangle {
            width: parent.width
            height: parent.height
            color: Qt.rgba(0, 0, 0, 0.1)
        }

        Text {
            id: valueText
            anchors.centerIn: parent
            text: value.toFixed(1)
            font.pixelSize: 20
            color: "#3498db"
        }

        Rotation {
            id: needleRotation
            origin.x: parent.width / 2
            origin.y: parent.height / 2
            angle: (value - minValue) / (maxValue - minValue) * 180
        }

        Rectangle {
            width: 2
            height: parent.height / 2
            color: "red"
            anchors.centerIn: parent
            transform: Rotation {
                angle: -needleRotation.angle
                origin.x: parent.width / 2
                origin.y: parent.height / 2
            }
        }
    }

    Component.onCompleted: {
        needleRotation.angle = (value - minValue) / (maxValue - minValue) * 180;
    }
}
