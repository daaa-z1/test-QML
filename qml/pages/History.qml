import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15
import QtQuick.Dialogs 1.3

Page {
    id: csvPage

    property string csvFile: ""
    property var csvData: []

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
        title: "CSV Data"
        legend.visible: true
        antialiasing: true

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
        }

        LineSeries {
            id: lineSeries2
            axisX: axisX
            axisY: axisY
        }

        LineSeries {
            id: lineSeries3
            axisX: axisX
            axisY: axisY
        }

        LineSeries {
            id: lineSeries4
            axisX: axisX
            axisY: axisY
        }
    }

    Button {
        id: openButton
        text: "Open CSV"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: fileDialog.open()
    }

    function loadCsvData() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                csvData = xhr.responseText.split('\n').map(function(line) {
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
