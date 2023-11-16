import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage
    title: "Hydraulic Servo Valve Testing Application"

    property var testData: ({})
    property string currentTest: ""
    property var testQueue: []

    function startNextTest() {
        if (testQueue.length > 0) {
            currentTest = testQueue.shift();
            if (currentTest === "Position Test") mainApp.positionTest();
            else if (currentTest === "Flow Test") mainApp.flowTest();
            else if (currentTest === "Leakage Test") mainApp.leakageTest();
            testData[currentTest] = [];
            Qt.createQmlObject('import QtQuick 2.0; Timer { interval: 10000; running: true; onTriggered: graphPage.startNextTest() }', graphPage);
        } else {
            currentTest = "";
            console.log(testData);  // Replace this with code to save testData
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
                        testData = {
                            "Date": dateField.text,
                            "Time": timeField.text,
                            "Customer": customerField.text,
                            "Project": projectField.text
                        };
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
                    text: "Start Tests"
                    onClicked: {
                        if (positionTestCheckBox.checked) testQueue.push("Position Test");
                        if (flowTestCheckBox.checked) testQueue.push("Flow Test");
                        if (leakageTestCheckBox.checked) testQueue.push("Leakage Test");
                        startNextTest();
                    }
                    background: Rectangle { color: "lightblue"; radius: 5 }
                }
            }
        }
    }

    Connections {
        target: mainApp
        function onValueChanged() {
            // Update the chart with the new values
            lineSeries.append(new Date().getTime(), mainApp.value['curr_v']);
        }
    }
}
