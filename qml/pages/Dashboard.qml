import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    property real updateGauge1: 0
    property real updateGauge2: 0
    property real updateGauge3: 0
    property real updateGauge4: 0
    property real updateGauge5: 0
    property real updateGauge6: 0
    property real updateGauge7: 0
    property real updateGauge8: 0

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: 4

        CircularGauge {
            id: gauge1
            width: parent.width * 0.8
            height: width
            value: updateGauge1
        }

        CircularGauge {
            id: gauge2
            width: parent.width * 0.8
            height: width
            value: updateGauge2
        }

        CircularGauge {
            id: gauge3
            width: parent.width * 0.8
            height: width
            value: updateGauge3
        }

        CircularGauge {
            id: gauge4
            width: parent.width * 0.8
            height: width
            value: updateGauge4
        }

        CircularGauge {
            id: gauge5
            width: parent.width * 0.8
            height: width
            value: updateGauge5
        }

        CircularGauge {
            id: gauge6
            width: parent.width * 0.8
            height: width
            value: updateGauge6
        }

        CircularGauge {
            id: gauge7
            width: parent.width * 0.8
            height: width
            value: updateGauge7
        }

        CircularGauge {
            id: gauge8
            width: parent.width * 0.8
            height: width
            value: updateGauge8
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            updateGauge1 = value1;
            updateGauge2 = value2;
            updateGauge3 = value3;
            updateGauge4 = value4;
            updateGauge5 = value5;
            updateGauge6 = value6;
            updateGauge7 = value7;
            updateGauge8 = value8;
        }
    }
}
