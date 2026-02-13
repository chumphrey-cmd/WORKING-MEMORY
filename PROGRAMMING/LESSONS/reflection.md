# Essential Concepts

## OOP vs. Functional Programming

* **[OOP](https://www.geeksforgeeks.org/dsa/introduction-of-object-oriented-programming/):** Is about grouping data and behavior together in one place: an `object`.
* They tend to think about programming as a modeling problem...
    * E.g. "How can I write a Human class that holds the data and simulates the behavior of a real human?"

> [!Tip]
>
> The meta-way to think about this is "objects all the way down."
> Each new ***instance*** of a `class` is an `object`!

* **[Functional Programming](https://www.geeksforgeeks.org/blogs/functional-programming-paradigm/):** view code as inputs and outputs, and how those inputs and outputs transition the world from one state to the next.
    * "My game has 7 humans in it. When one takes a step, what's the next state of the game?"

## Object-Oriented Programming (OOP)

* **[Object-Oriented Programming](https://en.wikipedia.org/wiki/Object-oriented_programming)**: Programming paradigm based on objects (software entities that encapsulate data and function(s)). An OOP computer program consists of objects that interact with objects.

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

A `class` defines the **structure** and **capabilities** for what we are building. It guarantees what attributes every version will have but doesn't store specific data yet.

* **THINK** architectural blueprints for a home. It states that *every* home built from this plan must have a door, wood panels, a roof, and a garage. 
* `class` = like a blueprint or a template, describes objects with common properties, definition or rules.


#### Classes vs. Dictionaries

> A light-weight heuristic is to think of `classes` like dictionaries (e.g., key-value pairs), but different and more flexibile as addition behavior can be assigned to it (by other `objects`)

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
* `constructors` make the objects' state (their attributes) configurable and other methods then use that state. **ESSENTIALLY**: the set of local variables that other methods within the class can access.

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

* **Binds data and methods together** to prevent it (other classes) from unauthorized access and wraps up data and functions under a single unit.
* Variables or data of that class can only be accessed and modified through other **methods** and **authorized users**, hence "hidden" or "encapsulated".
* **Basic Example - Bank:**
  * A bank can be thought of as a fully encapsulated class that provides access to the customers through various methods (getters and setters). 
  * The rest of the data inside bank is hidden to protect from outside world.

> [!NOTE]
> Encapsulation can be achieved by **declaring all the variables in the class as private and writing public methods** in the class to `set` and `get` the values of variables. 

```java
// Java program to demonstrate encapsulation [1]

class Encapsulate {

    // private variables declared, which can only be accessed by public methods of class
    private int geekAge;
    private String geekName;
    private int geekRoll;

    // get method for age to access private variable geekAge
    public int getAge() { return geekAge; }

    // get method for name to access private variable geekName
    public String getName() { return geekName; }

    // get method for roll to access private variable geekRoll
    public int getRoll() { return geekRoll; }

    // set method for age to access private variable geekAge
    public void setAge(int newAge) { geekAge = newAge; }

    // set method for name to access private variable geekName
    public void setName(String newName) { geekName = newName; }

    // set method for roll to access private variable geekRoll
    public void setRoll(int newRoll) { geekRoll = newRoll; }
}

// Class to access variables of the class Encapsulate
public class TestEncapsulation {
    public static void main(String[] args){
        Encapsulate obj = new Encapsulate();

        // setting values of the variables
        obj.setAge(19);
        obj.setName("Harsh");
        obj.setRoll(51);

        // Displaying values of the variables
        System.out.println("Geek's name: " + obj.getName());
        System.out.println("Geek's age: " + obj.getAge());
        System.out.println("Geek's roll: " + obj.getRoll());
    }
}
```

##### Encapsulation Summarized

> [!NOTE] 
> Encapsulation is achieved by declaring variables as `private` and writing `public` methods to `set` and `get` the values.

**Private Variables**
```java
private int geekAge;
private String geekName;
private int geekRoll;
```

* They are only accessible **inside** the `Encapsulate()` other classes cannot see or touch them directly.

**Public Methods**

**Get Methods**

* Used to get a "read-only" window to view the data and return a copy of the value (e.g., `getAge()`, the class gives you the number "19")
  * `public [data_type] getXXX() { return private_variable; }`
  * `public int getAge() { return geekAge; }`

**Set Methods**

* Allow modification of the data, often with validation rules.
  * `public void setXXX([data_type] newName) { variable = newName; }`
  * `public void setAge(int newAge) { geekAge = newAge; }`
    * `void`: This is the **Return Type**. It tells Java: *"I am going to perform this action, but I will not return any data back to you when I'm done."*
    * CamelCase is standard naming convention (e.g., `geekAge` becomes `setAge`).

**`TestEncapsulation()`**

```java
public class TestEncapsulation {
    public static void main(String[] args) {
        Encapsulate obj = new Encapsulate();
        // ... usage
    }
}
```

* **`public static void main`:** entry point where the program starts execution.
* **`Encapsulate obj = new Encapsulate();`**: this creates an **Instance** (Object) of the class.
* `obj`: is now a specific object with its own state (name, age, roll).

**Direct Access vs. Encapsulation**

**Direct Access**

```java
// This will error because geekRoll is private!
System.out.println("Geek's roll: " + obj.geekRoll);
```

* This code will not compile. `geekRoll` is marked `private` and cannot be accessed directly.

**Public Accessors**

```java
// Correct usage via Public Method
System.out.println("Geek's roll: " + obj.getRoll());
```

* We use the **Public Interface** (`getRoll()`) to request the data from `public int getRoll() { return geekRoll; }` earlier on.

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
class Circle extends Shape { // `extends`: key word for inheritance
    double radius;

    public Circle(String color, double radius)
    {

        // calling Shape constructor
        super(color);
        System.out.println("Circle constructor called");
        this.radius = radius;
    }

    @Override double area() // Means the intentionally replacing the parent's version of this method to prevent typos
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
        Shape s1 = new Circle("Red", 2.2); // creating an instance of the Circle class that MUST have a color (string) and value (double); if not, thde code will not compile.
        Shape s2 = new Rectangle("Yellow", 2, 4);

        System.out.println(s1.toString());
        System.out.println(s2.toString());
    }
}
```

##### Abstraction Summarized

**The Abstract Class (`Shape`)**
```java
abstract class Shape {
    String color; 
    abstract double area(); 
    // ...
}
```

* Here is the `abstract class` defines a template but is incomplete.

> [!NOTE] 
> You **cannot** create an object directly from an abstract class (`new Shape()` is illegal).

* **Abstract Methods:** Methods with no code act as a **contract**. The parent tells the children: *"I don't know how to do this, so you MUST define it, later on via inheritance."*

**The Concrete Class (`Circle extends Shape`)**

```java
class Circle extends Shape {
    // ...
    @Override 
    double area() {
        return Math.PI * Math.pow(radius, 2);
    }
}
```

* **`extends`:** Here we are using **inheritance**. `Circle` inherits the `color` attribute from `Shape`.
* **Abstraction Being Used:** Since `Shape` left `area()` undefined, `Circle` **must** provide the actual math (logic) for it.
* **`@Override`:** tells the compiler: *"I am intentionally defining my own version of this method that I inherited from my parent."* It ensures we are correctly matching the parent's requirements.

**Execution using `Test` Class**

```java
Shape s1 = new Circle("Red", 2.2);
```

* Here we are defining the variable as the parent type (`Shape`), but we create the specific object (`Circle`) (this is also an example of **Polymorphism**, but I'll touch on this later on...)
* The user interacts with `s1` as just a "Shape," not needing to worry about the math happening inside the `Circle` class.
* We are declaring `s1` as a **Reference Type** `Shape`, but we are assigning it as an **Object Type** of Circle (which creates an instance of the abstract class `Shape`).

### Inheritance

* Inheritance allows a child class to inherit properties and methods from a "parent" class. It's a way to share similar functionality between related classes.
* It also prevents the duplication of the same code, and greater maintainability of large projects (e.g., updating one method in the parent class will be reflected in all child classes).

> [!NOTE]
> 
> **Rule of Thumb:** `A` should only inherit from `B` if `A` is *always* a `B`.
>
> When a child class inherits from a parent, it inherits *everything*. If you only want to share some functionality, inheritance should not be the tool you use.
> 
> Another mental model is that an inheritance tree should be **wide** rather than **deep**. 
> * Meaning that if there are properties found in the parent class that all the siblings (child classes) share with one another, inheritance should be used (e.g., the most common ancestry between species.)

<img src="./images/inheritance_example.png">

* Here's a neat example of the inheritance hierarchy that I thought was really informative.

<img src="./images/wide_inheritance_not_deep.png">

* Here's an example of the "wide, not deep" concept to drive home the point.

#### Inheritance Example in Python

> I'll update this to a Java example later on, but here's a quick example from a course that I'm currently taking outside ACC.

```python
class Human:
    def __init__(self, name): # Constructor
        # Double underscore = private attribute
        self.__name = name 

    def get_name(self):
        return self.__name 

class Archer(Human):
    def __init__(self, name, num_arrows):
        # Call the parent (Human) constructor
        super().__init__(name) # Superset of the parent class
        self.__num_arrows = num_arrows

    def get_num_arrows(self):
        return self.__num_arrows

    def use_arrows(self, num):
        if self.__num_arrows >= num:
            self.__num_arrows -= num 
        else:
            raise Exception("not enough arrows")

class Crossbowman(Archer):
    def __init__(self, name, num_arrows):
        # Pass the data up to the Archer constructor
        super().__init__(name, num_arrows) 

    def triple_shot(self, target):
        # Reuse logic from the parent class
        self.use_arrows(3) 
        return f"{target.get_name()} was shot by 3 crossbow bolts"

```

**1. The Parent Class (`Human`)**

* **`self.__name`:** The double underscore `__` indicates a **Private Attribute**. It cannot be accessed directly (e.g., `human.__name` will fail). You must use the getter method `get_name()`.

**2. Child Class (`Archer`)**

* **`class Archer(Human)`**: This syntax defines Inheritance. Archer **IS A** Human.
* **`super().__init__(name)`**: is "superset" in Python and allows the child to access methods from the parent. 
  * Here, it sends the `name` up to the `Human` class so the `Human` constructor can handle creating the name variable.

* **`use_arrows`**: A custom method specific to Archers. It includes logic to check if there is enough ammo before subtracting.

**3. Child Class (`Crossbowman`)**

* **`class Crossbowman(Archer)`**: Inheritance can go multiple levels deep. This class inherits everything from `Archer` (which inherited from `Human`).
* **`self.use_arrows(3)`**: Here we don't need to rewrite the math for subtracting arrows inside of `use_arrows`. It just reuses the method meant for Archers.
* **`target.get_name()`**: Since `target` is another object that is also a `Human`, the Crossbowman can use the public method `get_name()` to identify the victim.

### Polymorphism
