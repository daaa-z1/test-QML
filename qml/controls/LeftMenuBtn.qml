import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

Button {
    id: btnLeftMenu
    text: qsTr("Left Menu Text")

    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_images/home_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#005280"
    property color btnColorClicked: "#00a1f1"
    property int iconWidth: 32
    property int iconHeight: 32
    property color activeMenuColor: "#1c1d20"
    property color activeMenuColorRight: "#55aaff"
    property bool isActiveMenu: false

    property color imgColorActived: "#23272E"
    property color imgColorDefault: "#00a1f1"

    implicitWidth: 250
    implicitHeight: 60

    Material.background: Rectangle {
        color: btnLeftMenu.down ? btnColorClicked : (btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault)
        Rectangle {
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            color: activeMenuColor
            width: 5
            visible: isActiveMenu
        }

        Rectangle {
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            color: activeMenuColorRight
            width: 5
            visible: isActiveMenu
        }
    }

    contentItem: Item {
        anchors.fill: parent
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight
            fillMode: Image.PreserveAspectFit
            visible: false
        }

        Rectangle {
            anchors.fill: iconBtn
            color: isActiveMenu ? activeMenuColorRight : "#909090"
            width: iconWidth
            height: iconHeight
        }

        Text {
            color: "#ffffff"
            text: btnLeftMenu.text
            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
        }
    }
}
