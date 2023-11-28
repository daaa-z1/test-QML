import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtCharts 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import Qt.labs.folderlistmodel 2.1
import Qt.labs.platform 1.0


Page {
    id: graphPage

    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['press_in', 'flow']
    property var leakage_keys: ['press_in', 'press_a', 'press_b', 'flow']
    property var testQueue: []
    property var current_keys: []
    property bool testing: false

    ChartView {
        id: chartView
        objectName: "chartView"
        width: parent.width * 3 / 4
        height: parent.height
        anchors.left: parent.left
        theme: ChartView.ChartThemeDark
        antialiasing: true
        title: "Testing Page Test Bench Experts"

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
            id: lineSeries1
            name: "Test 1"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries2
            name: "Test 2"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries3
            name: "Test 3"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries4
            name: "Test 4"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        Component.onCompleted: {
            lineSeries1.visible = false;
            lineSeries2.visible = false;
            lineSeries3.visible = false;
            lineSeries4.visible = false;
            mainApp.valueChanged.connect(updatePlot);
        }

        function updatePlot(currentTest) {
            if (currentTest === "Position Test") {
                current_keys = position_keys;
                axisY.min = mainApp.parameter('aktual', 'minValue') - 2;
                axisY.max = mainApp.parameter('aktual', 'maxValue') + 2;
                timeField.text = Qt.formatDateTime(new Date(), "HH:mm:ss")
            } else if (currentTest === "Flow Test") {
                current_keys = flow_keys;
                axisY.min = mainApp.parameter('press_in', 'minValue') - 10;
                axisY.max = mainApp.parameter('press_in', 'maxValue') + 10;
                timeField.text = Qt.formatDateTime(new Date(), "HH:mm:ss")
            } else if (currentTest === "Leakage Test") {
                current_keys = leakage_keys;
                axisY.min = mainApp.parameter('press_in', 'minValue') - 10;
                axisY.max = mainApp.parameter('press_in', 'maxValue') + 10;
                timeField.text = Qt.formatDateTime(new Date(), "HH:mm:ss")
            }

            if (current_keys.length > 0) {
                var value1 = mainApp.value[current_keys[0]];
                lineSeries1.append(lineSeries1.count, value1);
            }
            if (current_keys.length > 1) {
                var value2 = mainApp.value[current_keys[1]];
                lineSeries2.append(lineSeries2.count, value2);
            }
            if (current_keys.length > 2) {
                var value3 = mainApp.value[current_keys[2]];
                lineSeries3.append(lineSeries3.count, value3);
            }
            if (current_keys.length > 3) {
                var value4 = mainApp.value[current_keys[3]];
                lineSeries4.append(lineSeries4.count, value4);
            }

            lineSeries1.name = current_keys.length > 0 ? current_keys[0] : "";
            lineSeries2.name = current_keys.length > 1 ? current_keys[1] : "";
            lineSeries3.name = current_keys.length > 2 ? current_keys[2] : "";
            lineSeries4.name = current_keys.length > 3 ? current_keys[3] : "";

            lineSeries1.visible = testing && current_keys.length > 0;
            lineSeries2.visible = testing && current_keys.length > 1;
            lineSeries3.visible = testing && current_keys.length > 2;
            lineSeries4.visible = testing && current_keys.length > 3;

            if (lineSeries1.count > axisX.max - axisX.min) {
                axisX.min;
                axisX.max++;
            }

            if (!testing) {
                axisX.min = 0;
                axisX.max = 10;
            }

            if (testQueue.length === 0) {
                axisX.min = 0;
                axisX.max = 10;
            }
        }
    }

    Rectangle {
        id: inputBox
        width: parent.width / 4
        height: parent.height
        anchors.right: parent.right
        color: "transparent"
        radius: 5

        Rectangle {
            anchors.fill: parent
            radius: inputBox.radius
            gradient: Gradient.RiskyConcrete
            layer.enabled: true
            layer.effect: InnerShadow {
                samples: 24
                color: "#000000"
                radius: 16
                spread: 0
                horizontalOffset: -5
                verticalOffset: -5
            }

            Column {
                anchors.fill: parent
                spacing: 10
                padding: 5

                Row {
                    spacing: 10

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
                }

                TextField {
                    id: customerField
                    width: parent.width
                    placeholderText: "Nama Customer"
                }

                TextField {
                    id: projectField
                    width: parent.width
                    placeholderText: "Deskripsi Proyek"
                }

                CheckBox {
                    id: positionTestCheckBox
                    text: "Position Test"
                    enabled: !testing
                }

                CheckBox {
                    id: flowTestCheckBox
                    text: "Flow Test"
                    enabled: !testing
                }

                CheckBox {
                    id: leakageTestCheckBox
                    text: "Leakage Test"
                    enabled: !testing
                }

                Button {
                    id: startButton
                    text: testing ? "Testing..." : "Start"
                    enabled: !testing && (positionTestCheckBox.checked || flowTestCheckBox.checked || leakageTestCheckBox.checked) && customerField.text.trim() !== ""
                    background: Rectangle {
                        color: control.pressed ? "#333" : "#444"
                        radius: 5
                        border.color: "#555"
                        border.width: 1
                        opacity: 1

                        DropShadow {
                            horizontalOffset: 5
                            verticalOffset: 5
                            radius: 5
                            samples: 5
                            color: "#aa000000"
                            source: parent
                        }
                    }
                    onClicked: {
                        testQueue = [];

                        if (positionTestCheckBox.checked) {
                            testQueue.push("Position Test");
                        }
                        if (flowTestCheckBox.checked) {
                            testQueue.push("Flow Test");
                        }
                        if (leakageTestCheckBox.checked) {
                            testQueue.push("Leakage Test");
                        }

                        if (testQueue.length > 0) {
                            testing = true;
                            startNextTest();
                        } else {
                            resetTest();
                        }
                    }
                }
            }
        }
    }

    function startNextTest() {
        var testTimer = Qt.createQmlObject('import QtQuick 2.15; Timer { interval: 10000; running: false; repeat: false; }', graphPage);
        
        if (testQueue.length > 0) {
            var currentTest = testQueue[0];
            chartView.updatePlot(currentTest);
            chartView.title = "" + currentTest;

            testTimer.running = true;

            testTimer.triggered.connect(function() {
                    Qt.callLater(function() {
                    testTimer.destroy();
                    resetTest();
                    saveTestData(currentTest);
                    testQueue.shift();
                    startNextTest();
                }, 500);
            });
        } else {
            testing = false;
            testTimer.running = false;
            testTimer.destroy();

            if (testQueue.length === 0) {
                testTimer.running = false;
                positionTestCheckBox.checked = false;
                flowTestCheckBox.checked = false;
                leakageTestCheckBox.checked = false;
                chartView.title = "Test Completed";
                current_keys = [];
            }
        }
    }

    function saveTestData(currentTest) {
        if (customerField.text.trim() !== "" && timeField.text.trim() !== "" && currentTest !== "") {
            var fileName = customerField.text.trim() + "_" + timeField.text.trim() + "_" + currentTest + ".csv";

            var file = Qt.createQmlObject('import Qt.labs.platform 1.1; FileDialog { }', graphPage);
            file.title = "Save Test Data";
            file.folder = StandardPaths.writableLocation(StandardPaths.DocumentsLocation);
            file.nameFilters = ["CSV Files (*.csv)"];
            file.onAccepted.connect(function() {
                var filePath = file.fileUrl.toString().replace("file:///", "");
                var data = "Time," + current_keys.join(",") + "\n";

                for (var i = 0; i < Math.max(lineSeries1.count, lineSeries2.count, lineSeries3.count, lineSeries4.count); i++) {
                    var timeValue = i < lineSeries1.count ? lineSeries1.at(i).x : i;
                    data += timeValue + ",";
                    data += i < lineSeries1.count ? lineSeries1.at(i).y : "";
                    data += ",";
                    data += i < lineSeries2.count ? lineSeries2.at(i).y : "";
                    data += ",";
                    data += i < lineSeries3.count ? lineSeries3.at(i).y : "";
                    data += ",";
                    data += i < lineSeries4.count ? lineSeries4.at(i).y : "";
                    data += "\n";
                }

                var file = new File(filePath);
                if (file.open(File.WriteOnly)) {
                    file.write(data);
                    file.close();
                    console.log("File successfully written.");
                } else {
                    console.error("Failed to open the file for writing.");
                }
            });

            file.onRejected.connect(function() {
                console.log("Save operation canceled.");
            });

            file.visible = true;
        }
    }

    function resetTest() {
        positionTestCheckBox.checked = false;
        flowTestCheckBox.checked = false;
        leakageTestCheckBox.checked = false;
        axisX.min = 0;
        axisX.max = 10;
        lineSeries1.clear();
        lineSeries2.clear();
        lineSeries3.clear();
        lineSeries4.clear();
    }
}
