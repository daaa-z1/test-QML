import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

Page {
    id: dashboardPage

    property var ainData: [
        { label: "Pressure A", value: 30, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 50, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 70, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 40, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 60, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 20, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 80, minValue: 0, maxValue: 100 },
        { label: "Actual", value: 90, minValue: 0, maxValue: 100 }
    ]

    GridLayout {
        id : gridLayout
        anchors.fill : parent
        columns : ainData.length > 4 ? ainData.length / 2 : ainData.length

        Repeater {
            model : ainData.length

            Rectangle {
                id : container
                Layout.fillWidth : true
                Layout.fillHeight : true
                color : "#D3D3D3"
                radius : width * 0.1

                CircularGauge {
                    id : gauge
                    anchors.centerIn : parent
                    width : container.width * 0.8
                    height : width

                    value : ainData[index].value
                    minimumValue : ainData[index].minValue
                    maximumValue : ainData[index].maxValue

                    style : GaugeStyle {
                        foreground: Item {
                            Rectangle {
                                width: outerRadius * 0.2
                                height: width
                                radius: width / 2
                                color: "#000000"
                                anchors.centerIn: parent
                            }
                        }
                    }

                    Label {
                        text : ainData[index].label
                        font.pixelSize : Math.min(container.width, container.height) * 0.1
                        color : "#000000"
                        anchors.bottom : parent.verticalCenter
                        anchors.horizontalCenter : parent.horizontalCenter
                    }

                    Label {
                        text : ainData[index].value.toFixed(0)
                        font.pixelSize : Math.min(container.width, container.height) * 0.1
                        color : "#000000"
                        anchors.top : parent.verticalCenter
                        anchors.horizontalCenter : parent.horizontalCenter
                    }
                }
            }
        }
    }
}
