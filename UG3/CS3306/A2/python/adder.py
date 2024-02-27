class Adder:
    __result: float = None

    def add(self, val1: float | int, val2: float | int):
        self.__result = val1 + val2

    def display(self):
        if self.__result:
            print(f"Adder output: {self.__result}")
        else:
            print(f"No current adder output")
