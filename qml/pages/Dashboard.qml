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

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: Math.ceil(valueModel.count / 2)

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
                    minimumValue: getMinValue(index)
                    maximumValue: getMaxValue(index)
                }
            }
        }
    }

    function getMinValue(index) {
        switch (index) {
            case 0: return min1;
            case 1: return min2;
            case 2: return min3;
            case 3: return min4;
            case 4: return min5;
            case 5: return min6;
            case 6: return min7;
            case 7: return min8;
        }
    }

    function getMaxValue(index) {
        switch (index) {
            case 0: return max1;
            case 1: return max2;
            case 2: return max3;
            case 3: return max4;
            case 4: return max5;
            case 5: return max6;
            case 6: return max7;
            case 7: return max8;
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
    }

    property real min1: 0
    property real min2: 0
    property real min3: 0
    property real min4: 0
    property real min5: 0
    property real min6: 0
    property real min7: 0
    property real min8: 0

    property real max1: 100
    property real max2: 100
    property real max3: 100
    property real max4: 100
    property real max5: 100
    property real max6: 100
    property real max7: 100
    property real max8: 100
}
