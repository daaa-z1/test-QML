import sys
import queue
import time
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot, QTimer, pyqtProperty
from koneksi import *

try:
    import u6
except:
    print("Driver error", '''The driver could not be imported.
Please install the UD driver (Windows) or Exodriver (Linux and Mac OS X) from www.labjack.com''')
    sys.exit(1)

class MainApp(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

        # Buat objek LabJack
        self.d = u6.U6()

        # Buat koneksi ke database
        self.koneksi = buat_koneksi()

        # Buat tabel konfigurasi jika belum ada
        buat_tabel_konfigurasi(self.koneksi)
        buat_tabel_batasan(self.koneksi)
        buat_tabel_switch(self.koneksi)
        buat_tabel_scaling(self.koneksi)

        # Memastikan bahwa tabel memiliki satu ID, jika belum, tambahkan data default
        self.periksa_tabel_default()

        # Ambil data konfigurasi dari database
        self.daftar_konfigurasi = self.ambil_daftar_konfigurasi()
        self.daftar_ain = [(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)]
        self.daftar_min = self.ambil_daftar_min()
        self.daftar_max = self.ambil_daftar_max()
        self.daftar_min_scale = self.ambil_daftar_min_scaling()
        self.daftar_max_scale = self.ambil_daftar_max_scaling()
        self.daftar_switch = self.ambil_daftar_switch()
        self.daftar_state = self.ambil_daftar_state()
        
        # Setup Parameter dan Value
        self.keys = ['press_in', 'press_a', 'press_b', 'flow', 'temp', 'curr_v', 'aktual', 'curr_ma', 'press_comm', 'press_actual']

        self.parameter = {key: {'minValue': self.daftar_min[0][i], 'maxValue': self.daftar_max[0][i], 'minScale': self.daftar_min_scale[0][i], 'maxScale': self.daftar_max_scale[0][i]} for i, key in enumerate(self.keys)}
        
        self.timer = QTimer()
        self.timer.timeout.connect(self.readValues)
        self.timer.start(100)
        self.tests = queue.Queue()
        
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
                "Curr_V_Min": -10,
                "Curr_V_Max": 10,
                "Aktual_Min": -10,
                "Aktual_Max": 10,
                "Curr_MA_Min": 0,
                "Curr_MA_Max": 5,
                "Press_Com_Min": 0,
                "Press_Com_Max": 5,
                "Press_Aktual_Min": 0,
                "Press_Aktual_Max": 5,
            }
            
            data_scaling = {
                "Pressure_In_Scale_Min": 0,
                "Pressure_In_Scale_Max": 5,
                "Pressure_A_Scale_Min": 0,
                "Pressure_A_Scale_Max": 5,
                "Pressure_B_Scale_Min": 0,
                "Pressure_B_Scale_Max": 5,
                "Flow_Scale_Min": 0,
                "Flow_Scale_Max": 5,
                "Temp_Scale_Min": 0,
                "Temp_Scale_Max": 100,
                "Curr_V_Scale_Min": -5,
                "Curr_V_Scale_Max": 5,
                "Aktual_Scale_Min": -5,
                "Aktual_Scale_Max": 5,
                "Curr_MA_Scale_Min": -5,
                "Curr_MA_Scale_Max": 5,
                "Press_Com_Scale_Min": 0,
                "Press_Com_Scale_Max": 5,
                "Press_Aktual_Scale_Min": 0,
                "Press_Aktual_Scale_Max": 5,
            }

            data_switch = {
                "Btn1": 0,
                "Btn2": 1,
                "Btn3": 2,
                "Btn4": 3,
                "Btn5": 4,
                "Btn6": 5,
                "Btn7": 6,
                "Btn8": 7,
                "Btn9": 8,
                "Btn10": 9,
                "Btn11": 10,
                "Btn12": 11,
                "Btn13": 12,
                "Btn14": 13,
                "Btn15": 14,
                "Btn16": 15,
                "Btn17": 16,
                "Btn18": 17,
                "Btn19": 18,
                "Btn20": 19,
                "Btn21": 20,
                "Btn22": 21,
                "Btn23": 21
            }

            data_state = {
                "Btn1_State": 0,
                "Btn2_State": 0,
                "Btn3_State": 0,
                "Btn4_State": 0,
                "Btn5_State": 0,
                "Btn6_State": 0,
                "Btn7_State": 0,
                "Btn8_State": 0,
                "Btn9_State": 0,
                "Btn10_State": 0,
                "Btn11_State": 0,
                "Btn12_State": 0,
                "Btn13_State": 0,
                "Btn14_State": 0,
                "Btn15_State": 0,
                "Btn16_State": 0,
                "Btn17_State": 0,
                "Btn18_State": 0,
                "Btn19_State": 0,
                "Btn20_State": 0,
                "Btn21_State": 0,
                "Btn22_State": 0,
                "Btn23_State": 0
            }

            tambah_batasan(self.koneksi, config_id, data_batasan)
            tambah_switch(self.koneksi, config_id, data_switch)
            tambah_state(self.koneksi, config_id, data_state)
            tambah_scaling(self.koneksi, config_id, data_scaling)

    # Fungsi untuk mengambil daftar konfigurasi dari database
    def ambil_daftar_konfigurasi(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT Name FROM Configurations")
        return [konfigurasi[0] for konfigurasi in cursor.fetchall()]

    # Fungsi untuk mengambil min dan max dari database
    def ambil_daftar_min(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Limits")
        return [i[2::2] for i in cursor.fetchall()]

    def ambil_daftar_max(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Limits")
        return [i[3::2] for i in cursor.fetchall()]
    
    # Fungsi untuk mengambil min dan max scaling dari database
    def ambil_daftar_min_scaling(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Scaling")
        return [i[2::2] for i in cursor.fetchall()]

    def ambil_daftar_max_scaling(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Scaling")
        return [i[3::2] for i in cursor.fetchall()]

    # Fungsi untuk mengambil daftar switch dari database
    def ambil_daftar_switch(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM Switch")
        return [konfigurasi[2:] for konfigurasi in cursor.fetchall()]

    # Fungsi untuk mengambil daftar state dari database
    def ambil_daftar_state(self):
        cursor = self.koneksi.cursor()
        cursor.execute("SELECT * FROM State")
        return [konfigurasi[2:] for konfigurasi in cursor.fetchall()]

    newValue = pyqtSignal('QVariantList')
    @pyqtSlot()
    def readValues(self):
        value = [self.d.getAIN(ain) for ain in self.daftar_ain[0]]
        min_scale = self.daftar_min_scale[0]
        max_scale = self.daftar_max_scale[0]
        min_values = self.daftar_min[0]
        max_values = self.daftar_max[0]
        calculated_values = [(max_values[i] - min_values[i]) / (max_scale[i] - min_scale[i]) * (value[i] - min_scale[i]) for i in range(len(value))]
        self.value = {key: calculated_values[i] for i, key in enumerate(self.keys)}

    graphValue = pyqtSignal('QVariantList')
    @pyqtSlot()
    def readGraph(self):
        if not self.tests.empty():
            test = self.tests.get()
            test()
    
    @pyqtSlot()
    def startReading(self):
        self.timer.start(1000)
    
    @pyqtSlot()
    def stopReading(self):
        self.timer.stop()
        self.timer.start(100)
        while not self.tests.empty():
            self.tests.get()
    
    def positionTest(self):
        start_time = time.time()
        while time.time() - start_time < 10:
            self.graphValue.emit([self.ainData[6], self.ainData[7]])
            time.sleep(1)

    def flowTest(self):
        start_time = time.time()
        while time.time() - start_time < 10:
            self.graphValue.emit([self.ainData[0], self.ainData[4]])
            time.sleep(1)

    def leakageTest(self):
        start_time = time.time()
        while time.time() - start_time < 10:
            print(self.ainData[0], self.ainData[3])
            self.graphValue.emit([self.ainData[0], self.ainData[3]])
            time.sleep(1)
      
    addTestSignal = pyqtSignal(str)
    @pyqtSlot(str)
    def addTest(self, test):
        if test == "Position Test":
            self.tests.put(self.positionTest)
        elif test == "Flow Test":
            self.tests.put(self.flowTest)
        elif test == "Leakage Test":
            self.tests.put(self.leakageTest)
        self.addTestSignal.emit(test)
    
    # Metode untuk membaca min value dari database
    minValues = pyqtSignal('QVariantList')
    @pyqtProperty('QVariantList', notify=minValues)
    def readMinValues(self):
        return list(self.daftar_min[0])

    # Metode untuk membaca max value dari database
    maxValues = pyqtSignal('QVariantList')
    @pyqtProperty('QVariantList', notify=maxValues)
    def readMaxValues(self):
        return list(self.daftar_max[0])

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    mainApp = MainApp()
    print(mainApp.ainData)

    # Mengikat sinyal dan slot antara Python dan QML
    engine.rootContext().setContextProperty("mainApp", mainApp)
    engine.load("qml/main.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
