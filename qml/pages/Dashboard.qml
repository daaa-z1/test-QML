import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    property var updateGauge: [0, 0, 0, 0, 0, 0, 0, 0]

    function updateValue(channel, value) {
        updateGauge[channel] = value;
        // Pemicu perubahan pada updateGauge
        updateGauge = updateGauge.slice(0); // Ini akan memicu pembaruan
    }

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: updateGauge.length > 4 ? updateGauge.length / 2 : updateGauge.length

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
        function onNewValue(channel, value) {
            console.log("Channel: " + channel + ", Value: " + value);
            updateValue(channel, value);
        }
    }
}
