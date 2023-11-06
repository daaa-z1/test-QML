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

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: 4

        CircularGauge {
            id: gauge1
            width: gridLayout.cellWidth * 0.8
            height: width
            value: dashboardPage.value1
        }

        CircularGauge {
            id: gauge2
            width: gridLayout.cellWidth * 0.8
            height: width
            value: dashboardPage.value2
        }

        CircularGauge {
            id: gauge3
            width: gridLayout.cellWidth * 0.8
            height: width
            value: dashboardPage.value3
        }

        CircularGauge {
            id: gauge4
            width: gridLayout.cellWidth * 0.8
            height: width
            value: dashboardPage.value4
        }

        CircularGauge {
            id: gauge5
            width: gridLayout.cellWidth * 0.8
            height: width
            value: dashboardPage.value5
        }

        CircularGauge {
            id: gauge6
            width: gridLayout.cellWidth * 0.8
            height: width
            value: dashboardPage.value6
        }

        CircularGauge {
            id: gauge7
            width: gridLayout.cellWidth * 0.8
            height: width
            value: dashboardPage.value7
        }

        CircularGauge {
            id: gauge8
            width: gridLayout.cellWidth * 0.8
            height: width
            value: dashboardPage.value8
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
    }
}
