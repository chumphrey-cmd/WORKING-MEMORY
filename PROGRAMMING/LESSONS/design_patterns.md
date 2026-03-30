# 1. Strategy Pattern

> Allows you to swap different **behaviors/algorithms** at runtime without changing the core class. **BEHAVIOR BASED**
> Behavioral design pattern that lets you define a family of algorithms, put each of them into a separate class, and make their objects interchangeable.

## When to Use
* You have multiple ways to do the same thing (sorting, payment, display modes, menu selection). 
* You want to avoid big `if/else` or `switch` block. Basically, you can use the pattern when your class has a massive conditional statement that switches between different variants of the same algorithm.
* When you want the behavior to be chosen at runtime (user choice, config, level, etc.).


## Example 

> [!NOTE]
> The main class (Context) holds a reference to a Strategy interface. It delegates the work to whatever concrete strategy is plugged in.

```python
# Strategy interface
class DriveStrategy:
    def drive(self):
        pass

# Concrete strategies
class EcoDrive(DriveStrategy):
    def drive(self):
        print("Driving in fuel-saving mode")

class SportDrive(DriveStrategy):
    def drive(self):
        print("Driving in sport mode")

# Context (the car)
class Car:
    def __init__(self, strategy: DriveStrategy):
        self.strategy = strategy          # plugin slot

    def set_strategy(self, strategy: DriveStrategy):
        self.strategy = strategy          # swap at runtime

    def go(self):
        print("Car is moving...")
        self.strategy.drive()             # delegate

# Usage
car = Car(EcoDrive())
car.go()          # → eco mode
car.set_strategy(SportDrive())
car.go()          # → sport mode
```