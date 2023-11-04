import sys
import u6
import sqlite3
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot, QTimer
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication

class AINReader(QObject):
    newValue = pyqtSignal(int, float)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.device = u6.U6()
        self.koneksi = sqlite3.connect('data.db')  # Ganti dengan nama database Anda
        self.daftar_ain = self.ambil_daftar_ain()
        self.channels = self.daftar_ain[0]
        self.timer = QTimer()
        self.timer.timeout.connect(self.readValues)
        self.timer.start(1000)  # Baca nilai setiap detik

    def ambil_daftar_ain(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Measurements")
        return [i[2:] for i in cursor.fetchall()]

    @pyqtSlot()
    def readValues(self):
        for channel in self.channels:
            value = self.device.getAIN(channel)
            print(f"Channel: {channel}, Value: {value}")
            self.newValue.emit(channel, value)

if __name__ == "__main__":
    app = QApplication(sys.argv)

    ainReader = AINReader()

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("ainReader", ainReader)
    engine.load('qml/main.qml')

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
