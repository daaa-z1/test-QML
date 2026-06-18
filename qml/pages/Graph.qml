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

        // Ketebalan garis diatur melalui properti width
        LineSeries { id: lineSeries1; name: "Line 1"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3 }
        LineSeries { id: lineSeries2; name: "Line 2"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3 }
        LineSeries { id: lineSeries3; name: "Line 3"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3 }
        LineSeries { id: lineSeries4; name: "Line 4"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3 }
        LineSeries { id: lineSeries5; name: "Line 5"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3 }
        LineSeries { id: lineSeries6; name: "Line 6"; axisX: axisX; axisY: axisY; useOpenGL: true; width: 3 }

        Component.onCompleted: {
            lineSeries1.visible = false;
            lineSeries2.visible = false;
            lineSeries3.visible = false;
            lineSeries4.visible = false;
            lineSeries5.visible = false;
            lineSeries6.visible = false;
            mainApp.valueChanged.connect(updatePlot);
        }

        function setupPlot() {
            var globalMin = 999999;
            var globalMax = -999999;

            // Cari min dan max global untuk menyesuaikan sumbu Y
            for (var i = 0; i < current_keys.length; i++) {
                var key = current_keys[i];
                var minV = mainApp.parameter(key, 'minValue') - 5;
                var maxV = mainApp.parameter(key, 'maxValue') + 5;
                if (minV < globalMin) globalMin = minV;
                if (maxV > globalMax) globalMax = maxV;
            }

            if (globalMin === 999999) { globalMin = 0; globalMax = 100; } // Fallback

            axisY.min = globalMin;
            axisY.max = globalMax;
            axisX.min = 0;
            axisX.max = 10;
        }

        function saveTestData(testName) {
            if (customerField.text.trim() !== "" && timeField.text.trim() !== "" && current_keys.length > 0) {
                var maxCount = lineSeries1.count; // Semua ter-append bersamaan
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

                // Mengganti titik dua pada waktu agar tidak eror saat membuat nama file di OS tertentu
                var safeTime = timeField.text.trim().replace(/:/g, "-");
                var fileName = `${customerField.text.trim()}_${safeTime}_${testName}.csv`;
                var data = `${testName}\nTime,${current_keys.join(",")}\n`;

                for (var k = 0; k < lineSeriesData.length; k++) {
                    data += `${lineSeriesData[k].join(",")}\n`;
                }

                mainApp.save_test_data(fileName, data);
                console.log("Test data saved.");
            }
        }

        function updatePlot() {
            if (!testing || current_keys.length === 0) return;
            
            timeField.text = Qt.formatDateTime(new Date(), "HH:mm:ss");

            var seriesList = [lineSeries1, lineSeries2, lineSeries3, lineSeries4, lineSeries5, lineSeries6];

            for (var i = 0; i < current_keys.length; i++) {
                var key = current_keys[i];
                var val = mainApp.value[key];
                
                seriesList[i].append(seriesList[i].count, val);
                seriesList[i].name = key;
                seriesList[i].visible = true;
            }

            // Sembunyikan series yang tidak digunakan
            for (var j = current_keys.length; j < 6; j++) {
                seriesList[j].visible = false;
            }

            // Geser sumbu X otomatis
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

                TextField {
                    id: customerField
                    width: parent.width - 20
                    placeholderText: "Nama Customer"
                }

                TextField {
                    id: projectField
                    width: parent.width - 20
                    placeholderText: "Deskripsi Proyek"
                }

                Row {
                    spacing: 10

                    TextField {
                        id: timerInput
                        placeholderText: "Waktu Pengujian"
                        validator: DoubleValidator {}
                        width: (parent.parent.width - 30) / 2
                    }

                    Text {
                        id: timerField
                        anchors.verticalCenter: timerInput.verticalCenter
                        font.pixelSize: 16
                        text: "(Menit)"
                    }
                }

                Text {
                    text: "Pilih Parameter Uji:"
                    font.bold: true
                    font.pixelSize: 14
                    color: "#333"
                }

                // Grid Layout agar checkbox rapi dan tidak terlalu panjang ke bawah
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
                    text: testing ? "Testing..." : "Start"
                    width: parent.width - 20
                    enabled: !testing && 
                             (cb_curr_v.checked || cb_aktual.checked || cb_press_in.checked || cb_press_a.checked || cb_press_b.checked || cb_flow.checked) && 
                             customerField.text.trim() !== "" && timerInput.text.trim() !== ""
                    
                    background: Rectangle {
                        color: startButton.pressed ? "#333" : "#fff"
                        radius: 5
                        border.color: "#555"
                        border.width: 1
                        opacity: 1

                        DropShadow {
                            horizontalOffset: 3
                            verticalOffset: 3
                            radius: 5
                            samples: 5
                            color: "#aa000000"
                            source: parent
                        }
                    }
                    onClicked: {
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

    function startTest() {
        var timer = timerInput.text * 60000;
        var testTimer = Qt.createQmlObject('import QtQuick 2.15; Timer { interval: 0; running: false; repeat: false; }', graphPage);
        testTimer.interval = timer;

        chartView.setupPlot();
        chartView.title = "Testing: " + current_keys.join(", ");

        testTimer.running = true;

        testTimer.triggered.connect(function() {
            Qt.callLater(function() {
                chartView.saveTestData("Custom_Test");
                testTimer.destroy();
                resetTest();
                testing = false;
                chartView.title = "Test Completed";
            }, 500);
        });
    }

    function resetTest() {
        axisX.min = 0;
        axisX.max = 10;
        chartView.children.forEach(function(child) {
            if (child.toString().indexOf("LineSeries") !== -1) {
                child.clear();
            }
        });
    }

    Connections {
        target: mainApp
    }
}
