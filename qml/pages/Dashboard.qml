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

    property real max1: 0
    property real max2: 0
    property real max3: 0
    property real max4: 0
    property real max5: 0
    property real max6: 0
    property real max7: 0
    property real max8: 0

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

                    value: model.index === 0 ? value1 :
                           model.index === 1 ? value2 :
                           model.index === 2 ? value3 :
                           model.index === 3 ? value4 :
                           model.index === 4 ? value5 :
                           model.index === 5 ? value6 :
                           model.index === 6 ? value7 : value8

                    minimumValue: model.index === 0 ? min1 :
                                  model.index === 1 ? min2 :
                                  model.index === 2 ? min3 :
                                  model.index === 3 ? min4 :
                                  model.index === 4 ? min5 :
                                  model.index === 5 ? min6 :
                                  model.index === 6 ? min7 : min8

                    maximumValue: model.index === 0 ? max1 :
                                  model.index === 1 ? max2 :
                                  model.index === 2 ? max3 :
                                  model.index === 3 ? max4 :
                                  model.index === 4 ? max5 :
                                  model.index === 5 ? max6 :
                                  model.index === 6 ? max7 : max8
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
        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            dashboardPage.max1 = max1
            dashboardPage.max2 = max2
            dashboardPage.max3 = max3
            dashboardPage.max4 = max4
            dashboardPage.max5 = max5
            dashboardPage.max6 = max6
            dashboardPage.max7 = max7
            dashboardPage.max8 = max8
        }
    }
}
