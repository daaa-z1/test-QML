import sys
from PyQt5.QtCore import QObject, pyqtSlot, pyqtProperty, QUrl, Qt
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from labjack_unified.devices import LabJackU6

class LabJack(QObject):
    def __init__(self):
        QObject.__init__(self)
        self._device = LabJackU6()
        self._ain0 = 0

    @pyqtSlot()
    def readAIN0(self):
        self._ain0 = self._device.get_analog(AIN0)

    @pyqtProperty(float)
    def ain0(self):
        return self._ain0

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    labjack = LabJack()
    engine.rootContext().setContextProperty("labjack", labjack)
    engine.load(QUrl("main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
