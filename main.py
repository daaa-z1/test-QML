import sys
import os
import csv
from datetime import datetime
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine, QQmlComponent
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot, QTimer, pyqtProperty, QUrl
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
        buat_tabel_state(self.koneksi)
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
        self._parameter = {key: {'minValue': self.daftar_min[0][i], 'maxValue': self.daftar_max[0][i], 'minScale': self.daftar_min_scale[0][i], 'maxScale': self.daftar_max_scale[0][i]} for i, key in enumerate(self.keys)}
        self._value = {}
        
        # Setup Relay
        self.relayKeys = ['Relay1', 'Relay2', 'Relay3', 'Relay4', 'Relay5', 'Relay6', 'Relay7', 'Relay8', 'Relay9', 'Relay10', 'Relay11', 'Relay12', 'Relay13', 'Relay14', 'Relay15', 'Relay16', 'Relay17', 'Relay18', 'Relay19', 'Relay20', 'Relay21', 'Relay22', 'Relay23']
        self.relays = {key: {'pin': self.daftar_switch[0][i], 'state': self.daftar_state[0][i]} for i, key in enumerate(self.relayKeys)}
        
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
                "Press_Aktual_Max": 5
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
                "Press_Aktual_Scale_Max": 5
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
                "Btn23": 22
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
    
    
    valueChanged = pyqtSignal()
    @pyqtProperty('QVariantMap', notify=valueChanged)
    def value(self):
        return self._value
    
    @value.setter
    def value(self, val):
        self._value = val
        self.valueChanged.emit()

    @pyqtSlot(str, str, result=float)
    def parameter(self, key, param):
        if key in self._parameter and param in self._parameter[key]:
            return self._parameter[key][param]
        return 0.0
    
    @pyqtSlot()
    def readValues(self):
        value = [self.d.getAIN(ain) for ain in self.daftar_ain[0]]
        keys = self.keys
        min_scale = [self._parameter[key]['minScale'] for key in keys]
        max_scale = [self._parameter[key]['maxScale'] for key in keys]
        min_values = [self._parameter[key]['minValue'] for key in keys]
        max_values = [self._parameter[key]['maxValue'] for key in keys]
        calculated_values = [(max_values[i] - min_values[i]) / (max_scale[i] - min_scale[i]) * (value[i] - min_scale[i] + min_values[i]) for i in range(len(value))]
        calculated_values = [max(min(value, max_val), min_val) for value, max_val, min_val in zip(calculated_values, max_values, min_values)]
        calculated_values = [round(value, 2) for value in calculated_values]
        self.value = {key: calculated_values[i] for i, key in enumerate(keys)}
        
    # Save CSV file
    @pyqtSlot(str, str)
    def save_test_data(self, file_name, data):
        os.makedirs(os.path.join(os.getcwd(), 'log'), exist_ok=True)
        file_path = os.path.join(os.getcwd(), 'log', file_name)
        data = [row.split(',') for row in data.split('\n') if row]
        try:
            with open(file_path, 'w', newline='') as file:
                writer = csv.writer(file)
                writer.writerows(data)
            print(f"Data tersimpan dalam {file_path}")
        except Exception as e:
            print(f"Error saving test data: {e}")
    
    # UPDATE _parameter dari TextField
    parameterChanged = pyqtSignal()
    @pyqtSlot(str, str, float)
    def updateParameter(self, key, param, value):
        if key in self._parameter and param in self._parameter[key]:
            self._parameter[key][param] = value
            self.parameterChanged.emit()
    
    relaychanged = pyqtSignal()
    @pyqtSlot(str, bool)
    def setDOState1(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox1
        comboBox1Relays = []
        self.setDOStateForComboBox(relayKey, state, comboBox1Relays)

    @pyqtSlot(str, bool)
    def setDOState2(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox2
        comboBox2Relays = []
        self.setDOStateForComboBox(relayKey, state, comboBox2Relays)

    @pyqtSlot(str, bool)
    def setDOState3(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox3
        if relayKey == 'Relay2' and relayKey != 'nothing':
            comboBox3Relays = ["Relay2", "Relay3", "Relay4"]
        elif relayKey == 'nothing': 
            comboBox3Relays = ["nothing","Relay3", "Relay4"]
        else: comboBox3Relays = ["Relay3", "Relay4"]
        self.setDOStateForComboBox(relayKey, state, comboBox3Relays)

    @pyqtSlot(str, bool)
    def setDOState4(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox4
        if relayKey != 'nothing':
            comboBox4Relays = ["Relay5", "Relay6"]
        else: comboBox4Relays = ["nothing","Relay5", "Relay6"]
        self.setDOStateForComboBox(relayKey, state, comboBox4Relays)

    @pyqtSlot(str, bool)
    def setDOState5(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox4
        if relayKey != 'nothing': comboBox5Relays = ["Relay7", "Relay8", "Relay9"]
        else: comboBox5Relays = ["nothing","Relay7", "Relay8", "Relay9"]
        self.setDOStateForComboBox(relayKey, state, comboBox5Relays)

    @pyqtSlot(str, bool)
    def setDOState6(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox4
        if relayKey != 'nothing': comboBox6Relays = ["Relay10", "Relay11"]
        else: comboBox6Relays = ["nothing","Relay10", "Relay11"]
        self.setDOStateForComboBox(relayKey, state, comboBox6Relays)

    @pyqtSlot(str, bool)
    def setDOState7(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox4
        if relayKey != 'nothing': comboBox7Relays = ["Relay12", "Relay13", "Relay14"]
        else: comboBox7Relays = ["nothing","Relay12", "Relay13", "Relay14"]
        self.setDOStateForComboBox(relayKey, state, comboBox7Relays)

    @pyqtSlot(str, bool)
    def setDOState8(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox4
        if relayKey != 'nothing': comboBox8Relays = ["Relay15", "Relay16"]
        else: comboBox8Relays = ["nothing","Relay15", "Relay16"]
        self.setDOStateForComboBox(relayKey, state, comboBox8Relays)

    @pyqtSlot(str, bool)
    def setDOState9(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox4
        if relayKey != 'nothing': comboBox9Relays = ["Relay17", "Relay18", "Relay19"]
        else: comboBox9Relays = ["nothing","Relay17", "Relay18", "Relay19"]
        self.setDOStateForComboBox(relayKey, state, comboBox9Relays)

    @pyqtSlot(str, bool)
    def setDOState10(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox4
        if relayKey != 'nothing': comboBox10Relays = ["Relay20", "Relay21", "Relay22"]
        else: comboBox10Relays = ["nothing", "Relay20", "Relay21", "Relay22"]
        self.setDOStateForComboBox(relayKey, state, comboBox10Relays)

    @pyqtSlot(str, bool)
    def setDOState11(self, relayKey, state):
        # Daftar relay yang terdaftar di ComboBox4
        if relayKey != 'nothing': comboBox11Relays = []
        else: comboBox11Relays = ["nothing","Relay23"]
        self.setDOStateForComboBox(relayKey, state, comboBox11Relays)

    def setDOStateForComboBox(self, relayKey, state, comboBoxRelays):
        # Matikan relay yang terdaftar di ComboBox
        for key in comboBoxRelays:
            if key != relayKey and len(comboBoxRelays) > 0 :
                relay = self.relays[key]
                relay['state'] = 0
                self.d.setDOState(relay['pin'], relay['state'])

        # Hidupkan relay yang dipilih
        if relayKey != "nothing":
            relay = self.relays[relayKey]
            relay['state'] = state
            self.d.setDOState(relay['pin'], relay['state'])
            self.relaychanged.emit()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    mainApp = MainApp()
    # Mengikat sinyal dan slot antara Python dan QML
    engine.rootContext().setContextProperty("mainApp", mainApp)
    engine.load("qml/main0.qml")
    
    splash = QQmlComponent(engine, QUrl('qml/main0.qml'))
    splash.create()

    screenTimer = QTimer()
    screenTimer.timeout.connect(lambda: engine.load("qml/main.qml"))
    screenTimer.start(5000)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
