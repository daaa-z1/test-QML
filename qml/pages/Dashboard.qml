import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

Page {
    id: dashboardPage

    property var ainData: [
        { label: "Pressure A", value: 30, minValue: 0, maxValue: 100 },
        { label: "Actual" value: 50, minValue: 0, maxValue: 100 },
        { label: "Actual" value: 70, minValue: 0, maxValue: 100 },
        { label: "Actual" value: 40, minValue: 0, maxValue: 100 },
        { label: "Actual" value: 60, minValue: 0, maxValue: 100 },
        { label: "Actual" value: 20, minValue: 0, maxValue: 100 },
        { label: "Actual" value: 80, minValue: 0, maxValue: 100 },
        { label: "Actual" value: 90, minValue: 0, maxValue: 100 }
    ]

    contentItem: Item {
        width: parent.width
        height: parent.height

        GridLayout {
            id: gaugeGrid
            columns: 4
            anchors.centerIn: parent
            rowSpacing: 10
            columnSpacing: 10

            Repeater {
                model: ainData.length
                Item {
                    width: gaugeGrid.cellWidth
                    height: gaugeGrid.cellHeight

                    CircularGauge {
                        id: gauge
                        width: parent.width
                        height: parent.height
                        value: ainData[index].value
                        minimumValue: ainData[index].minValue
                        maximumValue: ainData[index].maxValue

                        Label {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            text: ainData[index].label
                            font.pixelSize: 20
                            color: "#3498db"
                        }
                    }
                }
            }
        }
    }

    onWidthChanged: {
        // Menyesuaikan lebar Gauge saat tampilan berubah
        for (var i = 0; i < gaugeGrid.count; i++) {
            gaugeGrid.itemAt(i).width = gaugeGrid.cellWidth;
            gaugeGrid.itemAt(i).height = gaugeGrid.cellHeight;
            gaugeGrid.itemAt(i).children[0].width = gaugeGrid.itemAt(i).width;
            gaugeGrid.itemAt(i).children[0].height = gaugeGrid.itemAt(i).height;
        }
    }

    onHeightChanged: {
        // Menyesuaikan tinggi Gauge saat tampilan berubah
        for (var i = 0; i < gaugeGrid.count; i++) {
            gaugeGrid.itemAt(i).width = gaugeGrid.cellWidth;
            gaugeGrid.itemAt(i).height = gaugeGrid.cellHeight;
            gaugeGrid.itemAt(i).children[0].width = gaugeGrid.itemAt(i).width;
            gaugeGrid.itemAt(i).children[0].height = gaugeGrid.itemAt(i).height;
        }
    }
}
