// Graph.qml

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    title: "Test Graph"

    // Widget grafik
    ChartView {
        id: chartView
        anchors.fill: parent
        legend.visible: true
    }

    // Tombol untuk memulai pengujian
    Button {
        text: "Start Test"
        onClicked: {
            mainApp.test_timer.start(10000) // Mulai pengujian setiap 10 detik
            mainApp.save_results = [] // Bersihkan hasil pengujian sebelumnya
            chartView.removeAllSeries() // Bersihkan grafik sebelumnya
        }
    }

    // Tombol untuk menyimpan hasil pengujian
    Button {
        text: "Save Results"
        onClicked: {
            mainApp.saveResultsToCSV()
        }
    }

    // Tombol untuk menghentikan pengujian
    Button {
        text: "Stop Test"
        onClicked: {
            mainApp.test_timer.stop()
        }
    }

    // Tombol untuk kembali ke halaman utama
    Button {
        text: "Back to Main Page"
        onClicked: {
            mainApp.test_timer.stop()
            stackView.pop()
        }
    }

    // Mengatur properti dari grafik
    Component.onCompleted: {
        var seriesList = []
        for (var i = 0; i < mainApp.test_types.length; ++i) {
            var series = chartView.createSeries(ChartView.SeriesTypeLine, mainApp.test_types[i], chartView.axisX, chartView.axisY)
            seriesList.push(series)
        }
        chartView.series = seriesList
    }

    // Menambahkan nilai ke dalam grafik saat ada perubahan pada nilai di Python
    Connections {
        target: mainApp
        onGraphUpdated: {
            for (var i = 0; i < mainApp.test_types.length; ++i) {
                var values = mainApp._value[mainApp.keys[i]]
                chartView.series[i].append(i, values)
            }
        }
    }
}
