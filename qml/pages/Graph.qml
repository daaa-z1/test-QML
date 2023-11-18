import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage

    property var testData: ({})
    property string currentTest: ""
    property var testQueue: []
    property var updateTimer: Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            dateField.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd")
            timeField.text = Qt.formatDateTime(new Date(), "HH:mm:ss")
        }
    }

    // Fungsi untuk membuat grafik
    function createChart(testType) {
        var keys = testType === "Position Test" ? position_keys :
                   testType === "Flow Test" ? flow_keys :
                   testType === "Leakage Test" ? leakage_keys : [];
        chartView.title = testType;

        for (var i = 0; i < keys.length; i++) {
            var key = keys[i];
            if (key && mainApp.value[key] !== undefined) {
                lineSeries.append(new Date().getTime(), mainApp.value[key]);
            }
        }
    }

    // Fungsi untuk memulai pengujian berikutnya
    function startNextTest() {
        if (testQueue.length > 0) {
            currentTest = testQueue.shift();
            testData[currentTest] = [];

            var keys = currentTest === "Position Test" ? position_keys :
                       currentTest === "Flow Test" ? flow_keys :
                       currentTest === "Leakage Test" ? leakage_keys : [];

            lineSeries.clear();
            createChart(currentTest);

            for (var i = 0; i < keys.length; i++) {
                var key = keys[i];
                if (key && mainApp.value[key] !== undefined) {
                    testData[currentTest].push(mainApp.value[key]);
                }
            }

            Timer {
                interval: 10000
                running: true
                onTriggered: startNextTest()
            }
        } else {
            currentTest = "";
            positionTestCheckBox.enabled = true;
            flowTestCheckBox.enabled = true;
            leakageTestCheckBox.enabled = true;
            startButton.enabled = true;
        }
    }

    Row {
        anchors.fill: parent

        ChartView {
            id: chartView
            width: parent.width * 3 / 4
            height: parent.height
            antialiasing: true
            backgroundColor: "#f0f0f0"
            title: "Test Results"

            LineSeries {
                id: lineSeries
                XYPoint { x: 0; y: 0 }
            }
        }

        Rectangle {
            id: inputBox
            width: parent.width / 4
            height: parent.height
            color: "#e0e0e0"
            radius: 10
            border.color: "gray"
            border.width: 2

            // Kotak input
            Column {
                anchors.fill: parent
                spacing: 10
                padding: 10

                TextField {
                    id: dateField
                    text: Qt.formatDateTime(new Date(), "yyyy-MM-dd")
                    readOnly: true
                    background: Rectangle { color: "lightgray"; radius: 5 }
                }

                TextField {
                    id: timeField
                    text: Qt.formatDateTime(new Date(), "HH:mm:ss")
                    readOnly: true
                    background: Rectangle { color: "lightgray"; radius: 5 }
                }

                TextField {
                    id: customerField
                    placeholderText: "Customer Name"
                    background: Rectangle { color: "lightgray"; radius: 5 }
                }

                TextField {
                    id: projectField
                    placeholderText: "Project Description"
                    background: Rectangle { color: "lightgray"; radius: 5 }
                }

                Button {
                    text: "Submit"
                    onClicked: {
                        if (customerField.text.trim() !== "" && projectField.text.trim() !== "") {
                            testData = {
                                "Date": dateField.text,
                                "Time": timeField.text,
                                "Customer": customerField.text,
                                "Project": projectField.text
                            };
                        }
                    }
                    background: Rectangle { color: "lightblue"; radius: 5 }
                }

                // Checkbox untuk jenis pengujian
                CheckBox {
                    text: "Position Test"
                    id: positionTestCheckBox
                }

                CheckBox {
                    text: "Flow Test"
                    id: flowTestCheckBox
                }

                CheckBox {
                    text: "Leakage Test"
                    id: leakageTestCheckBox
                }

                // Tombol untuk memulai pengujian
                Button {
                    text: "Start Tests"
                    id: startButton
                    onClicked: {
                        if (positionTestCheckBox.checked || flowTestCheckBox.checked || leakageTestCheckBox.checked) {
                            if (positionTestCheckBox.checked) testQueue.push("Position Test");
                            if (flowTestCheckBox.checked) testQueue.push("Flow Test");
                            if (leakageTestCheckBox.checked) testQueue.push("Leakage Test");

                            startButton.enabled = false;
                            positionTestCheckBox.enabled = false;
                            flowTestCheckBox.enabled = false;
                            leakageTestCheckBox.enabled = false;

                            if (testData[currentTest] === undefined) {
                                createChart(currentTest);
                            }

                            startNextTest();
                        }
                    }
                    background: Rectangle { color: "lightblue"; radius: 5 }
                }
            }
        }
    }

    Connections {
        target: mainApp
    }
}
