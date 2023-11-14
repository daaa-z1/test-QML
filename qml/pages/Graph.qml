// Graph.qml

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4
import QtCharts 2.15

Page {
    id: graphPage

    ListModel {
        id: graphModel
    }

    ChartView {
        id: chartView
        anchors.fill: parent
        theme: ChartView.ChartThemeLight

        LineSeries {
            name: "Graph Series"
            XYPoint { x: 0; y: 0 }

            // Add more XYPoints as needed
        }
    }

    Component.onCompleted: {
        if (mainApp) {
            mainApp.graphValue.connect(function(values) {
                for (var i = 0; i < values.length; i++) {
                    graphModel.append({ "x": i, "y": values[i] });
                }
            });
        }
    }
}
