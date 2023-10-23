import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

ApplicationWindow {
    visible: true
    width: screen.width
    height: screen.height
    title: "Aplikasi Uji Servo Valve Hydraulic"

    StackView {
        id: stackView
        initialItem: Item {
            Component.onCompleted: {
                // Tampilkan splash screen saat aplikasi dimulai
                stackView.push(splashComponent);
                // Simulasikan loading screen selesai
                var progressBar = splashComponent.item.progressBarItem;
                if (progressBar) {
                    progressBar.from = 0;
                    progressBar.to = 100;
                    progressBar.value = 0;
                    progressBar.running = true;
                    progressBar.runningChanged.connect(function () {
                        if (!progressBar.running) {
                            stackView.pop(); // Hapus splash screen
                            stackView.push(dashboard);
                        }
                    });
                }
            }
        }
    }

    // Komponen Splash Screen
    Component {
        id: splashComponent
        Splash {}
    }

    MenuBar {
        Menu {
            title: "Page"
            MenuItem {
                text: "Dashboard"
                onTriggered: stackView.push(dashboard);
            }
            MenuItem {
                text: "Graph"
                onTriggered: stackView.push(Graph);
            }
            MenuItem {
                text: "History"
                onTriggered: stackView.push(History);
            }
            MenuItem {
                text: "Pengaturan"
                onTriggered: stackView.push(Settings);
            }
        }
    }
}
