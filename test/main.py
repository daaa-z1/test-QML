import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
from koneksi import Database

class App:
    def __init__(self, root):
        self.root = root
        self.root.title('CRUD App')
        self.db = Database('data.db')

        # Membuat widget
        self.combobox = ttk.Combobox(root, state="readonly")
        self.add_button = tk.Button(root, text='Add', command=self.add)
        self.edit_button = tk.Button(root, text='Edit', command=self.edit)
        self.delete_button = tk.Button(root, text='Delete', command=self.delete)
        self.view_button = tk.Button(root, text='View', command=self.view)

        # Menempatkan widget
        self.combobox.grid(row=0, column=0, columnspan=2)
        self.add_button.grid(row=1, column=0)
        self.edit_button.grid(row=1, column=1)
        self.delete_button.grid(row=2, column=0, columnspan=2)
        self.view_button.grid(row=3, column=0, columnspan=2)

        # Memuat data
        self.load_data()

    def load_data(self):
        # Menghapus data lama
        self.combobox['values'] = []

        # Memuat data baru
        data = self.db.select_all('Configurations')
        self.combobox['values'] = [row[1] for row in data]

    def add(self):
        # Meminta data baru
        name = simpledialog.askstring('Add', 'Enter name')

        # Memasukkan data ke database
        self.db.insert('Configurations', {'Name': name})

        # Memuat ulang data
        self.load_data()

    def edit(self):
        # Mendapatkan data yang dipilih
        name = self.combobox.get()
        if not name:
            return
        id = self.db.select_one('Configurations', name)[0]

        # Meminta data baru
        day = simpledialog.askinteger('Edit', 'Enter day')
        month = simpledialog.askinteger('Edit', 'Enter month')
        year = simpledialog.askinteger('Edit', 'Enter year')

        # Memasukkan data ke tabel Born dan JoinTable
        self.db.insert('Born', {'Config_ID': id, 'Day': day, 'Month': month, 'Years': year})
        self.db.insert('JoinTable', {'Config_ID': id, 'Day': day, 'Month': month, 'Years': year})

        # Memuat ulang data
        self.load_data()

    def delete(self):
        # Mendapatkan data yang dipilih
        name = self.combobox.get()
        if not name:
            return
        id = self.db.select_one('Configurations', name)[0]

        # Menghapus data dari database
        self.db.delete('Configurations', id)

        # Memuat ulang data
        self.load_data()

    def view(self):
        # Mendapatkan data yang dipilih
        name = self.combobox.get()
        if not name:
            return
        id = self.db.select_one('Configurations', name)[0]

        # Membuat jendela baru
        window = tk.Toplevel(self.root)
        text = tk.Text(window)

        # Menampilkan data dari tabel Born dan JoinTable
        for table in ['Born', 'JoinTable']:
            data = self.db.select_with_id(table, id)
            text.insert(tk.END, f'{table}:\n')
            for row in data:
                text.insert(tk.END, f'{row}\n')
            text.insert(tk.END, '\n')

        text.pack()

root = tk.Tk()
app = App(root)
root.mainloop()
