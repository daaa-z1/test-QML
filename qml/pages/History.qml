import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15
import QtQuick.Dialogs 1.3

Page {
    id: csvPage

    property string csvFile: ""
    property var csvData: []
    property var seriesNames: []
    property string currentTest: ""

    FileDialog {
        id: fileDialog
        title: "Please choose a CSV file"
        nameFilters: ["CSV files (*.csv)"]
        onAccepted: {
            csvPage.csvFile = fileDialog.fileUrl
            csvPage.loadCsvData()
        }
    }

    ChartView {
        id: chartView
        anchors.fill: parent
        title: csvPage.currentTest
        legend.visible: true
        antialiasing: true
        title: "Please choose a CSV file"
        theme: ChartView.ChartThemeDark

        ValueAxis {
            id: axisX
            min: 0
            max: csvData.length
        }

        ValueAxis {
            id: axisY
        }

        LineSeries {
            id: lineSeries1
            axisX: axisX
            axisY: axisY
            visible: false
            name: seriesNames[1]
            
        }

        LineSeries {
            id: lineSeries2
            axisX: axisX
            axisY: axisY
            visible: false
            name: seriesNames[2]
        }

        LineSeries {
            id: lineSeries3
            axisX: axisX
            axisY: axisY
            visible: false
            name: seriesNames[3]
        }

        LineSeries {
            id: lineSeries4
            axisX: axisX
            axisY: axisY
            visible: false
            name: seriesNames[4]
        }

        Component.onCompleted: {
            csvData = [];
            currentTest = "";
            lineSeries1.visible = false;
            lineSeries2.visible = false;
            lineSeries3.visible = false;
            lineSeries4.visible = false;
        }
    }

    Button {
        id: openButton
        text: "Open CSV"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        onClicked: fileDialog.open()
    }

    function loadCsvData() {
        var xhr = new XMLHttpRequest();
        seriesNames = [];
        currentTest = ""
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var lines = xhr.responseText.split('\n');
                seriesNames = lines[0].split(',');
                csvPage.currentTest = lines[1];
                csvData = lines.slice(1).map(function(line) {
                    return line.split(',').map(function(value) { return parseFloat(value) });
                });
                updateChart();
            }
        }
        xhr.open("GET", csvFile);
        xhr.send();
    }

    function updateChart() {
        lineSeries1.clear();
        lineSeries2.clear();
        lineSeries3.clear();
        lineSeries4.clear();

        if (currentTest === "Position Test") {
            axisY.min = mainApp.parameter('aktual', 'minValue') - 2;
            axisY.max = mainApp.parameter('aktual', 'maxValue') + 2;
        } else if (currentTest === "Flow Test") {
            axisY.min = mainApp.parameter('press_in', 'minValue') - 10;
            axisY.max = mainApp.parameter('press_in', 'maxValue') + 10;
        } else if (currentTest === "Leakage Test") {
            axisY.min = mainApp.parameter('press_in', 'minValue') - 10;
            axisY.max = mainApp.parameter('press_in', 'maxValue') + 10;
        }

        lineSeries1.visible = seriesNames.length > 1 ? true : false;
        lineSeries2.visible = seriesNames.length > 2 ? true : false;
        lineSeries3.visible = seriesNames.length > 3 ? true : false;
        lineSeries4.visible = seriesNames.length > 4 ? true : false;

        for (var i = 0; i < csvData.length; i++) {
            lineSeries1.append(csvData[i][0], csvData[i][1]);
            if (csvData[i].length > 2) {
                lineSeries2.append(csvData[i][0], csvData[i][2]);
            }
            if (csvData[i].length > 3) {
                lineSeries3.append(csvData[i][0], csvData[i][3]);
            }
            if (csvData[i].length > 4) {
                lineSeries4.append(csvData[i][0], csvData[i][4]);
            }
        }
    }
}
