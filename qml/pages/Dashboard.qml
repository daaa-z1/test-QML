import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    ListProperty<CircularGaugeData> gaugeData: []

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: gaugeData.length > 4 ? Math.ceil(gaugeData.length / 2) : gaugeData.length

        Repeater {
            model: gaugeData

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

                    value: model.value
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            gaugeData = [
                { "value": value1 },
                { "value": value2 },
                { "value": value3 },
                { "value": value4 },
                { "value": value5 },
                { "value": value6 },
                { "value": value7 },
                { "value": value8 }
            ]
        }
    }
}
