import u6
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot

class LabJackReader(QObject):
    dataReady = pyqtSignal(float)

    def __init__(self):
        super().__init__()
        self.device = u6.U6()

    @pyqtSlot()
    def readData(self):
        temperature = self.device.getTemperature()
        self.dataReady.emit(temperature)
