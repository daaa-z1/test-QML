import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

Button {
    id: topBarBtn

    // CUSTOM PROPERTIES
    property url btnIconSource: ".../images/svg_images/close_icon.svg"
    property color btnColorDefault: "transparent"
    property color btnColorMouseOver: "#005280"
    property color btnColorClicked: "#00a1f1"
    property color textColor: "#ffffff"
    property int iconWidth: 32
    property int iconHeight: 32

    implicitWidth: 100
    implicitHeight: 60

    Material.background: Rectangle {
        color: topBarBtn.down ? btnColorClicked : (topBarBtn.hovered ? btnColorMouseOver : btnColorDefault)

        radius: 5
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.leftMargin: 4
        anchors.rightMargin: 4
        anchors.topMargin: 4
        anchors.bottomMargin: 4

    }

    contentItem: Item {
        anchors.fill: parent
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 24
            width: 24
            fillMode: Image.PreserveAspectFit
            antialiasing: false
            fillMode: Image.PreserveAspectFit
            visible: true
        }
        Rectangle {
            anchors.fill: iconBtn
            color: btnTopBar.down ? "#000000" : ""
            opacity: btnTopBar.down ? 0.5 : 1
        }
    }
}
