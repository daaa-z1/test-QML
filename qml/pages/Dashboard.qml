Page {
    id: dashboardPage

    ListModel {
        id: gaugeModel
    }
    property var daftar_min: []
    property var daftar_max: []

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: gaugeModel.count > 4 ? Math.ceil(gaugeModel.count / 2) : gaugeModel.count

        Repeater {
            model: gaugeModel

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
                    minimumValue: daftar_min[index]
                    maximumValue: daftar_max[index]
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            gaugeModel.clear()
            gaugeModel.append({"value": value1})
            gaugeModel.append({"value": value2})
            gaugeModel.append({"value": value3})
            gaugeModel.append({"value": value4})
            gaugeModel.append({"value": value5})
            gaugeModel.append({"value": value6})
            gaugeModel.append({"value": value7})
            gaugeModel.append({"value": value8})
        }
    }

    Connections {
        target: ainReader
        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            daftar_min = [min1, min2, min3, min4, min5, min6, min7, min8]
        }
    }

    Connections {
        target: ainReader
        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            daftar_max = [max1, max2, max3, max4, max5, max6, max7, max8]
        }
    }
}
