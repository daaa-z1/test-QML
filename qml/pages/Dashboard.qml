import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    ListModel {
        id: gaugeModel
    }

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: gaugeModel.count > 4 ? Math.ceil(gaugeModel.count / 2) : gaugeModel.count

        Repeater {
            model: gaugeModel.count

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

                    value: gaugeModel.get(index).value
                    minimumValue: gaugeModel.get(index).min
                    maximumValue: gaugeModel.get(index).max
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            gaugeModel.clear()
            gaugeModel.append({"value": value1, "min": ainReader.daftar_min(0), "max": ainReader.daftar_max(0)})
            gaugeModel.append({"value": value2, "min": ainReader.daftar_min(1), "max": ainReader.daftar_max(1)})
            gaugeModel.append({"value": value3, "min": ainReader.daftar_min(2), "max": ainReader.daftar_max(2)})
            gaugeModel.append({"value": value4, "min": ainReader.daftar_min(3), "max": ainReader.daftar_max(3)})
            gaugeModel.append({"value": value5, "min": ainReader.daftar_min(4), "max": ainReader.daftar_max(4)})
            gaugeModel.append({"value": value6, "min": ainReader.daftar_min(5), "max": ainReader.daftar_max(5)})
            gaugeModel.append({"value": value7, "min": ainReader.daftar_min(6), "max": ainReader.daftar_max(6)})
            gaugeModel.append({"value": value8, "min": ainReader.daftar_min(7), "max": ainReader.daftar_max(7)})
        }
    }
}
