import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage

    property var seriesList: []
    property var chartView: null

    function addSeries(key) {
        var series = Qt.createQmlObject('import QtCharts 2.15; LineSeries {}', graphPage);
        series.name = key;
        seriesList.push(series);
        chartView.chart.addSeries(series);
    }

    function updateSeries(key, value) {
        for (var i = 0; i < seriesList.length; i++) {
            if (seriesList[i].name === key) {
                seriesList[i].append(new Date().getTime(), value);
                break;
            }
        }
    }

    ChartView {
        id: chartViewId
        anchors.fill: parent
        antialiasing: true

        ValueAxis {
            id: xAxis
            min: new Date().getTime()
            max: new Date().getTime() + 60000  // 1 minute
        }
        ValueAxis {
            id: yAxis
            min: 0
            max: 100
        }

        Component.onCompleted: {
            chartView = chartViewId;
            chartViewId.chart.addAxis(xAxis, Qt.AlignBottom);
            chartViewId.chart.addAxis(yAxis, Qt.AlignLeft);
            for (var i = 0; i < seriesList.length; i++) {
                seriesList[i].attachAxis(xAxis);
                seriesList[i].attachAxis(yAxis);
            }
        }
    }

    Component.onCompleted: {
        for (var i = 0; i < mainApp.keys.length; i++) {
            addSeries(mainApp.keys[i]);
        }
        mainApp.valueChanged.connect(function() {
            for (var key in mainApp.value) {
                updateSeries(key, mainApp.value[key]);
            }
        });
    }
}
