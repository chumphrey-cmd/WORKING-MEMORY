# Essential Concepts

## OOP vs Functional Programming

* **[OOP](https://www.geeksforgeeks.org/dsa/introduction-of-object-oriented-programming/):** Is about grouping data and behavior together in one place: an `object`.
* They tend to think about programming as a modeling problem...
    * E.g. "How can I write a Human class that holds the data and simulates the behavior of a real human?"

> [!Tip]
>
> The meta way to think about this is "objects all the way down".
> Each new ***instance*** of a `class` is an `object`!

* **[Functional Programming](https://www.geeksforgeeks.org/blogs/functional-programming-paradigm/):** view code as inputs and outputs, and how those inputs and outputs transition the world from one state to the next.
    * "My game has 7 humans in it. When one takes a step, what's the next state of the game?"

## Object-Oriented Programming (OOP)

* **[Object-Oriented Programming](https://en.wikipedia.org/wiki/Object-oriented_programming)**: Programming paradigm based on objects  (software entities that encapsulate data and function(s)). An OOP computer program consists of objects that interact with objects.

```python
# Basics Explained:

# 1. CLASS (The Top Level Container)
class Car:

    # 2. METHODS (The functions inside the Class)
    
    #   2a. The Constructor
    def __init__(self, color):
        # 3. ATTRIBUTES (Data attached to the object using 'self')
        self.color = color 
        self.is_running = False

    #   2b. Regular Method
    def start_engine(self):
        # Accessing an attribute inside a method
        self.is_running = True
        print(f"The {self.color} car is starting...")

# --- OUTSIDE THE HIERARCHY ---

# 4. OBJECT (The Result)
# We use the Class to build this Object
my_chevy = Car("Red")
```

### Class (Blueprint/Template)

> Defines the structure of the home and give the features that all houses built from this plan will have a door color, a number of windows, and a garage.

A `class` defines the **structure** and **capabilities** for what we are building. It guarantees what attributes every version will have, but doesn't store specific data yet.

* **THINK** architectural blueprints for a home. It states that *every* home built from this plan must have a door, wood panels, a roof, and a garage. 
* `class` = like a blueprint or a template, describes objects with common properties, definition or rules.


#### Classes vs. Dictionaries

> An light-weight heuristic is to think of `classes` like dictionaries (e.g., key-value pairs), but different and more flexibile as addition behavior can be assigned to it (by other `objects`)

```python
# Defines a new class called "Soldier"
# with three properties: health, armor, damage
class Soldier:
    health = 5
    armor = 3
    damage = 2
```

### Objects

`object` = the actual house built from that blueprint, the result created from the rules. Typically called outside of the `class`

An `Object` is the concrete "home" created from the `Class`. While they share the same structure, they hold their own specific **State** (unique data).

* **THINK:** The actual houses on the street. One house (Object A) has a *Red* door, while the neighbor (Object B) has a *Blue* door. They are infinitely customizable **without** affecting each other.

```python
health = 50
# health is an instance of an integer type
aragorn = Soldier()
# aragorn is an object instance of the Soldier class type
```

```python
class Archer:
    health = 40
    arrows = 10

# Create several object instances of the Archer class
legolas = Archer()
bard = Archer()

# Print class properties
print(legolas.health) # 40
print(bard.arrows) # 10
```



### Methods

* A `method` is just a function that's tied directly to a `class` and has access to its properties.
* `self` is a strong convention in Python—everyone expects to see it, and tools/docs assume it.

```python
class Soldier:
    health = 5

    # This is a method that reduces the health of the soldier
    def take_damage(self, damage):
        self.health -= damage

soldier_one = Soldier() # object instance created from Soldier()
soldier_one.take_damage(2) # object-method syntax for accessing the take_damage() method
print(soldier_one.health)
# prints "3"

soldier_two = Soldier()
soldier_two.take_damage(1)
print(soldier_two.health)
# prints "4"
```

#### Constructors 

* Are a specific method on a class called `__init__` that is called automatically when you create a new instance of a class. 
* `constructors` make the objects' state (their attributes) configurable and other methods then use that state. **ESSENTIALLY**: the set of local variables that other methods within the class-object access.

```python

'''
In OOP the "Pythonic way" to reference another class is to simply lower the class name (e.g., Soldier > soldier) when initialized inside of a method...

This allows you to manipulate the objects inside of the "Book" class using the "book" instance.
'''

class Soldier: # Class
    def __init__(self, name, armor, num_weapons): # Constructor
        self.name = name # instance variable (or properties)
        self.armor = armor
        self.num_weapons = num_weapons

soldier_one = Soldier("Legolas", 2, 10) # object-instance of the class Soldier
print(soldier_one.name)
# prints "Legolas"
print(soldier_one.armor)
# prints "2"
print(soldier_one.num_weapons)
# prints "10"
```

### Encapsulation and Abstraction

1. https://www.geeksforgeeks.org/java/difference-between-abstraction-and-encapsulation-in-java-with-examples/

#### Encapsulation

* **Binds data and methods together** to preventing it (other classes) from unauthorized access and wraps up data and functions under a single unit.
* Variables or data of that class can only be accessed and modified through other **methods** and **authorized users**, hence "hidden" or "encapsulated".
* **Basic Example - Bank:**
  * A bank can be thought of as a fully encapsulated class that provides access to the customers through various methods (getters and setters). 
  * The rest of the data inside bank is hidden to protect from outside world.

> [!NOTE]
> Encapsulation can be achieved by **declaring all the variables in the class as private and writing public methods** in the class to `set` and `get` the values of variables. 

```java
// Java program to demonstrate encapsulation [1]

class Encapsulate {

    // private variables declared which can only be accessed by public methods of class
    private int geekAge;
    private String geekName;
    private int geekRoll;

    // get method for age to access private variable geekAge
    public int getAge() { return geekAge; }

    // get method for name to access private variable geekName
    public String getName() { return geekName; }

    // get method for roll to access private variable geekRoll
    public int getRoll() { return geekRoll; }

    // set method for age to access private variable geekage
    public void setAge(int newAge) { geekAge = newAge; }

    // set method for name to access private variable geekName
    public void setName(String newName) { geekName = newName; }

    // set method for roll to access private variable geekRoll
    public void setRoll(int newRoll) { geekRoll = newRoll; }
}

// Class to access variables of the class Encapsulate
public class TestEncapsulation {
    public static void main(String[] args)
    {
        Encapsulate obj = new Encapsulate();

        // setting values of the variables
        obj.setName("Harsh");
        obj.setAge(19);
        obj.setRoll(51);

        // Displaying values of the variables
        System.out.println("Geek's name: " + obj.getName());
        System.out.println("Geek's age: " + obj.getAge());
        System.out.println("Geek's roll: " + obj.getRoll());
    }
}
```

**KEY IDEA**:     
* Direct access of `private int geekRoll()` is not possible due to encapsulation, for example:

    ```java
    // Unable to access the private object of geekRoll this way!
    System.out.println("Geek's roll: " + obj.geekRoll); 
    ```
* Here if `geekRoll` was declared public then it would have been displayed.
* Since it has been declared private it cannot be accessed without getter and setter methods.
* Instead, we set the public method with "getters" and "setters" to access it:

    ```java

    // 1. get method for roll to access private variable geekRoll
    public int getRoll() { return geekRoll; }

    // 2. set method for roll to access private variable geekRoll
    public void setRoll(int newRoll) { geekRoll = newRoll; }

    // 3. accessing set method from public class TestEncapsulation()
    obj.setRoll(51);

    // 4. Displaying values of the variables via "get"
    System.out.println("Geek's roll: " + obj.getRoll());
    ```

#### Abstraction

* Abstraction focuses on exposing **essential features while hiding complexity** (e.g., importing libraries, a car, a PC, etc.) 
* Only the essential details are displayed to the user. The trivial or the non-essential units are not displayed to the user.
* **Basic Example - Car:**
  * The driver of the car only needs to know how to drive it. Not how its engine and the gear box and other internal components work.

> [!NOTE]
> We can implement abstraction using the **`abstract class`** and **interfaces**.

```java
// Java program to illustrate the concept of Abstraction [1]

abstract class Shape {
    String color;

    // these are abstract methods
    abstract double area();
    public abstract String toString();

    // abstract class can have a constructor
    public Shape(String color)
    {
        System.out.println("Shape constructor called");
        this.color = color;
    }

    // this is a concrete method
    public String getColor() { return color; }
}
class Circle extends Shape {
    double radius;

    public Circle(String color, double radius)
    {

        // calling Shape constructor
        super(color);
        System.out.println("Circle constructor called");
        this.radius = radius;
    }

    @Override double area()
    {
        return Math.PI * Math.pow(radius, 2);
    }

    @Override public String toString()
    {
        return "Circle color is " + super.color
            + " and area is : " + area();
    }
}

class Rectangle extends Shape {

    double length;
    double width;

    public Rectangle(String color, double length,
                     double width)
    {

        // calling Shape constructor
        super(color);
        System.out.println("Rectangle constructor called");
        this.length = length;
        this.width = width;
    }

    @Override double area() { return length * width; }

    @Override public String toString()
    {
        return "Rectangle color is " + super.color
            + " and area is : " + area();
    }
}

public class Test {
    public static void main(String[] args)
    {
        Shape s1 = new Circle("Red", 2.2);
        Shape s2 = new Rectangle("Yellow", 2, 4);

        System.out.println(s1.toString());
        System.out.println(s2.toString());
    }
}
```

### Inheritance
### Polymorphism

## Summary (26-30JAN)

