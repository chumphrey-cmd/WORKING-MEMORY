# Strategy, Observer, Factory, Decorator

> [!NOTE]
> I grouped these specific design patterns together because I read that they capture a majority (~60%) of the patterns that I might encountering in software. Obviously, there are much more, but I figured this would be a decent place to start. I've heavily sourced from [refactoring.guru](https://refactoring.guru/design-patterns/catalog) and adapted the information for my own understanding.

## 1. Strategy (Behavioral)

> [!NOTE]
> Strategy changes the **`HOW`** (behavior: add vs multiply).
>
> Allows you to swap different **behaviors/algorithms** at runtime without changing the core class. Lets you define a family of algorithms, put each of them into a separate class, and make their objects interchangeable.
> 
> The main class (Context) holds a reference to a Strategy interface. It delegates the work to whatever concrete strategy is plugged in.

### When to Use
* You have multiple ways to do the same thing (sorting, payment, display modes, menu selection). 
* You want to avoid big `if/else` or `switch` block. Basically, you can use the pattern when your class has a massive conditional statements that switch between different variants of the same algorithm.
* When you want the behavior to be chosen at runtime (user choice, config, level, etc.).

### How to Use It
* Identify an algorithm that’s prone to frequent changes (e.g., a massive conditional that selects and executes a variant of the same algorithm at runtime). 

* Declare the strategy interface common to all variants of the algorithm (e.g., a specific calculation or transformation of data)

* Extract all algorithms into their own classes. They should all implement the strategy interface.

* In the context class, add a field for storing a reference to a strategy object. Provide a **`setter`** for replacing values of that field. The context should work with the strategy object only via the strategy interface. The context may define an interface which lets the strategy access its data.

* Clients of the context must associate it with a suitable strategy that matches the way they expect the context to perform its primary job.

### Example

* The easiest way for me to understand this is through the use of a simple calculator example: 

```java
// ======================
// STRATEGY PATTERN: Calculator Example
// ======================

// 1. Strategy Interface (the contract)
interface MathOperation {
    int execute(int a, int b);   // takes A and B, returns result
}

// 2. Concrete Strategies
class Add implements MathOperation {
    public int execute(int a, int b) {
        return a + b;
    }
}

class Subtract implements MathOperation {
    public int execute(int a, int b) {
        return a - b;
    }
}

class Multiply implements MathOperation {
    public int execute(int a, int b) {
        return a * b;
    }
}

// 3. Context (the Calculator)
class Calculator {
    private MathOperation operation;   // "plug-in" slot for the strategy

    public void setOperation(MathOperation operation) {
        this.operation = operation;    // swap behavior at runtime
    }

    public int calculate(int a, int b) {
        if (operation == null) {
            throw new IllegalStateException("No operation set!");
        }
        return operation.execute(a, b); // delegate to current strategy
    }
}

// 4. Usage Example
public class Main {
    public static void main(String[] args) {
        Calculator calc = new Calculator();

        calc.setOperation(new Add());
        System.out.println(calc.calculate(10, 5));   // 15

        calc.setOperation(new Subtract());
        System.out.println(calc.calculate(10, 5));   // 5

        calc.setOperation(new Multiply());
        System.out.println(calc.calculate(10, 5));   // 50
    }
}
```

## 2. Observer (Behavioral)

> [!NOTE]
> Observer handles **`WHO`** (who gets notified: alert, graph, thermostat).
> One object (Subject) notifies many others (Observers) automatically when its state changes (e.g., one-to-many dependency or pub-sub).

### When to Use
* You need automatic updates (UI, alerts, logs, dashboards). 
* Multiple parts of the program care about the same event
  * If you're setting up a stock-tracking application, and you want those subscribed to be notified when a trade is initiated (e.g., r/wallstreebets) 
* You want loose coupling (e.g., the Subject doesn’t know who’s listening and just wants to broadcast its status)

### Example

