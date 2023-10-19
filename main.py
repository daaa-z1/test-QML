import sys
from PyU6 import U6
from PyQt5.QtCore import QCoreApplication, QObject, QUrl, QTimer, Slot, Property
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

class LabJackReader(QObject):
    def __init__(self):
        super().__init__()
        self.labjack = U6()
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.read_ain0)
        self.timer.start(1000)  # Baca setiap 1 detik
        self.ain0_value = 0.0

    @Slot()
    def read_ain0(self):
        try:
            self.ain0_value = self.labjack.getAIN(0)
        except Exception as e:
            print(f"Error reading AIN0: {e}")

    @Property(float)
    def ain0(self):
        return self.ain0_value

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    labjack_reader = LabJackReader()

    engine.rootContext().setContextProperty("labjackReader", labjack_reader)

    engine.load(QUrl("main.qml"))
    
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
