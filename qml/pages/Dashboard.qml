import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.15

import "../controls"

Page {
    id: dashboardPage
    property alias repeater: repeater
    

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
                color: "dark grey"
                radius: width * 0.1
                gradient: Gradient.RiskyConcrete
                layer.enabled: true
                layer.effect: InnerShadow {
                    samples: 24
                    color: "#000000"
                    radius: 16
                    spread: 0
                    horizontalOffset: -5
                    verticalOffset: -5
                }

                property var parameters: ["Pressure In", "Pressure A", "Pressure B", "Flow", "Temperature", "Comm V", "Actual", "Comm MA", "Comm Press", "Actual Press"]
                property var units: ["Bar", "Bar", "Bar", "Bar", "°C", "V", "V", "Ma", "Bar", "Bar"]

                Button {
                    anchors{
                        top: parent.top
                        left: parent.left
                        margins: 20
                    }
                    background: Rectangle {
                        radius: width / 2
                        color: gauge.enabled ? "#FF6961" : "#77DD77"
                    }
                    onClicked: gauge.enabled = !gauge.enabled
                }

                Text {
                    text: container.parameters[index]
                    horizontalAlignment: Text.alignmentHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: parent.height * 0.1
                }

                CircleGauge {
                    id: gauge
                    objectName: "gauge" + index
                    anchors.centerIn: parent
                    width: container.width * 0.8
                    height: width
                    unit: container.units[index]
                    minValue: mainApp.parameter(keys[index], 'minValue')
                    maxValue: mainApp.parameter(keys[index], 'maxValue')
                    value: !enabled ? mainApp.value[keys[index]] : 0
                    enabled: gaugeEnabled
                }
            }
        }
    }

    property var keys: ['press_in', 'press_a', 'press_b', 'flow', 'temp', 'curr_v', 'aktual', 'curr_ma', 'press_comm', 'press_actual']
    property bool gaugeEnabled: false
}
