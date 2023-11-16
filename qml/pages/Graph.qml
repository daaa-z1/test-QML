import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    title: "Graph Page"

    Column {
        spacing: 10

        // Grafik
        ChartView {
            id: chartView
            width: parent.width
            height: parent.height * 0.7

            LineSeries {
                name: "curr_v"
                axisX: ValueAxis {
                    labelFormat: "%.1f"
                }
                axisY: ValueAxis {
                    labelFormat: "%.1f"
                }
            }

            LineSeries {
                name: "aktual"
                axisX: ValueAxis {
                    labelFormat: "%.1f"
                }
                axisY: ValueAxis {
                    labelFormat: "%.1f"
                }
            }

            LineSeries {
                name: "pressure_in"
                axisX: ValueAxis {
                    labelFormat: "%.1f"
                }
                axisY: ValueAxis {
                    labelFormat: "%.1f"
                }
            }

            LineSeries {
                name: "pressure_a"
                axisX: ValueAxis {
                    labelFormat: "%.1f"
                }
                axisY: ValueAxis {
                    labelFormat: "%.1f"
                }
            }

            LineSeries {
                name: "pressure_b"
                axisX: ValueAxis {
                    labelFormat: "%.1f"
                }
                axisY: ValueAxis {
                    labelFormat: "%.1f"
                }
            }

            LineSeries {
                name: "flow"
                axisX: ValueAxis {
                    labelFormat: "%.1f"
                }
                axisY: ValueAxis {
                    labelFormat: "%.1f"
                }
            }
        }

        // Checkboxes untuk memilih jenis pengujian
        Row {
            CheckBox {
                text: "Position Test"
                checked: true
                onCheckedChanged: {
                    if (checked) mainApp.tests.push("Position Test")
                    else mainApp.tests.splice(mainApp.tests.indexOf("Position Test"), 1)
                }
            }

            CheckBox {
                text: "Flow Test"
                checked: true
                onCheckedChanged: {
                    if (checked) mainApp.tests.push("Flow Test")
                    else mainApp.tests.splice(mainApp.tests.indexOf("Flow Test"), 1)
                }
            }

            CheckBox {
                text: "Leakage Test"
                checked: true
                onCheckedChanged: {
                    if (checked) mainApp.tests.push("Leakage Test")
                    else mainApp.tests.splice(mainApp.tests.indexOf("Leakage Test"), 1)
                }
            }
        }

        // Tombol untuk memulai pengujian
        Button {
            text: "Start Testing"
            onClicked: mainApp.startTesting(mainApp.tests)
        }
    }
}
