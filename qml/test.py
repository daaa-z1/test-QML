import sys
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSlot
from labjack import LabJackReader

activePage = None

def switchPage(pageName):
    global activePage
    if activePage:
        activePage.setVisible(False)
    activePage = engine.rootObjects()[0].findChild(QObject(), pageName)
    if activePage:
        activePage.setVisible(True)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Variabel untuk mengatur nilai gauge di halaman Dashboard
    voltageValue = 120
    currentValue = 500
    pressureValue = 50

    # Hubungkan variabel Python dengan variabel QML
    engine.rootContext().setContextProperty("voltageValue", voltageValue)
    engine.rootContext().setContextProperty("currentValue", currentValue)
    engine.rootContext().setContextProperty("pressureValue", pressureValue)

    # Hubungkan fungsi Python ke QML
    engine.rootContext().setContextProperty("switchPage", switchPage)
    
    # Membuat instance dari LabJackReader dan mendaftarkannya ke QML
    reader = LabJackReader()
    engine.rootContext().setContextProperty("labJackReader", reader)

    # Muat halaman utama
    engine.load("test.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
