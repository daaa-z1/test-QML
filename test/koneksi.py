import sqlite3

class Database:
    def __init__(self, db_name):
        self.conn = sqlite3.connect(db_name)
        self.cursor = self.conn.cursor()
        self.create_tables()

    def create_tables(self):
        # Membuat tabel Configurations
        self.cursor.execute('''
            CREATE TABLE IF NOT EXISTS Configurations (
                ID INTEGER PRIMARY KEY AUTOINCREMENT,
                Name TEXT
            )
        ''')

        # Membuat tabel Born
        self.cursor.execute('''
            CREATE TABLE IF NOT EXISTS Born (
                ID INTEGER PRIMARY KEY AUTOINCREMENT,
                Config_ID INTEGER,
                Day INTEGER,
                Month INTEGER,
                Years INTEGER,
                FOREIGN KEY(Config_ID) REFERENCES Configurations(ID)
            )
        ''')

        # Membuat tabel JoinTable
        self.cursor.execute('''
            CREATE TABLE IF NOT EXISTS JoinTable (
                ID INTEGER PRIMARY KEY AUTOINCREMENT,
                Config_ID INTEGER,
                Day INTEGER,
                Month INTEGER,
                Years INTEGER,
                FOREIGN KEY(Config_ID) REFERENCES Configurations(ID)
            )
        ''')

        self.conn.commit()

    def insert(self, table_name, data):
        columns = ', '.join(data.keys())
        placeholders = ', '.join(['?' for _ in data])
        self.cursor.execute(f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})", tuple(data.values()))
        self.conn.commit()
    
    def select_with_id(self, table_name, id):
        self.cursor.execute(f"SELECT * FROM {table_name} WHERE Config_ID = ?", (id,))
        return self.cursor.fetchall()

    def select_one(self, table_name, name):
        self.cursor.execute(f"SELECT * FROM {table_name} WHERE Name = ?", (name,))
        return self.cursor.fetchone()

    def select_all(self, table_name):
        self.cursor.execute(f"SELECT * FROM {table_name}")
        return self.cursor.fetchall()

    def update(self, table_name, id, new_data):
        set_str = ', '.join([f'{column} = ?' for column in new_data.keys()])
        self.cursor.execute(f"UPDATE {table_name} SET {set_str} WHERE ID = ?", (*new_data.values(), id))
        self.conn.commit()

    def delete(self, table_name, id):
        # Menghapus data dari tabel Born dan JoinTable
        self.cursor.execute(f"DELETE FROM Born WHERE Config_ID = ?", (id,))
        self.cursor.execute(f"DELETE FROM JoinTable WHERE Config_ID = ?", (id,))

        # Menghapus data dari tabel Configurations
        self.cursor.execute(f"DELETE FROM {table_name} WHERE ID = ?", (id,))

        self.conn.commit()

    def close(self):
        self.conn.close()
