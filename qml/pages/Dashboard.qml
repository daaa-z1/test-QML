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
                color: "black"  // Mengubah warna latar belakang menjadi hitam
                radius: width * 0.1

                // Definisikan parameter dan satuan sebagai properti QML
                property var parameters: ["Pressure In", "Pressure A", "Pressure B", "Flow", "Temperature", "Curr V", "Actual", "Curr MA"]
                property var units: ["Bar", "Bar", "Bar", "Bar", "°C", "V", "V", "Ma"]

                Column {
                    anchors.centerIn: parent

                    // Tambahkan Text untuk parameter di atas CircularGauge
                    Text {
                        id: parameterText
                        text: container.parameters[index]
                        color: "white"
                    }

                    CircularGauge {
                        id: gauge
                        objectName: "gauge" + index
                        width: container.width * 0.8
                        height: width

                        value: mainApp.newValue[index]
                        minimumValue: mainApp.readMinValues[index]
                        maximumValue: mainApp.readMaxValues[index]
                        stepSize: mainApp.calculateStepSize[index]  // Menggunakan stepSize dari mainApp
                    }

                    // Tambahkan Text untuk nilai di bawah CircularGauge
                    Text {
                        id: valueText
                        text: mainApp.newValue[index]
                        color: "white"
                    }

                    // Tambahkan Text untuk satuan di sebelah kanan nilai
                    Text {
                        id: unitText
                        text: container.units[index]
                        color: "white"
                        anchors.left: valueText.right
                        anchors.verticalCenter: valueText.verticalCenter
                    }
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
