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
        columns: 4

        Repeater {
            id: repeater
            model: mainApp.readMinValues.length

            Rectangle {
                id: container
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                radius: width * 0.1

                CircularGauge {
                    id: gauge
                    objectName: "gauge" + index
                    anchors.centerIn: parent
                    width: container.width * 0.8
                    height: width

                    value: mainApp.newValue[index]
                    minimumValue: mainApp.readMinValues[index]
                    maximumValue: mainApp.readMaxValues[index]
                }
            }
        }
    }

    Component.onCompleted: {
        mainApp.newValue.connect(function(values) {
            for (var i = 0; i < repeater.count; i++) {
                var gauge = repeater.itemAt(i).children[0];
                if (gauge && "value" in gauge) {
                    gauge.value = values[i];
                }
            }
        });
    }
}
