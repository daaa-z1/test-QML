import QtQuick 2.11
import QtQuick.Controls 2.11
import QtGraphicalEffects 1.0

ApplicationWindow {
    visible: true
    width: Screen.width
    height: Screen.height
    title: "Aplikasi Uji Servo Valve"

    // Splash Screen
    Rectangle {
        id: splashScreen
        width: parent.width
        height: parent.height
        color: "#0D47A1" // Warna biru gelap

        // Gradasi
        gradient: Gradient {
            GradientStop { position: 0; color: "#0D47A1" }
            GradientStop { position: 1; color: "#1565C0" }
        }

        Text {
            text: "Aplikasi Uji Servo Valve"
            font.pixelSize: 24
            color: "white"
            anchors.centerIn: parent
        }

        ProgressBar {
            id: loadingProgress
            width: parent.width * 0.5
            height: 20
            anchors.centerIn: parent
            value: 0 // Ganti nilai ini selama loading
            from: 0
            to: 100
        }
    }

    Connections {
        target: loadingProgress
        onValueChanged: {
            if (loadingProgress.value === 100) {
                // Loading selesai, arahkan ke halaman utama
                var component = Qt.createComponent("Dashboard.qml")
                if (component.status === Component.Ready) {
                    var dashboard = component.createObject(splashScreen)
                    if (dashboard !== null) {
                        dashboard.showFullScreen()
                        splashScreen.destroy()
                    }
                }
            }
        }
    }
}
