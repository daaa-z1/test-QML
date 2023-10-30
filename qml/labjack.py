import u6
from PyQt5.QtCore import QTimer, QObject
from PyQt5.QtQuick import QQuickPaintedItem
import pyqtgraph as pg
import numpy as np

class LabJackReader(QQuickPaintedItem):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.data = np.array([])

        # Buat objek LabJack U6
        self.d = u6.U6()

        # Buat timer untuk memperbarui data setiap detik
        self.timer = QTimer()
        self.timer.timeout.connect(self.update_data)
        self.timer.start(1000)

    def paint(self, painter):
        painter.setRenderHint(QPainter.Antialiasing)
        pen = painter.pen()
        pen.setColor(QColor("white"))
        pen.setWidth(2)
        painter.setPen(pen)

        w = self.width()
        h = self.height()

        if len(self.data) > 1:
            px = np.linspace(0, w, len(self.data))
            py = (h/2) + (self.data * h/4)
            path = pg.arrayToQPath(px, py)
            painter.drawPath(path)

    def update_data(self):
        self.data = np.append(self.data[-(self.width()-1):], self.d.getTemperature())
        self.update()