```java
// ======================
// OBSERVER PATTERN - Simple Java Example
// ======================

// 1. Observer Interface (the contract)
interface Observer {
    void update(String message);   // every observer must implement the "update" utility which accepts a String message parameter
}

// 2. Subject (the thing being watched)
class WeatherStation {
    private java.util.List<Observer> observers = new java.util.ArrayList<>();
    private String weather;

    // private helper method to simply add an observer (subscriber) to the Array List 
    public void addObserver(Observer obs) {
        observers.add(obs);        // subscribe
    }
    
    // Using a setter here to update new weather and then notify all of the observers. 
    public void setWeather(String newWeather) {
        this.weather = newWeather;
        notifyObservers();         // automatic broadcast
    }

    // Private method to inform everyone in the observers Array List via a String message specified inside of the Observer interface.
    private void notifyObservers() {
        for (Observer obs : observers) {
            obs.update(weather);   // tell everyone
        }
    }
}

// 3. Concrete Observers
class PhoneDisplay implements Observer {
    public void update(String message) {
        System.out.println("Phone Display: Weather is " + message);
    }
}

class TVDisplay implements Observer {
    public void update(String message) {
        System.out.println("TV Display: Current weather - " + message);
    }
}

// 4. Main driver and usage of observer pattern
public class Main {
    public static void main(String[] args) {
        WeatherStation station = new WeatherStation();

        station.addObserver(new PhoneDisplay());
        station.addObserver(new TVDisplay());

        station.setWeather("Sunny and 75°F");
        // Output:
        // Phone Display: Weather is Sunny and 75°F
        // TV Display: Current weather - Sunny and 75°F
    }
}
```

## 3. Factory (Creational)

> [!NOTE] 
> Factory picks **`WHAT`** (what gets made: zombie vs dragon). 
> Lets subclasses decide which class to instantiate, so the client doesn’t have to know the exact concrete type.
> Basically a `Creator` class declares a factory method (via the `superclass`). It allows `subclasses` override it to return different products. Client only calls the factory method.

### When to use
* Object creation is complex or varies by condition (game level, OS, user type, time of year). 
* You want to avoid hard-coded `new className()` nested inside other classes, which makes architecture cluttered and un-maintainable. 
* You need to add new types later without breaking existing code (e.g., helps with maintainability over the long term)

### Example

* Here's another simple example of implementing the Factory creation pattern using the scenario of a video game. 
* The goal here is to generate a set of different classes of enemies that can be called and customized based on the "Levels" or concrete factories that reside within my "game". 

```java
// ======================
// FACTORY METHOD PATTERN - Enemies based off game level
// ======================

// 1. Product Interface

// Here we can introduce other actions or components that characterize the Enemy interface (e.g., runs away, hides, defends, etc.)
interface Enemy {
    void attack();
}

// 2. Concrete Products

// Here each enemy is implementing the methods declared within the Enemy interface (e.g., attack(), defend(), etc.) and customizing the output unique to the class itself.
class Zombie implements Enemy {
    public void attack() {
        System.out.println("Easy Level: Zombie bites!");
    }
}

class Dragon implements Enemy {
    public void attack() {
        System.out.println("Hard Level: Dragon breathes fire!");
    }
}

// 3. Creator (Factory)
// Helper method that will be used by the subclasses to generate new Enemy objects each with their own unique features.
abstract class EnemyFactory {
    public abstract Enemy createEnemy();   // factory method
}

// 4. Concrete Factories
// Here we are overriding the factory method in a subclass and deciding which concrete product will be created by the method (e.g., Zombie() or Dragon()).
class EasyLevelFactory extends EnemyFactory {
    public Enemy createEnemy() {
        return new Zombie();               // easy enemy
    }
}

class HardLevelFactory extends EnemyFactory {
    public Enemy createEnemy() {
        return new Dragon();               // hard enemy
    }
}

// 5. Usage Example
public class Main {
    public static void main(String[] args) {
        EnemyFactory factory;

        factory = new EasyLevelFactory();
        Enemy e1 = factory.createEnemy();
        e1.attack();   // Easy Level: Zombie bites!

        factory = new HardLevelFactory();
        Enemy e2 = factory.createEnemy();
        e2.attack();   // Hard Level: Dragon breathes fire!
    }
}
```

## 4. Decorator (Structural)