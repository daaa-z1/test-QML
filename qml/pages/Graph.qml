import QtQuick 2.0
import QtCharts 2.0

Page {
    visible: true
    width: 640
    height: 480
    title: "Contoh Aplikasi"

    ChartView {
        id: chartView
        title: "Temperature"
        anchors.fill: parent
        antialiasing: true

        LineSeries {
            id: lineSeries
            name: "Temperature"
        }

        Component.onCompleted: {
            labJackReader.dataReady.connect(updateData);
            labJackReader.readData();
        }

        function updateData(temperature) {
            lineSeries.append(new Date().getTime(), temperature);
            labJackReader.readData();
        }
    }
}
