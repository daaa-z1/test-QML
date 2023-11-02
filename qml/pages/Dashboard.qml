import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

Page {
    id: dashboardPage

    property var ainData: [
        { label: "Pressure A", value: 30, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 50, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 70, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 40, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 60, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 20, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 80, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 90, minValue: 0, maxValue: 100 }
    ]

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: ainData.length > 4 ? ainData.length / 2 : ainData.length

        Repeater {
            model: ainData.length

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                CircularGauge {
                    id: gauge
                    anchors.centerIn: parent
                    width : parent.width * 0.8
                    height : parent.height * 0.8

                    value : ainData[index].value
                    minimumValue : ainData[index].minValue
                    maximumValue : ainData[index].maxValue

                    Label {
                        text : ainData[index].label
                        font.pixelSize : Math.min(width, height) * 0.1
                        color : "#3498db"
                        anchors.centerIn : parent
                    }
                }
            }
        }
    }
}
