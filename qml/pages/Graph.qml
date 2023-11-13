import QtQuick 2.0
import QtCharts 2.0

Page {
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
            var timer = new Qtimer();
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