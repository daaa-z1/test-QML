import sys
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

# Inisialisasi aplikasi Qt
app = QGuiApplication(sys.argv)

# Inisialisasi mesin QML
engine = QQmlApplicationEngine()

# Tentukan file QML utama
engine.load('qml/main.qml')

# Eksekusi aplikasi
sys.exit(app.exec_())
