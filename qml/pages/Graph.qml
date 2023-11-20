import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage
    property var testData: ({})
    property string currentTest: ""
    property var testQueue: []
    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['press_in', 'flow']
    property var leakage_keys: ['press_in', 'press_a', 'press_b', 'flow']
    property var updateTimer: Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            dateField.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd");
            timeField.text = Qt.formatDateTime(new Date(), "HH:mm:ss");
        }
    }

    function createChart(testType) {
        var keys = [];
        var currentTime = new Date().getTime();
        if (testType === "Position Test") keys = position_keys;
        else if (testType === "Flow Test") keys = flow_keys;
        else if (testType === "Leakage Test") keys = leakage_keys;
        chartView.title = testType;

        for (var i = 0; i < keys.length; i++) {
            var key = keys[i];
            if (key) {
                lineSeries.append(currentTime, mainApp.value[key]);
            }
            console.log(mainApp.value[key]);
        }
    }

    function startNextTest() {
        if (testQueue.length > 0) {
            currentTest = testQueue.shift();
            testData[currentTest] = [];
            var keys = [];
            if (currentTest === "Position Test") keys = position_keys;
            else if (currentTest === "Flow Test") keys = flow_keys;
            else if (currentTest === "Leakage Test") keys = leakage_keys;

            if (testData[currentTest].length === 0) {
                createChart(currentTest);
            }

            for (var i = 0; i < keys.length; i++) {
                var key = keys[i];
                testData[currentTest].push(mainApp.value[key]);
            }

            Qt.createQmlObject('import QtQuick 2.0; Timer { interval: 10000; running: true; onTriggered: graphPage.startNextTest() }', graphPage);
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
            ValueAxis {
                id: axisX
                min: 0
                max: 10
            }

            ValueAxis {
                id: axisY
                min: 0
                max: 100
            }

            LineSeries {
                id: lineSeries
                name: "Value"
                axisX: axisX
                axisY: axisY
                useOpenGL: true
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
                        } else {
                        }
                    }
                    background: Rectangle { color: "lightblue"; radius: 5 }
                }

                CheckBox {
                    id: positionTestCheckBox
                    text: "Position Test"
                }

                CheckBox {
                    id: flowTestCheckBox
                    text: "Flow Test"
                }

                CheckBox {
                    id: leakageTestCheckBox
                    text: "Leakage Test"
                }

                Button {
                    id: startButton
                    text: "Start Tests"
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
                        } else {
                        }
                    }
                    background: Rectangle { color: "lightblue"; radius: 5 }
                }
                Component.onCompleted: {
                    // Connect to the valueChanged signal of mainApp
                    mainApp.valueChanged.connect(startNextTest);
                    mainApp.valueChanged.connect(createChart);
                }
            }
        }
    }

    Connections {
        target: mainApp
        
    }
}
