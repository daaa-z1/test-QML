import sqlite3

# Fungsi untuk membuat koneksi ke database atau membuat database jika belum ada
def buat_koneksi(nama_database="data.db"):
    try:
        koneksi = sqlite3.connect(nama_database)
        return koneksi
    except sqlite3.Error as e:
        print(f"Kesalahan dalam membuat koneksi: {e}")
    return None

# Fungsi untuk membuat tabel konfigurasi jika belum ada
def buat_tabel_konfigurasi(koneksi):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute('''CREATE TABLE IF NOT EXISTS Configurations
                              (ID INTEGER PRIMARY KEY AUTOINCREMENT,
                               Name TEXT NOT NULL)''')
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam membuat tabel Configurations: {e}")

# Fungsi untuk membuat tabel pengukuran jika belum ada
def buat_tabel_pengukuran(koneksi):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute('''CREATE TABLE IF NOT EXISTS Measurements
                              (ID INTEGER PRIMARY KEY AUTOINCREMENT,
                               Config_ID INTEGER NOT NULL,
                               Pressure_In REAL,
                               Pressure_A REAL,
                               Pressure_B REAL,
                               Flow REAL,
                               Temp REAL,
                               Curr_V REAL,
                               Aktual REAL,
                               Curr_MA REAL,
                               FOREIGN KEY (Config_ID) REFERENCES Configurations (ID))''')
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam membuat tabel Measurements: {e}")

# Fungsi untuk membuat tabel batasan jika belum ada
def buat_tabel_batasan(koneksi):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute('''CREATE TABLE IF NOT EXISTS Limits
                              (ID INTEGER PRIMARY KEY AUTOINCREMENT,
                               Config_ID INTEGER NOT NULL,
                               Pressure_In_Min INTEGER,
                               Pressure_In_Max INTEGER,
                               Pressure_A_Min INTEGER,
                               Pressure_A_Max INTEGER,
                               Pressure_B_Min INTEGER,
                               Pressure_B_Max INTEGER,
                               Flow_Min INTEGER,
                               Flow_Max INTEGER,
                               Temp_Min INTEGER,
                               Temp_Max INTEGER,
                               Curr_V_Min INTEGER,
                               Curr_V_Max INTEGER,
                               Aktual_Min INTEGER,
                               Aktual_Max INTEGER,
                               Curr_MA_Min INTEGER,
                               Curr_MA_Max INTEGER,
                               FOREIGN KEY (Config_ID) REFERENCES Configurations (ID))''')
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam membuat tabel Limits: {e}")
            
# Fungsi untuk membuat tabel fungsi tombol
def buat_tabel_switch(koneksi):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute('''CREATE TABLE IF NOT EXISTS Switch
                              (ID INTEGER PRIMARY KEY AUTOINCREMENT,
                              Config_ID INTEGER NOT NULL,
                              Btn1 INTEGER,
                              Btn2 INTEGER,
                              Btn3 INTEGER,
                              Btn4 INTEGER,
                              Btn5 INTEGER,
                              Btn6 INTEGER,
                              FOREIGN KEY (Config_ID) REFERENCES Configurations (ID))''')
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam membuat tabel Switch: {e}")

# Fungsi untuk menambahkan data konfigurasi
def tambah_konfigurasi(koneksi, nama):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute("INSERT INTO Configurations (Name) VALUES (?)", (nama,))
            koneksi.commit()
            return cursor.lastrowid  # Mengembalikan ID konfigurasi yang baru saja ditambahkan
        except sqlite3.Error as e:
            print(f"Kesalahan dalam menambahkan konfigurasi: {e}")
    return None

# Fungsi untuk menambahkan data pengukuran
def tambah_pengukuran(koneksi, config_id, data):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute("INSERT INTO Measurements (Config_ID, Pressure_In, Pressure_A, Pressure_B, Flow, Temp, Curr_V, Aktual, Curr_MA) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                           (config_id, data["Pressure_In"], data["Pressure_A"], data["Pressure_B"], data["Flow"], data["Temp"], data["Curr_V"], data["Aktual"], data["Curr_MA"]))
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam menambahkan pengukuran: {e}")

# Fungsi untuk menambahkan data switch
def tambah_switch(koneksi, config_id, btn):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute("INSERT INTO Switch (Config_ID, Btn1, Btn2, Btn3, Btn4, Btn5, Btn6) VALUES (?, ?, ?, ?, ?, ?, ?)",
                           (config_id, btn["Btn1"], btn["Btn2"], btn["Btn3"], btn["Btn4"], btn["Btn5"], btn["Btn6"]))
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam menambahkan switch: {e}")

# Fungsi untuk menambahkan data batasan
def tambah_batasan(koneksi, config_id, batasan):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute("INSERT INTO Limits (Config_ID, Pressure_In_Min, Pressure_In_Max, Pressure_A_Min, Pressure_A_Max, Pressure_B_Min, Pressure_B_Max, Flow_Min, Flow_Max, Temp_Min, Temp_Max, Curr_V_Min, Curr_V_Max, Aktual_Min, Aktual_Max, Curr_MA_Min, Curr_MA_Max) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                           (config_id, batasan["Pressure_In_Min"], batasan["Pressure_In_Max"], batasan["Pressure_A_Min"], batasan["Pressure_A_Max"], batasan["Pressure_B_Min"], batasan["Pressure_B_Max"], batasan["Flow_Min"], batasan["Flow_Max"], batasan["Temp_Min"], batasan["Temp_Max"], batasan["Curr_V_Min"], batasan["Curr_V_Max"], batasan["Aktual_Min"], batasan["Aktual_Max"], batasan["Curr_MA_Min"], batasan["Curr_MA_Max"]))
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam menambahkan batasan: {e}")


if __name__ == "__main__":
    koneksi = buat_koneksi()
    if koneksi:
        buat_tabel_konfigurasi(koneksi)
        buat_tabel_pengukuran(koneksi)
        buat_tabel_batasan(koneksi)
        buat_tabel_switch(koneksi)

        # Menambahkan konfigurasi "Default" dan mendapatkan ID-nya
        config_id = tambah_konfigurasi(koneksi, "Default")

        # Menambahkan data pengukuran dan data batasan sesuai dengan ID konfigurasi
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

        tambah_pengukuran(koneksi, config_id, data_pengukuran)
        tambah_batasan(koneksi, config_id, data_batasan)
        tambah_switch(koneksi, config_id, data_switch)

        koneksi.close()
