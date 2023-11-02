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
    }

    ColumnLayout {
        anchors.fill: parent

        Repeater {
            model: ainData.length
            Item {
                Layout.fillWidth: true

                CircularGauge {
                    id: gauge
                    Layout.fillWidth: true
                    value: ainData[index].value
                    minimumValue: ainData[index].minValue
                    maximumValue: ainData[index].maxValue

                    Label {
                        text: ainData[index].label
                        font.pixelSize: 20
                        color: "#3498db"
                    }
                }
            }
        }
    }
}
