import sys
from PyQt5.QtCore import QObject, pyqtSlot, QTimer, QUrl
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView
import labjack

class LabJackReader(QObject):
    def __init__(self):
        super().__init__()
        self.labjack_device = labjack.LabJack()
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.read_ain0)
        self.timer.start(1000)  # Baca setiap 1 detik

    @pyqtSlot(result=float)
    def read_ain0(self):
        value = self.labjack_device.readAIN(0)
        return value

if __name__ == '__main__':
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    labjack_reader = LabJackReader()
    engine.rootContext().setContextProperty("labjackReader", labjack_reader)

    engine.load(QUrl("main.qml"))
    sys.exit(app.exec_())
