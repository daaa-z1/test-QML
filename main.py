import sys
from PyQt5.QtCore import Qt, QUrl, pyqtProperty, pyqtSignal, pyqtSlot
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
from u6 import U6

class LabJackU6Reader:
    def __init__(self):
        self.u6 = U6()

    def readAIN0(self):
        value = self.u6.getAIN(0)
        return value

if __name__ == "__main__":
    app = QApplication(sys.argv)

    engine = QQmlApplicationEngine()

    # Membuat instance dari kelas LabJackU6Reader
    reader = LabJackU6Reader()
    engine.rootContext().setContextProperty("labJackReader", reader)

    # Memuat berkas QML
    engine.load(QUrl("main.qml"))

    sys.exit(app.exec_())
