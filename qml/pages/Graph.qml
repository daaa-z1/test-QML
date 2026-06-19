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

    property var current_keys: []
    property bool testing: false
    property string testStartTime: ""

    Timer {
        id: testTimer
        interval: 0
        running: false
        repeat: false
        onTriggered: {
            finishTest("Custom_Test");
        }
    }

    Component.onDestruction: {
        // Hanya memicu Interrupted_Test jika keluar paksa saat sedang testing
        if (testing) {
            chartView.saveTestData("Interrupted_Test");
        }
    }

    ChartView {
        id: chartView
        objectName: "chartView"
        width: parent.width * 3 / 4
        height: parent.height
        anchors.left: parent.left
        theme: ChartView.ChartThemeDark
        antialiasing: true
        title: "Testing Page Test Bench Experts"

        ValueAxis { id: axisX; min: 0; max: 10 }
        ValueAxis { id: axisY; min: 0; max: 100 }

        LineSeries { id: lineSeries1; name: "Line 1"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3; color: "#ff5555" }
        LineSeries { id: lineSeries2; name: "Line 2"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3; color: "#55ff55" }
        LineSeries { id: lineSeries3; name: "Line 3"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3; color: "#5555ff" }
        LineSeries { id: lineSeries4; name: "Line 4"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3; color: "#ffff55" }
        LineSeries { id: lineSeries5; name: "Line 5"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3; color: "#ff55ff" }
        LineSeries { id: lineSeries6; name: "Line 6"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3; color: "#55ffff" }

        Component.onCompleted: {
            lineSeries1.visible = false; lineSeries2.visible = false;
            lineSeries3.visible = false; lineSeries4.visible = false;
            lineSeries5.visible = false; lineSeries6.visible = false;
            mainApp.valueChanged.connect(updatePlot);
        }

        function setupPlot() {
            var globalMin = 999999;
            var globalMax = -999999;

            for (var i = 0; i < current_keys.length; i++) {
                var key = current_keys[i];
                var minV = mainApp.parameter(key, 'minValue') - 5;
                var maxV = mainApp.parameter(key, 'maxValue') + 5;
                if (minV < globalMin) globalMin = minV;
                if (maxV > globalMax) globalMax = maxV;
            }

            if (globalMin === 999999) { globalMin = 0; globalMax = 100; }

            axisY.min = globalMin;
            axisY.max = globalMax;
            axisX.min = 0;
            axisX.max = 10;
        }

        function saveTestData(testName) {
            if (customerField.text.trim() !== "" && current_keys.length > 0) {
                var maxCount = lineSeries1.count;
                var seriesList = [lineSeries1, lineSeries2, lineSeries3, lineSeries4, lineSeries5, lineSeries6];
                var lineSeriesData = [];

                for (var i = 0; i < maxCount; i++) {
                    var timeValue = lineSeries1.at(i).x;
                    var rowData = [timeValue];

                    for (var j = 0; j < current_keys.length; j++) {
                        rowData.push(i < seriesList[j].count ? seriesList[j].at(i).y : "");
                    }
                    lineSeriesData.push(rowData);
                }

                // FIX: Penggunaan string klasik (+) untuk mencegah error parsing template literal pada Engine QtQML
                var fileName = customerField.text.trim() + "_" + testStartTime + "_" + testName + ".csv";
                var data = testName + "\nTime," + current_keys.join(",") + "\n";

                for (var k = 0; k < lineSeriesData.length; k++) {
                    data += lineSeriesData[k].join(",") + "\n";
                }

                mainApp.save_test_data(fileName, data);
                console.log("Test data saved as: " + fileName);
            }
        }

        function updatePlot() {
            timeField.text = Qt.formatDateTime(new Date(), "HH:mm:ss");

            if (!testing || current_keys.length === 0) return;

            var seriesList = [lineSeries1, lineSeries2, lineSeries3, lineSeries4, lineSeries5, lineSeries6];

            for (var i = 0; i < current_keys.length; i++) {
                var key = current_keys[i];
                var val = mainApp.value[key];
                
                seriesList[i].append(seriesList[i].count, val);
                seriesList[i].name = key;
                seriesList[i].visible = true;
            }

            for (var j = current_keys.length; j < 6; j++) {
                seriesList[j].visible = false;
            }

            if (lineSeries1.count > axisX.max - axisX.min) {
                axisX.min++;
                axisX.max++;
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
                samples: 24; color: "#000000"; radius: 16; spread: 0; horizontalOffset: -5; verticalOffset: -5
            }

            Column {
                anchors.fill: parent
                spacing: 10
                padding: 10

                Row {
                    spacing: 10
                    TextField {
                        id: dateField
                        text: Qt.formatDateTime(new Date(), "yyyy-MM-dd")
                        readOnly: true
                        background: Rectangle { color: "lightgray"; radius: 5 }
                        width: (parent.parent.width - 30) / 2
                    }
                    TextField {
                        id: timeField
                        text: Qt.formatDateTime(new Date(), "HH:mm:ss")
                        readOnly: true
                        background: Rectangle { color: "lightgray"; radius: 5 }
                        width: (parent.parent.width - 30) / 2
                    }
                }

                TextField { id: customerField; width: parent.width - 20; placeholderText: "Nama Customer" }
                TextField { id: projectField; width: parent.width - 20; placeholderText: "Deskripsi Proyek" }

                Row {
                    spacing: 10
                    TextField {
                        id: timerInput
                        placeholderText: "Waktu (Menit)"
                        validator: DoubleValidator {}
                        width: (parent.parent.width - 30) / 2
                        enabled: !testing
                    }
                    Text { anchors.verticalCenter: timerInput.verticalCenter; font.pixelSize: 16; text: "(Menit)" }
                }

                Text { text: "Pilih Parameter Uji:"; font.bold: true; font.pixelSize: 14; color: "#333" }

                GridLayout {
                    columns: 2
                    columnSpacing: 10
                    rowSpacing: 0
                    CheckBox { id: cb_curr_v; text: "curr_v"; enabled: !testing }
                    CheckBox { id: cb_aktual; text: "aktual"; enabled: !testing }
                    CheckBox { id: cb_press_in; text: "press_in"; enabled: !testing }
                    CheckBox { id: cb_press_a; text: "press_a"; enabled: !testing }
                    CheckBox { id: cb_press_b; text: "press_b"; enabled: !testing }
                    CheckBox { id: cb_flow; text: "flow"; enabled: !testing }
                }

                Button {
                    id: startButton
                    text: testing ? "Stop" : "Start"
                    width: parent.width - 20
                    enabled: (cb_curr_v.checked || cb_aktual.checked || cb_press_in.checked || cb_press_a.checked || cb_press_b.checked || cb_flow.checked) && 
                             customerField.text.trim() !== "" && timerInput.text.trim() !== ""
                    
                    background: Rectangle {
                        color: startButton.pressed ? "#333" : (testing ? "#ff5555" : "#fff")
                        radius: 5
                        border.color: "#555"
                        border.width: 1
                        DropShadow {
                            horizontalOffset: 3; verticalOffset: 3; radius: 5; samples: 5; color: "#aa000000"; source: parent
                        }
                    }

                    contentItem: Text {
                        text: startButton.text
                        color: testing ? "#fff" : "#000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }

                    onClicked: {
                        if (testing) {
                            finishTest("Manual_Stop");
                        } else {
                            current_keys = [];
                            if (cb_curr_v.checked) current_keys.push("curr_v");
                            if (cb_aktual.checked) current_keys.push("aktual");
                            if (cb_press_in.checked) current_keys.push("press_in");
                            if (cb_press_a.checked) current_keys.push("press_a");
                            if (cb_press_b.checked) current_keys.push("press_b");
                            if (cb_flow.checked) current_keys.push("flow");

                            if (current_keys.length > 0) {
                                testing = true;
                                startTest();
                            }
                        }
                    }
                }
            }
        }
    }

    function startTest() {
        var timerMs = parseFloat(timerInput.text) * 60000;
        testStartTime = Qt.formatDateTime(new Date(), "HH-mm-ss");

        chartView.setupPlot();
        chartView.title = "Testing: " + current_keys.join(", ");

        testTimer.interval = timerMs;
        testTimer.start();
    }

    function finishTest(testName) {
        // FIX 1: Set testing = false SEBELUM hal lain untuk mengunci grafik secara real-time
        testing = false;
        
        // FIX 2: Matikan timer backend
        testTimer.stop();

        // FIX 3: Simpan secara sinkron tanpa Qt.callLater agar tidak terjadi delay
        chartView.saveTestData(testName);
        
        // Bersihkan dan perbarui UI
        resetTest();
        chartView.title = (testName === "Manual_Stop") ? "Test Stopped Manually" : "Test Completed";
    }

    function resetTest() {
        axisX.min = 0;
        axisX.max = 10;
        
        // FIX 4: Membersihkan series secara eksplisit jauh lebih stabil 
        // daripada looping chartView.children di QML yang rawan error
        lineSeries1.clear();
        lineSeries2.clear();
        lineSeries3.clear();
        lineSeries4.clear();
        lineSeries5.clear();
        lineSeries6.clear();
    }

    Connections {
        target: mainApp
    }
}
