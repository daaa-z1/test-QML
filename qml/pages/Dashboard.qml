import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    ListModel {
        id: valueModel
    }

    // Fungsi untuk mengisi nilai minimum
    function setMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
        valueModel.clear()
        valueModel.append({ "value": min1, "min": min1, "max": min2 })
        valueModel.append({ "value": min2, "min": min2, "max": min3 })
        valueModel.append({ "value": min3, "min": min3, "max": min4 })
        valueModel.append({ "value": min4, "min": min4, "max": min5 })
        valueModel.append({ "value": min5, "min": min5, "max": min6 })
        valueModel.append({ "value": min6, "min": min6, "max": min7 })
        valueModel.append({ "value": min7, "min": min7, "max": min8 })
        valueModel.append({ "value": min8, "min": min8, "max": min1 })
    }

    // Fungsi untuk mengisi nilai maksimum
    function setMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
        for (var i = 0; i < valueModel.count; i++) {
            valueModel.setProperty(i, "max", max1);
            if (i < valueModel.count - 1) {
                valueModel.setProperty(i, "max", max1);
            } else {
                valueModel.setProperty(i, "max", max2);
            }
        }
    }

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: valueModel.count > 4 ? Math.ceil(valueModel.count / 2) : valueModel.count

        Repeater {
            model: valueModel

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
                    minimumValue: model.min
                    maximumValue: model.max
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            valueModel.clear()
            valueModel.append({ "value": value1 })
            valueModel.append({ "value": value2 })
            valueModel.append({ "value": value3 })
            valueModel.append({ "value": value4 })
            valueModel.append({ "value": value5 })
            valueModel.append({ "value": value6 })
            valueModel.append({ "value": value7 })
            valueModel.append({ "value": value8 })
        }

        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            setMinValues(min1, min2, min3, min4, min5, min6, min7, min8)
        }

        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            setMaxValues(max1, max2, max3, max4, max5, max6, max7, max8)
        }
    }
}
