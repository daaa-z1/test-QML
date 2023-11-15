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
                               Press_Com_Min INTEGER,
                               Press_Com_Max INTEGER,
                               Press_Aktual_Min INTEGER,
                               Press_Aktual_Max INTEGER,
                               FOREIGN KEY (Config_ID) REFERENCES Configurations (ID))''')
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam membuat tabel Limits: {e}")

# Fungsi untuk membuat tabel batasan scaling jika belum ada
def buat_tabel_scaling(koneksi):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute('''CREATE TABLE IF NOT EXISTS Scaling
                              (ID INTEGER PRIMARY KEY AUTOINCREMENT,
                               Config_ID INTEGER NOT NULL,
                               Pressure_In_Scale_Min INTEGER,
                               Pressure_In_Scale_Max INTEGER,
                               Pressure_A_Scale_Min INTEGER,
                               Pressure_A_Scale_Max INTEGER,
                               Pressure_B_Scale_Min INTEGER,
                               Pressure_B_Scale_Max INTEGER,
                               Flow_Scale_Min INTEGER,
                               Flow_Scale_Max INTEGER,
                               Temp_Scale_Min INTEGER,
                               Temp_Scale_Max INTEGER,
                               Curr_V_Scale_Min INTEGER,
                               Curr_V_Scale_Max INTEGER,
                               Aktual_Scale_Min INTEGER,
                               Aktual_Scale_Max INTEGER,
                               Curr_MA_Scale_Min INTEGER,
                               Curr_MA_Scale_Max INTEGER,
                               Press_Com_Scale_Min INTEGER,
                               Press_Com_Scale_Max INTEGER,
                               Press_Aktual_Scale_Min INTEGER,
                               Press_Aktual_Scale_Max INTEGER,
                               FOREIGN KEY (Config_ID) REFERENCES Configurations (ID))''')
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam membuat tabel Scaling: {e}")
            
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
                              Btn7 INTEGER,
                              Btn8 INTEGER,
                              Btn9 INTEGER,
                              Btn10 INTEGER,
                              Btn11 INTEGER,
                              Btn12 INTEGER,
                              Btn13 INTEGER,
                              Btn14 INTEGER,
                              Btn15 INTEGER,
                              Btn16 INTEGER,
                              Btn17 INTEGER,
                              Btn18 INTEGER,
                              Btn19 INTEGER,
                              Btn20 INTEGER,
                              Btn21 INTEGER,
                              Btn22 INTEGER,
                              Btn23 INTEGER,
                              FOREIGN KEY (Config_ID) REFERENCES Configurations (ID))''')
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam membuat tabel Switch: {e}")

