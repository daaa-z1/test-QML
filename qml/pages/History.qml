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
            name: seriesNames[1]
            
        }

        LineSeries {
            id: lineSeries2
            axisX: axisX
            axisY: axisY
            name: seriesNames[2]
        }

        LineSeries {
            id: lineSeries3
            axisX: axisX
            axisY: axisY
            name: seriesNames[3]
        }

        LineSeries {
            id: lineSeries4
            axisX: axisX
            axisY: axisY
            name: seriesNames[4]
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
        var minY = Infinity;
        var maxY = -Infinity;
        for (var i = 0; i < csvData.length; i++) {
            lineSeries1.append(csvData[i][0], csvData[i][1]);
            minY = Math.min(minY, csvData[i][1]);
            maxY = Math.max(maxY, csvData[i][1]);
            if (csvData[i].length > 2) {
                lineSeries2.append(csvData[i][0], csvData[i][2]);
                minY = Math.min(minY, csvData[i][2]);
                maxY = Math.max(maxY, csvData[i][2]);
            }
            if (csvData[i].length > 3) {
                lineSeries3.append(csvData[i][0], csvData[i][3]);
                minY = Math.min(minY, csvData[i][3]);
                maxY = Math.max(maxY, csvData[i][3]);
            }
            if (csvData[i].length > 4) {
                lineSeries4.append(csvData[i][0], csvData[i][4]);
                minY = Math.min(minY, csvData[i][4]);
                maxY = Math.max(maxY, csvData[i][4]);
            }
        }
        axisY.min = minY;
        axisY.max = maxY;
    }
}
