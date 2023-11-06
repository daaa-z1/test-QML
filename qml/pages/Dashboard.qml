import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    // Fungsi untuk nilai aktual
    function updateValue(index, value) {
        gaugeModel.setProperty(index, "value", value);
    }

    // Fungsi untuk nilai minimum
    function updateMin(index, min) {
        gaugeModel.setProperty(index, "min", min);
    }

    // Fungsi untuk nilai maksimum
    function updateMax(index, max) {
        gaugeModel.setProperty(index, "max", max);
    }

    ListModel {
        id: gaugeModel
    }

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: Math.ceil(gaugeModel.count / 2)

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
            updateValue(0, value1);
            updateValue(1, value2);
            updateValue(2, value3);
            updateValue(3, value4);
            updateValue(4, value5);
            updateValue(5, value6);
            updateValue(6, value7);
            updateValue(7, value8);
        }

        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            updateMin(0, min1);
            updateMin(1, min2);
            updateMin(2, min3);
            updateMin(3, min4);
            updateMin(4, min5);
            updateMin(5, min6);
            updateMin(6, min7);
            updateMin(7, min8);
        }

        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            updateMax(0, max1);
            updateMax(1, max2);
            updateMax(2, max3);
            updateMax(3, max4);
            updateMax(4, max5);
            updateMax(5, max6);
            updateMax(6, max7);
            updateMax(7, max8);
        }
    }
}
