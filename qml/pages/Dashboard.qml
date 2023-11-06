import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    property real value1: 0
    property real value2: 0
    property real value3: 0
    property real value4: 0
    property real value5: 0
    property real value6: 0
    property real value7: 0
    property real value8: 0

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

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: 4

        Repeater {
            model: 8

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

                    value: modelData === 0 ? value1 :
                           modelData === 1 ? value2 :
                           modelData === 2 ? value3 :
                           modelData === 3 ? value4 :
                           modelData === 4 ? value5 :
                           modelData === 5 ? value6 :
                           modelData === 6 ? value7 : value8

                    minimumValue: modelData === 0 ? min1 :
                                  modelData === 1 ? min2 :
                                  modelData === 2 ? min3 :
                                  modelData === 3 ? min4 :
                                  modelData === 4 ? min5 :
                                  modelData === 5 ? min6 :
                                  modelData === 6 ? min7 : min8

                    maximumValue: modelData === 0 ? max1 :
                                  modelData === 1 ? max2 :
                                  modelData === 2 ? max3 :
                                  modelData === 3 ? max4 :
                                  modelData === 4 ? max5 :
                                  modelData === 5 ? max6 :
                                  modelData === 6 ? max7 : max8
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            dashboardPage.value1 = value1
            dashboardPage.value2 = value2
            dashboardPage.value3 = value3
            dashboardPage.value4 = value4
            dashboardPage.value5 = value5
            dashboardPage.value6 = value6
            dashboardPage.value7 = value7
            dashboardPage.value8 = value8
        }

        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            dashboardPage.min1 = min1
            dashboardPage.min2 = min2
            dashboardPage.min3 = min3
            dashboardPage.min4 = min4
            dashboardPage.min5 = min5
            dashboardPage.min6 = min6
            dashboardPage.min7 = min7
            dashboardPage.min8 = min8
        }
    }
}
