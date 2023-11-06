import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot, QTimer
from koneksi import *

try:
    import u6
except:
    print("Driver error", '''The driver could not be imported.
Please install the UD driver (Windows) or Exodriver (Linux and Mac OS X) from www.labjack.com''')
    sys.exit(1)

class MainApp(QObject):
    newValue = pyqtSignal(float, float, float, float, float, float, float, float)
    minValues = pyqtSignal(float, float, float, float, float, float, float, float)
    maxValues = pyqtSignal(float, float, float, float, float, float, float, float)

    def __init__(self, parent=None):
        super().__init__(parent)

        # Buat objek LabJack
        self.d = u6.U6()

        # Buat koneksi ke database
        self.koneksi = buat_koneksi()

        # Buat tabel konfigurasi jika belum ada
        buat_tabel_konfigurasi(self.koneksi)
        buat_tabel_pengukuran(self.koneksi)
        buat_tabel_batasan(self.koneksi)
        buat_tabel_switch(self.koneksi)

        # Memastikan bahwa tabel memiliki satu ID, jika belum, tambahkan data default
        self.periksa_tabel_default()

        # Ambil data konfigurasi dari database
        self.daftar_konfigurasi = self.ambil_daftar_konfigurasi()
        self.daftar_ain = self.ambil_daftar_ain()
        self.daftar_min = self.ambil_daftar_min()
        self.daftar_max = self.ambil_daftar_max()
        self.daftar_switch = self.ambil_daftar_switch()

        self.timer = QTimer()
        self.timer.timeout.connect(self.readValues)
        self.timer.start(100)

        # Inisialisasi parameter terpilih ke None
        self.selectedParameter = None

    # Fungsi untuk memastikan bahwa tabel memiliki satu ID, jika belum, tambahkan data default
    def periksa_tabel_default(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT ID FROM Configurations WHERE Name='Default'")
        result = cursor.fetchone()
        if result is None:
            # Tambahkan konfigurasi "Default" dan mendapatkan ID-nya
            config_id = tambah_konfigurasi(self.koneksi, "Default")

            # Tambahkan data pengukuran dan data batasan sesuai dengan ID konfigurasi
            data_pengukuran = {
                "Pressure_In": 0,
                "Pressure_A": 1,
                "Pressure_B": 2,
                "Flow": 3,
                "Temp": 4,
                "Curr_V": 5,
                "Aktual": 6,
                "Curr_MA": 7
            }

            data_batasan = {
                "Pressure_In_Min": 0,
                "Pressure_In_Max": 100,
                "Pressure_A_Min": 0,
                "Pressure_A_Max": 100,
                "Pressure_B_Min": 0,
                "Pressure_B_Max": 100,
                "Flow_Min": 0,
                "Flow_Max": 100,
                "Temp_Min": 0,
                "Temp_Max": 100,
                "Curr_V_Min": -5,
                "Curr_V_Max": 5,
                "Aktual_Min": -5,
                "Aktual_Max": 5,
                "Curr_MA_Min": -5,
                "Curr_MA_Max": 5,
            }

            data_switch = {
                "Btn1": 0,
                "Btn2": 1,
                "Btn3": 2,
                "Btn4": 3,
                "Btn5": 4,
                "Btn6": 5
            }

            tambah_pengukuran(self.koneksi, config_id, data_pengukuran)
            tambah_batasan(self.koneksi, config_id, data_batasan)
            tambah_switch(self.koneksi, config_id, data_switch)

    # Fungsi untuk mengambil daftar konfigurasi dari database
    def ambil_daftar_konfigurasi(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT Name FROM Configurations")
        return [konfigurasi[0] for konfigurasi in cursor.fetchall()]

    # Fungsi untuk mengambil daftar pengukuran dari database
    def ambil_daftar_ain(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Measurements")
        return [i[2:] for i in cursor.fetchall()]

    # Fungsi untuk mengambil min dan max dari database
    def ambil_daftar_min(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Limits")
        return [i[2::2] for i in cursor.fetchall()]

    def ambil_daftar_max(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Limits")
        return [i[3::2] for i in cursor.fetchall()]

    # Fungsi untuk mengambil daftar switch dari database
    def ambil_daftar_switch(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Switch")
        return [konfigurasi[2:] for konfigurasi in cursor.fetchall()]

    # Metode untuk membaca data dari LabJack U6 dan mengirimkannya ke QML
    @pyqtSlot()
    def readValues(self):
        value = [self.d.getAIN(ain) for ain in self.daftar_ain[0]]
        self.newValue.emit(*value)

    # Metode untuk membaca min value dari database
    @pyqtSlot()
    def readMinValues(self):
        minValue = [i for i in self.daftar_min[0]]
        print(*minValue)
        self.minValues.emit(*minValue)
        return minValue

    # Metode untuk membaca max value dari database
    @pyqtSlot()
    def readMaxValues(self):
        maxValue = [i for i in self.daftar_max[0]]
        print(*maxValue)
        self.maxValues.emit(*maxValue)
        return maxValue

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    ainReader = MainApp()

    # Menyediakan data model untuk ComboBox di QML
    parameterModel = ainReader.daftar_konfigurasi

    # Mengikat sinyal dan slot antara Python dan QML
    engine.rootContext().setContextProperty("parameterModel", parameterModel)
    engine.rootContext().setContextProperty("ainReader", ainReader)

    engine.load("qml/main.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
