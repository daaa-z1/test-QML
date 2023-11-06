import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    property var updateGauge: [0, 0, 0, 0, 0, 0, 0, 0]

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: updateGauge.length > 4 ? Math.ceil(updateGauge.length / 2) : updateGauge.length

        Repeater {
            model: updateGauge.length

            Rectangle {
                id: container
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                radius: width * 0.1

                CircularGauge {
                    id: gauge
                    anchors.centerIn: parent
                    width: container.width * 0.8
                    height: width

                    value: updateGauge[index]
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value) {
            for (var i = 0; i < value.length; i++) {
                updateGauge[i] = value[i]
            }
        }
    }
}
