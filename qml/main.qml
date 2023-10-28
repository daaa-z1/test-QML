import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import "controls" 

ApplicationWindow {
    visible: true
    width: screen.width
    height: screen.height
    title: "Aplikasi Uji Servo Valve Hydraulic"

    // StackView untuk tampilan
    StackView {
        id: stackView
        initialItem: Loader {
            source: "qml/pages/Dashboard.qml"
        }
    }

    Rectangle {
        id: content
        color: "#00000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0

        Rectangle {
            id: leftMenu
            width: 60
            color: "#1c1d20"
            radius: 10
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            clip: true
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0

            PropertyAnimation {
                id: animationMenu
                target: leftMenu
                property: "width"
                to: leftMenu.width === 60 ? 180 : 60
                duration: 500
                easing.type: Easing.InOutQuint
            }

            Column {
                id: columnMenus
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                clip: true
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 90
                anchors.topMargin: 0

                LeftMenuBtn {
                    id: btnHome
                    width: leftMenu.width
                    text: "<font color='#b0b0b0'>" + "Switches" + "</font>"
                    font.bold: true
                    font.pointSize: 10
                    btnIconSource: "../images/svg_images/cil-touch-app.svg"
                    onClicked: {
                        // Implementasikan aksi yang sesuai
                    }
                }
                // Sisipkan LeftMenuBtn lainnya di sini sesuai kebutuhan

                LeftMenuBtn {
                    id: btnSettings
                    width: leftMenu.width
                    text: "<font color='#b0b0b0'>" + "Settings" + "</font>"
                    font.bold: true
                    font.pointSize: 10
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    btnIconSource: "../images/svg_images/settings_icon.svg"
                    onClicked: {
                        // Implementasikan aksi yang sesuai
                    }
                }
            }
        }
    }

    Rectangle {
        id: topBar
        color: "#1E2C3C" // Warna biru gelap
        height: 60
        anchors.top: parent.top
        width: parent.width

        TopBarBtn {
            id: closeBtn
            text: ""
            btnIconSource: "../images/svg_images/close_icon.svg"
            btnColorDefault: "transparent"
            btnColorMouseOver: "#005280"
            btnColorClicked: "#00a1f1"
            textColor: "#ffffff"
            iconWidth: 32
            iconHeight: 32

            anchors.left: topBar.left
            anchors.leftMargin: 10
            anchors.verticalCenter: topBar.verticalCenter

            onClicked: {
                // Handle tombol close di sini
                Qt.quit();
            }
        }

        TopBarBtn {
            id: minimizeBtn
            text: ""
            btnIconSource: "../images/svg_images/minimize_icon.svg"
            btnColorDefault: "transparent"
            btnColorMouseOver: "#005280"
            btnColorClicked: "#00a1f1"
            textColor: "#ffffff"
            iconWidth: 32
            iconHeight: 32

            anchors.left: closeBtn.right
            anchors.leftMargin: 10
            anchors.verticalCenter: topBar.verticalCenter

            onClicked: {
                // Handle tombol minimize di sini
                ApplicationWindow.windowState = Qt.WindowMinimized;
            }
        }
    }
}