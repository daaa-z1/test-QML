import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Page {
    id: dashboardPage

    Grid {
        columns: 4
        spacing: 20
        width: parent.width
        height: parent.height

        ListModel {
            id: gaugeModel
            ListElement { label: "AIN0"; value: 50; min: 0; max: 100 }
            ListElement { label: "AIN1"; value: 75; min: 0; max: 100 }
            ListElement { label: "AIN1"; value: 75; min: 0; max: 100 }
            ListElement { label: "AIN1"; value: 75; min: 0; max: 100 }
            ListElement { label: "AIN1"; value: 75; min: 0; max: 100 }
            ListElement { label: "AIN1"; value: 75; min: 0; max: 100 }
            ListElement { label: "AIN1"; value: 75; min: 0; max: 100 }
            ListElement { label: "AIN1"; value: 75; min: 0; max: 100 }
        }

        Repeater {
            model: gaugeModel

            Rectangle {
                id: container
                width: parent.width / parent.columns
                height: width
                color: "lightgray"
                radius: width * 0.1

                CircularGauge {
                    id: gauge
                    anchors.centerIn: parent
                    width: container.width * 0.8
                    height: width

                    value: model.value
                    minimumValue: model.min
                    maximumValue: model.max

                    style: CircularGaugeStyle {
                        labelStepSize: model.max / 5 // adjust as needed
                        tickmarkStepSize: model.max / 50 // adjust as needed
                    }

                    Label {
                        text: model.label
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                    }
                }
            }
        }
    }
}
