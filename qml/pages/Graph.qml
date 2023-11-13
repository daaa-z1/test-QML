import QtQuick 2.15
import QtCharts 2.15

Page {
    id: graphPage
    ChartView {
        title: "Grafik Real-Time"
        
        anchors.fill: parent
        

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
