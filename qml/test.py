import sys
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Variabel untuk mengatur nilai gauge
    voltageValue = 12.3  # Contoh nilai Voltage
    currentValue = 5.6       # Contoh nilai mA
    pressureValue = 25  # Contoh nilai tekanan fluida

    engine.rootContext().setContextProperty("voltageValue", voltageValue)
    engine.rootContext().setContextProperty("mAValue", currentValue)
    engine.rootContext().setContextProperty("pressureValue", pressureValue)

    engine.load("test.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
