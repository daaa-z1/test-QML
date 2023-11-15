import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.15

import "../controls"

Page {
    id: dashboardPage

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: 5

        Repeater {
            id: repeater
            model: keys.length

            Rectangle {
                id: container
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                radius: width * 0.1

                property var parameters: ["Pressure In", "Pressure A", "Pressure B", "Flow", "Temperature", "Curr V", "Actual", "Curr MA", "Pressure Com", "Pressure Aktual"]
                property var units: ["Bar", "Bar", "Bar", "Bar", "°C", "V", "V", "Ma", "Bar", "Bar"]

                CircleGauge {
                    id: gauge
                    objectName: "gauge" + index
                    anchors.centerIn: parent
                    width: container.width * 0.8
                    height: width
                    label: container.parameters[index]
                    unit: container.units[index]

                    minValue: mainApp.parameter[keys[index]].minValue
                    maxValue: mainApp.parameter[keys[index]].maxValue
                    value: mainApp.value[keys[index]]
                }
            }
        }
    }

    property var keys: ['press_in', 'press_a', 'press_b', 'flow', 'temp', 'curr_v', 'aktual', 'curr_ma', 'press_comm', 'press_actual']
}
