import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: dashboardPage

    Grid {
        columns: 4
        spacing: 20
        width: parent.width
        height: parent.height

        ListModel {
            id: gaugeModel
            ListElement { label: "Pressure In"; value: 50; min: 0; max: 100 }
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

            Item {
                id: container
                width: parent.width / parent.columns
                height: width

                CircleGauge {
                    id: gauge
                    anchors.centerIn: parent
                    width: container.width * 0.8
                    height: width

                    value: model.value
                    minimumValue: model.min
                    maximumValue: model.max

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
