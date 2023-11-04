import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    property var ainReader: ainReader
    property var updateGauge: [0, 0, 0, 0, 0, 0, 0, 0]

    
    function updateValue(channel, value) {
        updateGauge[channel] = value;
    }

    GridLayout {
        id : gridLayout
        anchors.fill : parent
        columns : ainData.length > 4 ? ainData.length / 2 : ainData.length

        Repeater {
            model : updateGauge.length

            Rectangle {
                id : container
                Layout.fillWidth : true
                Layout.fillHeight : true
                color : "transparent"
                radius : width * 0.1

                delegate: CircleGauge {
                    id : gauge
                    anchors.centerIn : parent
                    width : container.width * 0.8
                    height : width

                    value : updateGauge[index]
                }
            }
        }
    }

    
    Connections {
        target: ainReader
        onNewValue: updateValue(ain, value)
    }
    
}
