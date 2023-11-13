import QtQuick 2.0
import QtCharts 2.0

Page {
    id: graphPage

    Rectangle {
        id: inputArea
        width: parent.width / 4
        height: parent.height
        color: "lightgrey"

        Column {
            spacing: 10
            anchors.fill: parent
            anchors.margins: 10

            Label {
                id: dateLabel
                width: parent.width
                text: Qt.formatDateTime(new Date(), "yyyy-MM-dd")
            }

            Label {
                id: timeLabel
                width: parent.width
                text: Qt.formatDateTime(new Date(), "hh:mm:ss")
            }

            TextField {
                id: testName
                width: parent.width
                placeholderText: "Test Name"
            }

            TextArea {
                id: description
                width: parent.width
                placeholderText: "Description"
                height: 100
            }

            TextField {
                id: customerName
                width: parent.width
                placeholderText: "Customer Name"
            }

            TextField {
                id: operator
                width: parent.width
                placeholderText: "Operator"
            }

            CheckBox {
                id: positionTest
                text: "Position Test"
            }

            CheckBox {
                id: leakageTest
                text: "Leakage Test"
            }

            CheckBox {
                id: flowTest
                text: "Flow Test"
            }

            Button {
                id: startButton
                text: "Start"
                width: parent.width
                onClicked: {
                    // Anda perlu mengganti 'mainApp' dengan objek Python Anda
                    if (positionTest.checked) {
                        mainApp.startTest('position test');
                    }
                    if (leakageTest.checked) {
                        mainApp.startTest('leakage test');
                    }
                    if (flowTest.checked) {
                        mainApp.startTest('flow test');
                    }
                }
            }
        }
    }

    Rectangle {
        id: chartArea
        x: inputArea.width
        width: parent.width * 3 / 4
        height: parent.height
        color: "white"

        ChartView {
            id: chartView
            title: "Pengujian"
            anchors.fill: parent
            antialiasing: true

            LineSeries {
                id: lineSeries1
                name: "Pengujian 1"
                axisX: ValueAxis {
                    min: 0
                    max: 100
                }
                axisY: ValueAxis {
                    min: -5
                    max: 5
                }
            }

            LineSeries {
                id: lineSeries2
                name: "Pengujian 2"
                axisX: ValueAxis {
                    min: 0
                    max: 100
                }
                axisY: ValueAxis {
                    min: -5
                    max: 5
                }
            }

            Component.onCompleted: {
                // Anda perlu mengganti 'mainApp' dengan objek Python Anda
                mainApp.positionTest.connect(updateChart1);
                mainApp.flowTest.connect(updateChart2);
                mainApp.pressureTest.connect(updateChart2);
            }

            function updateChart1(values) {
                // Hapus data lama
                lineSeries1.clear();

                // Tambahkan data baru
                lineSeries1.append(0, values[0]);
                lineSeries1.append(1, values[1]);
            }

            function updateChart2(values) {
                // Hapus data lama
                lineSeries2.clear();

                // Tambahkan data baru
                lineSeries2.append(0, values[0]);
                lineSeries2.append(1, values[1]);
            }
        }
    }
}
