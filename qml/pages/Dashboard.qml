import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: 4  // Ganti dengan jumlah kolom yang sesuai

        Repeater {
            model: 8  // Ganti dengan jumlah model yang sesuai (sesuai jumlah gauge yang Anda inginkan)

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

                    property real gaugeValue: 0
                    property real gaugeMin: 0
                    property real gaugeMax: 100

                    value: gaugeValue
                    minimumValue: gaugeMin
                    maximumValue: gaugeMax
                }

                Component.onCompleted: {
                    // Ketika komponen selesai dimuat, minta nilai aktual dan nilai min dan max dari Python
                    ainReader.parameterSelectedSignal.connect(function (parameter) {
                        // Pindahkan ini sesuai dengan nama parameter yang sesuai dengan daftar Anda
                        if (parameter === "Pressure_In") {
                            gaugeValue = ainReader.value1
                            gaugeMin = ainReader.min1
                            gaugeMax = ainReader.max1
                        } else if (parameter === "Pressure_A") {
                            gaugeValue = ainReader.value2
                            gaugeMin = ainReader.min2
                            gaugeMax = ainReader.max2
                        } else if (parameter === "Pressure_B") {
                            gaugeValue = ainReader.value3
                            gaugeMin = ainReader.min3
                            gaugeMax = ainReader.max3
                        } else if (parameter === "Flow") {
                            gaugeValue = ainReader.value4
                            gaugeMin = ainReader.min4
                            gaugeMax = ainReader.max4
                        } else if (parameter === "Temp") {
                            gaugeValue = ainReader.value5
                            gaugeMin = ainReader.min5
                            gaugeMax = ainReader.max5
                        } else if (parameter === "Curr_V") {
                            gaugeValue = ainReader.value6
                            gaugeMin = ainReader.min6
                            gaugeMax = ainReader.max6
                        } else if (parameter === "Aktual") {
                            gaugeValue = ainReader.value7
                            gaugeMin = ainReader.min7
                            gaugeMax = ainReader.max7
                        } else if (parameter === "Curr_MA") {
                            gaugeValue = ainReader.value8
                            gaugeMin = ainReader.min8
                            gaugeMax = ainReader.max8
                        }
                    })
                }
            }
        }
    }
}
