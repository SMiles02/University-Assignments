from adder import Adder
from subtractor import Subtractor
from multiplier import Multiplier

calculator_adder = Adder()
calculator_adder.add(15, 5)
calculator_adder.display()

calculator_subtractor = Subtractor()
calculator_subtractor.subtract(15, 5)
calculator_subtractor.display()

calculator_multiplier = Multiplier()
calculator_multiplier.multiply(4, 3)
calculator_multiplier.display()
