import sys

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot

from koneksi import *

try:
    import u6
except:
    print("Driver error", '''The driver could not be imported.
Please install the UD driver (Windows) or Exodriver (Linux and Mac OS X) from www.labjack.com''')
    sys.exit(1)

class MainApp(QObject):
    def __init__(self):
        super().__init__()
        
        # Buat objek LabJack
        self.d = u6.U6()

        # Buat koneksi ke database
        self.koneksi = buat_koneksi()

        # Buat tabel konfigurasi jika belum ada
        buat_tabel_konfigurasi(self.koneksi)
        buat_tabel_pengukuran(self.koneksi)
        buat_tabel_swtich(self.koneksi)

        # Ambil data konfigurasi dari database
        self.daftar_konfigurasi = self.ambil_daftar_konfigurasi()
        self.daftar_pengukuran = self.ambil_daftar_pengukuran()
        self.daftar_switch = self.ambil_daftar_switch()
        
        # Pastikan tabel Measurements memiliki satu ID
        self.pastikan_tabel_memiliki_id("Measurements", self.config_id, self.data_pengukuran)
        # Pastikan tabel Limits memiliki satu ID
        self.pastikan_tabel_memiliki_id("Limits", self.config_id, self.data_batasan)
        # Pastikan tabel Switch memiliki satu ID
        self.pastikan_tabel_memiliki_id("Switch", self.config_id, self.data_switch)

        # Inisialisasi parameter terpilih ke None
        self.selectedParameter = None

    # Fungsi untuk mengambil daftar konfigurasi dari database
    def ambil_daftar_konfigurasi(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT Name FROM Configurations")
        return [konfigurasi[1] for konfigurasi in cursor.fetchall()]
    
    # Fungsi untuk mengambil daftar pengukuran dari database
    def ambil_daftar_pengukuran(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Measurements")
        return cursor.fetchall()

    # Fungsi untuk mengambil daftar switch dari database
    def ambil_daftar_switch(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Switch")
        return cursor.fetchall()
    
    # Fungsi untuk memastikan bahwa tabel sudah memiliki satu ID
    def pastikan_tabel_memiliki_id(self, nama_tabel, config_id, default_data):
        cursor = self.koneksi.cursor()
        cursor.execute(f"SELECT COUNT(*) FROM {nama_tabel} WHERE Config_ID=?", (config_id,))
        count = cursor.fetchone()[0]
        if count == 0:
            if nama_tabel == "Measurements":
                tambah_pengukuran(self.koneksi, config_id, default_data)
            elif nama_tabel == "Limits":
                tambah_batasan(self.koneksi, config_id, default_data)
            elif nama_tabel == "Switch":
                tambah_switch(self.koneksi, config_id, default_data)

    # Sinyal untuk mengirim parameter yang dipilih dari QML ke Python
    parameterSelectedSignal = pyqtSignal(str)
    
    # Slot untuk menangani perubahan parameter yang dipilih dari QML
    @pyqtSlot(str)
    def parameterSelected(self, selectedParameter):
        # Mengatur parameter yang dipilih
        self.selectedParameter = selectedParameter

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    mainApp = MainApp()

    # Menyediakan data model untuk ComboBox di QML
    parameterModel = mainApp.daftar_konfigurasi

    # Mengikat sinyal dan slot antara Python dan QML
    engine.rootContext().setContextProperty("mainApp", mainApp)
    engine.rootContext().setContextProperty("parameterModel", parameterModel)

    engine.load("qml/main.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
