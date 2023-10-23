import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

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

    TopBar {
        id: topBar
        anchors.top: parent.top
        width: parent.width
        // Tambahkan nama aplikasi, tanggal, waktu, ikon minimize, dan close di sini
    }
}
