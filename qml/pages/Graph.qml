import QtQuick 2.15
import QtCharts 2.15

ChartView {
    id: chartView
    width: parent.width
    height: parent.height

    LineSeries {
        name: "Graph"
        XYPoint { x: 0; y: mainApp.value['curr_v'] }
        XYPoint { x: 1; y: mainApp.value['aktual'] }
        // Tambahkan XYPoint lain sesuai dengan jumlah data yang ingin ditampilkan
    }

    ValueAxis {
        id: axisX
        min: 0
        max: 10  // Sesuaikan dengan jumlah data yang ingin ditampilkan
        labelFormat: "%.0f"
    }

    ValueAxis {
        id: axisY
        min: 0
        max: 100  // Sesuaikan dengan rentang nilai yang ingin ditampilkan
        labelFormat: "%.0f"
    }

    Component.onCompleted: {
        chartView.createDefaultAxes()
    }

    Connections {
        target: mainApp
        onValueChanged: {
            // Tambahkan logika untuk menambahkan nilai ke LineSeries saat nilai berubah
            chartView.series[0].append(mainApp.value['curr_v'], mainApp.value['aktual'])
        }
    }
}
