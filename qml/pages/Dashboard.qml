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
            model: mainApp ? mainApp.readMinValues.length : 0

            Rectangle {
                id: container
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "black"
                radius: width * 0.1

                CircularGauge {
                    id: gauge
                    objectName: "gauge" + index
                    anchors.centerIn: parent
                    width: container.width * 0.8
                    height: width

                    value: mainApp ? mainApp.newValue[index] : 0
                    minimumValue: mainApp ? mainApp.readMinValues[index] : 0
                    maximumValue: mainApp ? mainApp.readMaxValues[index] : 0
                    stepSize: 10
                }
            }
        }
    }

    Component.onCompleted: {
        if (mainApp) {
            mainApp.newValue.connect(function(values) {
                for (var i = 0; i < repeater.count; i++) {
                    var container = repeater.itemAt(i);
                    if (container && container.children.length > 0) {
                        var gauge = container.children[0];
                        if (gauge && "value" in gauge) {
                            gauge.value = values[i];
                        }
                    }
                }
            });
        }
    }
}
