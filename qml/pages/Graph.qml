import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage
    ChartView {
        title: "Grafik Real-Time"
        width: 400
        height: 300

        LineSeries {
            id: lineSeries
            name: "Data"
        }

        Component.onCompleted: {
            var i = 0;
            var timer = new Timer();
            timer.interval = 100; // Update setiap 100 ms
            timer.repeat = true;
            timer.triggered.connect(function() {
                var y = Math.sin(i);
                lineSeries.append(i, y);
                i += 0.1;
            });
            timer.start();
        }
    }
}
