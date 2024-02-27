class Subtractor:
    __result: float = None

    def subtract(self, val1: float | int, val2: float | int):
        self.__result = val1 - val2

    def display(self):
        if self.__result:
            print(f"Subtractor output: {self.__result}")
        else:
            print(f"No current subtractor output")
