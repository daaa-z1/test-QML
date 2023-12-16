import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {
    width: parent.width
    height: parent.height
    color: "lightblue"

    Image {
        id: image1
        source: "src/image/Moog.svg"  // Ganti dengan path ke gambar Anda
        anchors.centerIn: parent
        opacity: 1

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PauseAnimation { duration: 2000 }
            NumberAnimation { to: 0; duration: 1000; easing.type: Easing.InOutQuad }
            PauseAnimation { duration: 2000 }
            NumberAnimation { to: 1; duration: 1000; easing.type: Easing.InOutQuad }
        }
    }

    Image {
        id: image2
        source: "src/image/TSH.gif"  // Ganti dengan path ke gambar Anda
        anchors.centerIn: parent
        opacity: 0

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PauseAnimation { duration: 2000 }
            NumberAnimation { to: 1; duration: 1000; easing.type: Easing.InOutQuad }
            PauseAnimation { duration: 2000 }
            NumberAnimation { to: 0; duration: 1000; easing.type: Easing.InOutQuad }
        }
    }

    ProgressBar {
        id: progressBar
        width: 200
        height: 20
        value: 0
        from: 0
        to: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 100  // Ganti dengan jarak yang Anda inginkan dari pusat

        Timer {
            interval: 50; running: true; repeat: true
            onTriggered: {
                progressBar.value += 1
                if (progressBar.value === progressBar.to) {
                    progressBar.value = progressBar.from
                }
            }
        }
    }
}