# Fungsi untuk membuat tabel fungsi tombol
def buat_tabel_state(koneksi):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute('''CREATE TABLE IF NOT EXISTS State
                              (ID INTEGER PRIMARY KEY AUTOINCREMENT,
                              Config_ID INTEGER NOT NULL,
                              Btn1_State INTEGER,
                              Btn2_State INTEGER,
                              Btn3_State INTEGER,
                              Btn4_State INTEGER,
                              Btn5_State INTEGER,
                              Btn6_State INTEGER,
                              Btn7_State INTEGER,
                              Btn8_State INTEGER,
                              Btn9_State INTEGER,
                              Btn10_State INTEGER,
                              Btn11_State INTEGER,
                              Btn12_State INTEGER,
                              Btn13_State INTEGER,
                              Btn14_State INTEGER,
                              Btn15_State INTEGER,
                              Btn16_State INTEGER,
                              Btn17_State INTEGER,
                              Btn18_State INTEGER,
                              Btn19_State INTEGER,
                              Btn20_State INTEGER,
                              Btn21_State INTEGER,
                              Btn22_State INTEGER,
                              Btn23_State INTEGER,
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

# Fungsi untuk menambahkan data switch
def tambah_switch(koneksi, config_id, btn):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute("INSERT INTO Switch (Config_ID, Btn1, Btn2, Btn3, Btn4, Btn5, Btn6, Btn7, Btn8, Btn9, Btn10, Btn11, Btn12, Btn13, Btn14, Btn15, Btn16, Btn17, Btn18, Btn19, Btn20, Btn21, Btn22, Btn23) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                           (config_id, btn["Btn1"], btn["Btn2"], btn["Btn3"], btn["Btn4"], btn["Btn5"], btn["Btn6"], btn["Btn7"], btn["Btn8"], btn["Btn9"], btn["Btn10"], btn["Btn11"], btn["Btn12"], btn["Btn13"], btn["Btn14"], btn["Btn15"], btn["Btn16"], btn["Btn17"], btn["Btn18"], btn["Btn19"], btn["Btn20"], btn["Btn21"], btn["Btn22"], btn["Btn23"]))
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam menambahkan switch: {e}")

# Fungsi untuk menambahkan data state
def tambah_state(koneksi, config_id, state):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute("INSERT INTO Switch (Config_ID, Btn1_state, Btn2_state, Btn3_state, Btn4_state, Btn5_state, Btn6_state, Btn7_state, Btn8_state, Btn9_state, Btn10_state, Btn11_state, Btn12_state, Btn13_state, Btn14_state, Btn15_state, Btn16_state, Btn17_state, Btn18_state, Btn19_state, Btn20_state, Btn21_state, Btn22_state, Btn23_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                           (config_id, state["Btn1_State"], state["Btn2_State"], state["Btn3_State"], state["Btn4_State"], state["Btn5_State"], state["Btn6_State"], state["Btn7_State"], state["Btn8_State"], state["Btn9_State"], state["Btn10_State"], state["Btn11_State"], state["Btn12_State"], state["Btn13_State"], state["Btn14_State"], state["Btn15_State"], state["Btn16_State"], state["Btn17_State"], state["Btn18_State"], state["Btn19_State"], state["Btn20_State"], state["Btn21_State"], state["Btn22_State"], state["Btn23_State"]))
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam menambahkan switch: {e}")

# Fungsi untuk menambahkan data batasan
def tambah_batasan(koneksi, config_id, batasan):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute("INSERT INTO Limits (Config_ID, Pressure_In_Min, Pressure_In_Max, Pressure_A_Min, Pressure_A_Max, Pressure_B_Min, Pressure_B_Max, Flow_Min, Flow_Max, Temp_Min, Temp_Max, Curr_V_Min, Curr_V_Max, Aktual_Min, Aktual_Max, Curr_MA_Min, Curr_MA_Max, Press_Com_Min, Press_Com_Max, Press_Aktual_min, Press_Aktual_max) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                           (config_id, batasan["Pressure_In_Min"], batasan["Pressure_In_Max"], batasan["Pressure_A_Min"], batasan["Pressure_A_Max"], batasan["Pressure_B_Min"], batasan["Pressure_B_Max"], batasan["Flow_Min"], batasan["Flow_Max"], batasan["Temp_Min"], batasan["Temp_Max"], batasan["Curr_V_Min"], batasan["Curr_V_Max"], batasan["Aktual_Min"], batasan["Aktual_Max"], batasan["Curr_MA_Min"], batasan["Curr_MA_Max"], batasan["Press_Com_Min"], batasan["Press_Com_Max"], batasan["Press_Aktual_Min"], batasan["Press_Aktual_Max"]))
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam menambahkan batasan: {e}")

# Fungsi untuk menambahkan data batasan
def tambah_scaling(koneksi, config_id, scale):
    if koneksi:
        try:
            cursor = koneksi.cursor()
            cursor.execute("INSERT INTO Scaling (Config_ID, Pressure_In_Scale_Min, Pressure_In_Scale_Max, Pressure_A_Scale_Min, Pressure_A_Scale_Max, Pressure_B_Scale_Min, Pressure_B_Scale_Max, Flow_Scale_Min, Flow_Scale_Max, Temp_Scale_Min, Temp_Scale_Max, Curr_V_Scale_Min, Curr_V_Scale_Max, Aktual_Scale_Min, Aktual_Scale_Max, Curr_MA_Scale_Min, Curr_MA_Scale_Max, Press_Com_Scale_Min, Press_Com_Scale_Max, Press_Aktual_Scale_Min, Press_Aktual_Scale_Max) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                           (config_id, scale["Pressure_In_Scale_Min"], scale["Pressure_In_Scale_Max"], scale["Pressure_A_Scale_Min"], scale["Pressure_A_Scale_Max"], scale["Pressure_B_Scale_Min"], scale["Pressure_B_Scale_Max"], scale["Flow_Scale_Min"], scale["Flow_Scale_Max"], scale["Temp_Scale_Min"], scale["Temp_Scale_Max"], scale["Curr_V_Scale_Min"], scale["Curr_V_Scale_Max"], scale["Aktual_Scale_Min"], scale["Aktual_Scale_Max"], scale["Curr_MA_Scale_Min"], scale["Curr_MA_Scale_Max"], scale["Press_Com_Scale_Min"], scale["Press_Com_Scale_Max"], scale["Press_Aktual_Scale_Min"], scale["Press_Aktual_Scale_Max"]))
            koneksi.commit()
        except sqlite3.Error as e:
            print(f"Kesalahan dalam menambahkan scaling: {e}")
