from abc import ABC, abstractmethod


class Callback(ABC):
    
    @abstractmethod
    def on_result(self, message, scripts):
        pass
