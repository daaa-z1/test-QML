import sys
from PyQt5.QtCore import Qt, QUrl
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
from u6 import U6

if __name__ == "__main__":
    app = QApplication(sys.argv)

    # Inisialisasi LabJack U6
    with U6() as u6:
        # Membaca nilai AIN0
        u6Value = u6.getAIN(0)

        # Menginisialisasi QML Engine
        engine = QQmlApplicationEngine()
        engine.rootContext().setContextProperty("u6Value", u6Value)

        # Memuat berkas QML
        engine.load(QUrl("main.qml"))

        # Menampilkan GUI
        sys.exit(app.exec_())
