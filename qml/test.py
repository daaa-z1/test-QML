import sys
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSlot

class PageController(QObject):
    def __init__(self):
        super().__init__()

    @pyqtSlot(str)
    def changePage(self, pageName):
        # Hapus halaman yang aktif dari StackView
        stackView.pop()

        # Tambahkan halaman baru ke StackView
        stackView.push(pageName)

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

    # Tambahkan controller untuk mengubah halaman
    controller = PageController()
    engine.rootContext().setContextProperty("pageController", controller)

    # Muat halaman utama
    engine.load("main.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
