# Java Specific Fundamental Concepts

## Background About Java and IntelliJ Shortcuts

> A pure OOP language, EVERYTHING must live inside a class...
>
> Java data types: be sure to understand the data types that you are working with. Choosing the wrong data type can lead to large memory usage in large systems.
* `JVM` - Utilizes the JVM which is hardware-agnostic and uses the Java Virtual Machine (JVM) making it cross compatible.

## Java Programming Concepts and Terminology

### Terminology

* **Overloading**: The ability to have multiple functions with the same name but different parameters, not best practice!
* **Static Attributes (Variables)**: used to store data that is constant throughout the program. For example, the number of active connections to a database, the number of users logged in. Static variables are declared at the class level and are instantiated immediately upon class loading.

* **Lifetime**: How long a variable has a location in memory
* **Scope**: the visibility of a variable within a program.

* **Local Variable**: something defined within the scope of the code block and cannot be outside of it.
```java
if(x > 10) {
    String local = "Local value";
}
```
* **Instance Field or Field:** a variable that's bound to the object itself. I can use it in the object without the need to use accessors, and any method contained within the object may use it.
    * **Signature**: is the method's name and parameters that define how the method is called (e.g., `public countOfApples()` below)
    * **Header**: is the method's entire name, return type, method name, and parameters (e.g., `public void countOfApples(...)`)
```java
public class Point {
    private int numberOfApples;

    public void countOfApples() {
        System.out.println("Apples are: " + numberOfApples);
    }
}
```
* **Input Parameter, Parameter, Argument:** something that we pass into a method or constructor and is defined in the constructor.
```java
public class Point {
    private int numberOfApples;
    public countOfApples(int apples) {
        numberOfApples = apples; // Option 1
        this.numberOfApples = apples ; // Option 2
   }

    public void setApples(int apples) {
        numberOfApples = apples; // Option 1
        this.numberOfApples = apples; // Option 2
    }
}
```
* **Class (Static) Field**: similar to field, but the difference is that you don't need to have an instance of the containing object to use it.
```java
System.out.println(Integer.MAX_VALUE);
```

* **Non-Primitive / Reference Type**: A variable that holds a memory address (pointer) to an object on the heap, not the value itself. It allows for complex structures and can be `null`.
  * `String s = "hello";` — `s` is the variable that **points** to the string object ("hello") on the heap.

* **Primitive Type**: A built-in type that stores the actual value directly in the variable (no pointer or heap involved). The 8 primitives are `byte`, `short`, `int`, `long`, `float`, `double`, `char`, `boolean`. They can't be `null`.
  * `int age = 30;` — `age` contains value 30 directly.

* **Private Property**: A class field declared with the `private` keyword to hide it from direct access outside the class. It enforces encapsulation, allowing control via getters/setters.
  * `private String name;` — Only accessible within the class or through methods.

* **Constructor**: A method that is the **same name as the class**, that runs when creating an object with `new`. It initializes the object's state (fields) using passed parameters.
```java
// Constructor
public Person(String name) { this.name = name; } 

// Constructor is called with the String "Alice" as a parameter
Person p1 = new Person("Alice");
```

* **Setter**: A public method that updates a private field with **validation or checks**, controlling how values are set from outside the class.
  * `void` = #**SETTING**TheTable; any output is sent into the **`void`** never to be seen.
```java
// Validation of age before assignment
public void setAge(int age) { if (age > 0) this.age = age; } 
```

* **Getter**: A public method that returns the value of a private field, providing **read-only access** without exposing the field directly.
  * **Non-void** = "reporters' #**GETTING**TheMeal

```java
// Just retrieves the value
public String getName() { return name; }
```

* **Instance Object**: A specific, unique object created from a class using `new`. Each instance has its own state (field values), separate from others of the same class.

```java
// p1 and p2 are two "instances objects"
Person p1 = new Person("Alice"); 
Person p2 = new Person("Bob");
```

* **Composition Relationship**: A "has-a" relationship where one class owns an instance of another as a field.

### `static` vs. `void`

#### 1. `void` Answers: "What do you give back?"

Every method in Java must declare a **return type**. It has to tell the compiler what kind of data it will hand back when it finishes running.

* **Return Types (`int`, `String`, `boolean`, etc.):** The method does some work and gives you a specific piece of data back (a "receipt").
* **`void`:** The method performs an action (like printing to the console, changing a variable, or adding an item to a list) but returns **nothing**. It does its job and quietly finishes.

**Example:**

```java
// Returns an integer
public int calculateAge(int birthYear) {
    return 2024 - birthYear;
}

// Returns nothing, just performs an action
public void printWelcomeMessage() {
    System.out.println("Welcome to the company!");
}
```

#### 2. `static` Answers: "Who owns this?"

This keyword is all about Object-Oriented architecture: the difference between the **Blueprint** (the Class) and the **House** (the Object).

* **Non-Static (Instance Methods/Variables):** These belong to a specific *House*. You must build an object using the `new` keyword before you can use them. If you create three different `Company` objects, they each get their own separate `employees` list.
* **`static` (Class Methods/Variables):** These belong to the *Blueprint*. They exist independently of any objects, and there is only ever **one** copy of them shared across the entire program. You don't need to build an object to use them.

**The Golden Rule of Static:** A `static` method is "blind" to instance variables. The Blueprint doesn't know what color the walls are in a specific House. *Therefore, a static method cannot directly interact with a non-static variable.*

#### 3. The Combo: `static void`

When you put them together, you are simply stating two separate facts about the method:

1. **`static`:** This method belongs to the Class blueprint, not an instantiated object.
2. **`void`:** This method will not return any data when it finishes.

**Example:**

```java
// Belongs to the Main class itself, and returns nothing.
public static void main(String[] args) { ... }
```

### Java OOP Concepts

#### Access Modifiers (The Security Guards)
* **`public`**: **Everyone.** Any class, anywhere in the program, can access it. Normally used for methods that other classes need to use.
* **`private`**: **Only the class itself.** No one outside the class can see it. Used for sensitive data (attributes/properties). Outsiders must use a `public` Getter or Setter to interact with it.
* **`protected`**: **Children AND package neighbors.** Visible to subclasses (children) *and* any other classes sitting in the exact same folder (package). (Semi-Private).

#### Method Manipulation (Changing Behaviors)
* **Overload**: Same method name, **different signature** (parameters). Giving the exact same method multiple ways to behave depending on what data is passed in.
* **Override**: Same method name, **same signature**. The Child writes its own method to completely replace the parent's version of that method.

#### The `super` Keyword (Talking to the Parent)
* **`super()`**: Calls the **Parent's Constructor**. It must be the very first line inside the child's constructor.
* **`super.value` / `super.methodName()`**: Accesses a specific variable or method located in the parent.

#### The `final` Keyword (The Padlock)
* **`final` Class**: Used to prevent any other children from inheriting from a class. No one can ever 'extend' it.
* **`final` Method**: A child class can inherit this method, but they are **never allowed to Override it**.
* **`final` Variable**: The value is locked forever (a constant).

### Coupling and Cohesion

* **Nouns (Classes):**
  * These are the **Things** (e.g., `Car`, `School`, `SecurityLog`, `MenuOptions`).
  * They act as blueprints. They define properties (state) and can be instantiated into specific objects.

* **Verbs (Methods):**
  * These are the **Actions** (e.g., `calculateMileage`, `measureCourseProgress`).
  * They live inside the Nouns. They perform calculations, modify data, or handle Input/Output.

* **Coupling:**
  * This is the degree to which one class relies on another (we want coupling to be **LOW**).
  * Essentially the code the use should be "Plug and Play", if you change the code in `MenuOptions`, it should not break the code in `Main`. Low coupling allows for easier maintenance and reusability.

* **Cohesion**
  * This is the degree to which the elements inside a single class or method belong together (we want cohesion to be **HIGH**).
  * The thing that came to mind is a concept in Graph Theory and Network Architecture of "Eigenvector Centrality" (e.g., how reliant one node is to the entire network). Basically, lines of code within a method should be tightly dependent on one another. They should focus on solving one specific problem without "noise" or unrelated tasks.

**Method Naming**
* If you cannot describe what a function does using a **single verb**, it is likely doing too much. 
  * Break complex methods (e.g., `calculateAndPrint()`) into smaller, single-purpose methods (`calculate()`, then `print()`) for High Cohesion.

```java
// Person "has an" Address
class Person { private Address address; public Person(Address addr) { address = addr; } } 
```

> [!NOTE]
> 
> If "**X is-a Y**" sounds logical, use inheritance (e.g., a Dog is-an Animal) 
> 
> If "**X has-a** Y" sounds logical and multiple classes can use it (e.g., Person has-an Address), use composition instead.


### RAM vs Stack

* **RAM**: The hardware that is large, general-purpose memory where all running programs, their code, data, stack, and heap live.
  *  Random here means you can jump directly to any address in (almost) constant time (`O(1)`), instead of stepping through data in order.
* **Stack**: the region inside a process’s RAM space, used mainly for function call bookkeeping: return addresses, parameters, and local (automatic) variables. It grows and shrinks in a strict **last-in, first-out (LIFO)** order: each function call pushes a new “stack frame,” and returning from the function pops that frame.


### Error Handling (Java)

> [!NOTE]
> The most resilient way to validate input (for critical services) is to accept everything as a String and then just regular expressions to validate!
> Do not write normal business logic around errors. Log context, fail fast, and fix the root cause.

#### 1) Quick definitions

- **Exception** = a problem your program can often anticipate, handle, or report clearly.
- **Checked exception** = must be handled with `try/catch` or declared with `throws`.
- **Unchecked exception** = subclass of `RuntimeException`; does not need to be declared.
- **Error** = serious JVM or system problem, usually not handled in normal business code.

#### 2) Errors vs Exceptions

* Errors: thrown by the OS and is out of your control!
* Exceptions: thrown by the program and is in your control!

Common Error examples:
- `OutOfMemoryError`
- `StackOverflowError`

#### 3) Common exceptions and when to use them

| Exception | Meaning | Typical fix |
|---|---|---|
| `NullPointerException` | Code used a `null` reference | Validate inputs, initialize values early |
| `NumberFormatException` | Text could not be parsed as a number | Validate before parsing |
| `IllegalArgumentException` | Caller passed a bad argument | Throw with a clear message |
| `IllegalStateException` | Object/app state does not allow operation | Check lifecycle or call order |
| `IndexOutOfBoundsException` | Code accessed an invalid index | Validate length/index first |
| `ClassCastException` | Wrong type cast at runtime | Use proper typing, generics, `instanceof` |
| `IOException` | File or stream operation failed | Catch or declare with `throws` |

#### 4) Best practice rules

- Catch only exceptions you can actually handle.
- Validate inputs early.
- Throw the most specific exception possible.
- Do not catch broad `Exception` unless at an application boundary.
- Do not swallow exceptions silently.
- Preserve the original cause when wrapping exceptions.
- Use clear error messages.

#### 5) Common implementations

##### A) Bad input -> `IllegalArgumentException`

```java
public void setQuantity(int quantity) {
    if (quantity < 0) {
        throw new IllegalArgumentException("quantity cannot be negative");
    }
}
```

##### B) Bad state -> `IllegalStateException`

```java
public class ConnectionManager {
    private boolean connected;

    public void connect() {
        connected = true;
    }

    public void send(String message) {
        if (!connected) {
            throw new IllegalStateException("Cannot send before connecting");
        }
        System.out.println("Sent: " + message);
    }
}
```

##### C) Prevent `NullPointerException`

```java
public void sendEmail(String address) {
    if (address == null) {
        throw new IllegalArgumentException("address must not be null");
    }
    System.out.println("Sending to " + address);
}
```

##### D) Prevent `NumberFormatException`

```java
public int parseAge(String input) {
    if (input == null || !input.matches("\\d+")) {
        throw new IllegalArgumentException("age must be numeric");
    }
    return Integer.parseInt(input);
}
```

##### E) Prevent index errors

```java
public char thirdLetter(String s) {
    if (s == null || s.length() < 3) {
        throw new IllegalArgumentException("string must contain at least 3 characters");
    }
    return s.charAt(2);
}
```

##### F) Handle checked exceptions with `throws`

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public String readConfig(Path path) throws IOException {
    return Files.readString(path);
}
```

##### G) Handle checked exceptions with `try/catch`

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public String loadConfig(Path path) {
    try {
        return Files.readString(path);
    } catch (IOException e) {
        throw new RuntimeException("Failed to load config from " + path, e);
    }
}
```

##### H) Use try-with-resources for files

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public void printFirstLine(Path path) {
    try (BufferedReader reader = Files.newBufferedReader(path)) {
        System.out.println(reader.readLine());
    } catch (IOException e) {
        System.err.println("Could not read file: " + e.getMessage());
    }
}
```

## Java Coding Examples

### Scanner Usage, Setters, Getters, ToString (Automobile)

* Prompting the user to input multiple sections of information via `Scanner` and output the content via `System.out.println()`
* Later I want to look into using [joptionpane](https://www.geeksforgeeks.org/java/java-joptionpane/) for a GUI pop-up...

```java
public class Automobile {
    private static int numberOfObjects = 0 ;
    private double price ;
    private String make ;
    private Tire tire ;

    // Default Constructors

    public Automobile() {
        this(0.0, "none", new Tire());
    }

    // Non-default Constructors

    public Automobile (double price, String make, Tire tire) {
        this.price = price ;
        this.make = make ;
        this.tire = tire ;
        numberOfObjects++ ;
    }
     // Setters
    public void setPrice (double price) { this.price = price  ; }
    public void setMake (String make) { this.make = make ; }
    public void setTire (Tire tire) { this.tire = tire ; }

    // Getters

    public double getPrice() {
        return price;
    }

    public String getMake() {
        return make;
    }

    public Tire getTire() {
        return tire;
    }

    public static int getNumberOfObjects() {
        return numberOfObjects;
    }

    @Override
    public String toString() {
        return "Automobile {" +
                "Price (double) = " + price +
                ", Make (String) = '" + make + '\'' +
                ", Tire (String) = " + tire +
                '}';
    }
}
```

```java
public class Tire {
    private double price ;
    private String make ;
    private int mileage ;

    // Default Constructor
    public Tire () {
        price = 0.0 ;
        make = "none" ;
        mileage = 0 ;
    }

    // Non-default Constructor
    public Tire (String make, int mileage, double price) {
        this.price = price ;
        this.make = make ;
        this.mileage = mileage ;
    }

    // Setters
    public void setPrice (double price) { this.price = price ; }
    public void setMake (String make) { this.make = make ; }
    public void setMileage (int mileage) { this.mileage = mileage ; }

    // Getters
    public double getPrice () { return price ; }
    public String getMake () { return make ; }
    public int getMileage () { return mileage ; }

    @Override
    public String toString() {
        return "Tire {" +
                "Price (double) = " + price +
                ", Make (String) = '" + make + '\'' +
                ", Mileage (int) = " + mileage +
                '}';
    }
}
```

```java
public class Demo {

    public static void main(String[] args) {

        // Instance 1 Defaults Only

        Automobile auto1 = new Automobile() ;

        // Instance 2 Passing via Parameters

        Automobile auto2 = new Automobile(4250.00, "VW", new Tire("Costco Brand", 10000, 500.00)) ;

        // Instance 3 User Input with Prints In-between

        Automobile auto3 = new Automobile() ;
        Scanner scanner = new Scanner(System.in) ;
        double price ;
        String make ;

        // Breaking up the input process using Scanner()

        System.out.println("Enter automobile price (int): ") ;
        price = scanner.nextDouble() ; scanner.nextLine() ;

        System.out.println("Enter automobile make (String): ") ;
        make = scanner.nextLine() ;

        System.out.println("Enter tire make (String): ") ;
        String tireMake = scanner.nextLine() ;

        System.out.println("Tire mileage (int): ") ;
        int tireMileage = scanner.nextInt() ; scanner.nextLine() ;

        System.out.println("Tire price (double): ") ;
        double tirePrice = scanner.nextDouble() ; scanner.nextLine() ;

        auto3.setPrice(price) ;
        auto3.setMake(make) ;

        // Creating a Tire object and setting it to the Tire class that requires double, String, int from the Tire Class!
        auto3.setTire(new Tire(tireMake, tireMileage, tirePrice)) ;

        // Final Output
        System.out.println("1:" + " " + auto1.getPrice() + " " + auto1.getMake() + " " + auto1.getTire()) ;
        System.out.println("2:" + " " + auto2.getPrice() + " " + auto2.getMake() + " " + auto2.getTire()) ;
        System.out.println("3:" + " " + auto3.getPrice() + " " + auto3.getMake() + " " + auto3.getTire()) ;

        // Counter to Determine Objects Created
        System.out.println("Current Object Creation Total:" + " " + Automobile.getNumberOfObjects()) ;
    }

}
```

### For-Loop Practice

#### Retirement Calculator

```java
import java.text.DecimalFormat;
import java.util.Scanner;

public class InvestmentCalculator {

    // Creating a tool to calculate the future value of an investment.

    public static void main(String[] args) {

        Scanner obj = new Scanner(System.in);
        System.out.println("Welcome to the Investment Calculator!\n");

        System.out.print("How Much Do You Have Saved? ");
        double currentBalance = obj.nextDouble(); obj.nextLine();

        while (currentBalance < 0) {
            System.out.println("You cannot enter a negative number, try again!");
            currentBalance = obj.nextDouble(); obj.nextLine();
        }

        System.out.print("Enter the Current Interest Rate: ");
        double interestRate = obj.nextDouble(); obj.nextLine();

        while (interestRate < 0) {
            System.out.println("Please enter a valid interest rate:");
            interestRate = obj.nextDouble(); obj.nextLine();
        }

        System.out.print("Enter your age: ");
        int userAge = obj.nextInt();
        obj.nextLine();

        while (userAge < 0) {
            System.out.println("Please enter a valid age:");
            userAge = obj.nextInt(); obj.nextLine();
        }

        System.out.print("Enter your desired retirement age: ");
        int retirementAge = obj.nextInt();
        obj.nextLine();

        while (retirementAge < userAge || retirementAge == 0) {
            System.out.println("Please enter a retirement age greater than your current age:");
            retirementAge = obj.nextInt(); obj.nextLine();
        }

        int yearsToRetirement = retirementAge - userAge;
        for (int i = 0; i < yearsToRetirement; i++) {
            double newBalance;
            newBalance = currentBalance + (currentBalance *(interestRate/100));
            currentBalance = newBalance;

            // Formatted output (https://www.geeksforgeeks.org/java/formatted-output-in-java/)
            DecimalFormat account = new DecimalFormat("$###,###,###,###,###.##");
            System.out.println("Year " + (i + 1) + ": " + account.format(currentBalance));
        }
    }
}
```

### While Loop Practice

#### SavingsGoal.java

```java
public class SavingsGoal {
    public static void main(String[] args){

        Scanner scanner = new Scanner(System.in);

        System.out.println("What's Your Savings Goal?");
        int savingsGoal;
        savingsGoal = scanner.nextInt();

        while (savingsGoal <= 1) {
            System.out.println("Invalid amount, please enter a savings goal greater than 1...");

            System.out.println("\n") ;

            System.out.println("What's Your Savings Goal?");
            savingsGoal = scanner.nextInt();
        }

        int totalSaved = 0 ;
        while (totalSaved < savingsGoal){

        System.out.println("Enter Deposit Amount: ");
        int depositAmount = scanner.nextInt();

            totalSaved += depositAmount ;

            if (totalSaved >= savingsGoal) {
                break;
            }
        System.out.println("You have $" + totalSaved + " so far." + " " + "You need $" + (savingsGoal - totalSaved) + " " + "to reach your goal!");

        }
        System.out.println("Congratulations, you've saved $" + totalSaved + " " + "towards your phone!") ;

    }
}
```

#### MenuOptions.java

```java
package feb_9_13.feb_12_more_while;

import java.util.Scanner;

public class MenuOptions {

  public static void displayMenuItems(){
    System.out.println("1. Add");
    System.out.println("2. Subtract");
    System.out.println("3. Display");
    System.out.println("4. Exit");
  }

  public static void add(){

    Scanner obj = new Scanner(System.in);
    System.out.println("Enter first number: ");
    int num1 = obj.nextInt(); obj.nextLine();

    System.out.println("Enter second number: ");
    int num2 = obj.nextInt(); obj.nextLine();

    int sum = num1 + num2;
    System.out.println("The sum is: " + sum);
  }

  public static void sub(){

    Scanner obj = new Scanner(System.in);
    System.out.println("Enter first number: ");
    int num1 = obj.nextInt(); obj.nextLine();

    System.out.println("Enter second number: ");
    int num2 = obj.nextInt(); obj.nextLine();

    int diff = num1 - num2;
    System.out.println("The difference is: " + diff);

  }

  // NOTE: Passing the message from Main into this function!!
  public static void displayUserMessage(String messageForUser){

    System.out.println("Your Message Is: " + messageForUser);

  }

  public static void exit(){
    System.out.println("Exiting Program...");
  }


}
```

#### Main.java (for MenuOptions.java)
```java
package feb_9_13.feb_12_more_while;

import java.util.Scanner;
import static feb_9_13.feb_12_more_while.MenuOptions.*;

public class Main {

  // Display a menu with four options
  // add: call a function that will accept two numbers and display the output (sum)
  // sub: call a function that will accept two numbers and display the output (difference)
  // display: Accept a message from the user and pass the message as a display option
  // exit: exit the program

  public static void main(String[] args){

    Scanner obj = new Scanner(System.in);
    int userChoice;
    System.out.println("Please Select an Option..." );
    displayMenuItems();

    userChoice = obj.nextInt(); obj.nextLine();

    while (userChoice != 4){

      switch(userChoice){
        case 1: add(); break;

        case 2: sub(); break;

        case 3: System.out.println("Enter your message: ");
          String messageForUser = obj.nextLine();

          // Here we are passing the message to be displayed in the displayUserMessage method!
          displayUserMessage(messageForUser);

          break;

        case 4: exit(); break;
        default: System.out.println("Invalid Option, Please Try Again");
      }

      displayMenuItems();

      System.out.println("Please Select an Option..." );

      userChoice = obj.nextInt(); obj.nextLine();

    }

  }
}
```

#### Binary Search Example

```java
import java.util.Scanner;

public class BinarySearch {
    public static void main(String[] args){
        Scanner obj = new Scanner(System.in);

        int upper;
        int lower;
        boolean found = false;
        int attempts = 0;

        System.out.println("Enter Upper Limit: ");
        upper = obj.nextInt(); obj.nextLine();

        System.out.println("Enter Lower Limit: ");
        lower = obj.nextInt(); obj.nextLine();

        System.out.println("Enter the Correct Guess: ");

        System.out.println("As the program proceeds, enter high, low, or correct: ");

        // Implementation of the Binary Search Algorithm
        int machineGuess = lower + (upper - lower) / 2;

        while (!found){

            System.out.println("My guess is " + machineGuess);

            String myResponse = obj.nextLine();

            System.out.println("Current Upper Value: " + upper);
            System.out.println("Current Lower Value: " + lower);

            if (lower > upper) {
                System.out.println("You're either cheating OR you forgot your number, try again!");
                break;
            }

            else if (myResponse.equals("high")) {

                upper = machineGuess - 1;
                machineGuess = lower + (upper - lower) / 2;
                attempts++;
            }

            else if (myResponse.equals("low")) {

                lower = machineGuess + 1;
                machineGuess = lower + (upper - lower) / 2;
                attempts++;
            }

            else if (myResponse.equals("correct")) {
                found = true;
            }

        }

        System.out.println("Total Attempts Taken: " + attempts);
    }
}
```


### Do-While Loop Practice

#### Main.java

```java
public class Main {

    public static void main(String[] args) {
        System.out.println("Welcome to the Calculate Average Tool!\n");

        Scanner obj = new Scanner(System.in);
        int userInput;

        System.out.println("Please Select an Option: ");
        displayMenu();
        userInput = obj.nextInt(); obj.nextLine();

        do{
            switch(userInput){
                case 1: calculateAverage(); break;
                case 2: calculateMinimum(); break;
                case 3: exit(); break;
                default: System.out.println("Invalid Option Selected");
            }

            displayMenu();
            System.out.println("Please Select an Option:");
            userInput = obj.nextInt(); obj.nextLine();

        }while(userInput != 3);
    }
}
```

#### AverageCalc.java

```java
import java.util.Scanner;

public class Average {

    public static void displayMenu() {
        System.out.println("1. Calculate Average\n2. Calculate Minimum\n3. Exit");
    }

    public static void calculateMinimum() {

        Scanner obj = new Scanner(System.in);
        System.out.println("Enter the number of values to find minimum of: ");
        int numberLimit = obj.nextInt();
        obj.nextLine();
        int minimum = Integer.MAX_VALUE;

        for (int i = 0; i < numberLimit; i++) {
            System.out.println("Enter a Number for Comparison: ");
            int userInput = obj.nextInt(); obj.nextLine();

            if (userInput == -99){
                System.out.println("User Entered -99, Exiting...");
                exit();
            }

            else if (minimum > userInput){
                minimum = userInput;
            }

        }
        System.out.println("The minimum value is: " + minimum);

    }

    public static void calculateAverage() {
        Scanner obj = new Scanner(System.in);

        System.out.println("Enter the number of values you want to find the average for: ");
        int numberLimit = obj.nextInt();

        while (numberLimit <= 0){
            System.out.println("Invalid number of values, please enter a positive number");
            numberLimit = obj.nextInt();
        }

        // Placing the list of user input numbers into an ARRAY (dictionary), this was much easier for the calculation.
        double[] array = new double[numberLimit];
        double totalCost = 0.0;

        for (int i = 0; i < array.length; i++) {
            System.out.println("Enter a Number for Average Calculation: ");
            array[i] = obj.nextDouble();

            while (array[i] <= 0){
                System.out.println("Negative number's aren't allowed, please enter another number to average");
                array[i] = obj.nextDouble();
            }
        }

        for (int i = 0; i < array.length; i++) {
            totalCost = totalCost + array[i];
        }

        double average = totalCost / array.length;
        System.out.println("Average: " + average);

    }

    public static void exit() {
        System.out.println("Thank you for using the Calc, Goobye!");
        System.exit(0);
    }

}
```

### Arrays

#### Basic Arrays

##### ScoreBoard.java

```java
import java.util.Scanner;

public class score_board {

    public static void main(String[] args){

        /// NOTE 1: Java has a built-in "Arrays.toString()" function that can easily output the contents of a list
        /// NOTE 2: Use a for-loop if you want to customize the output of something, use "Arrays.toString()" when you want a quick method to output contents

      /// Specific if you want to initialize a new Class object OR a new LIST!
        int [] scores = new int[5];
        Scanner obj = new Scanner(System.in);

        for(int i=0; i < scores.length; i++){
            System.out.println("Enter your score...");
            
            /// KEY: since arrays function via indicies, we use "i" to iterate and add space inside of the array as needed.
            scores[i] = obj.nextInt();
        }
            System.out.println("--- FINAL HIGH SCORES ---");

        for(int j = 0; j < scores.length; j++){
            System.out.print(scores[j] + " ");
        }
    }
}
```


### Recursion Fundamentals

**When to Use Recursion: Sanity Check**

1. Any problem that can be defined within itself, but optimized and smaller... (called the **`Recursive Case`**).
2. If there is a trivial case... Meaning that it being stated is itself (e.g., 1! is 1). (called the **`Base Case`**).
3. When working with inherently recursive data structures, such as navigating file directories, trees, or graphs.
4. When a problem can be easily broken down into smaller, identical sub-problems (often referred to as a "Divide and Conquer" approach).

#### How to Solve Recursion

1. Identifying the terminating Case (the **Base Case**), or the logic or "equation" that describes the problem or that can be reused.
> [!WARNING]
> Without a proper terminating case, your Java program will run infinitely and crash with a `StackOverflowError`

2. **DEFINE** the problem in terms of itself (the logic of the solution within itself). You must ensure that **every time you define the problem within itself, the input gets closer to the terminating case**.
3. Determine what data needs to be returned and how the results of those smaller sub-problems will combine to give you your final answer.


> [!NOTE]
> Don't solve the problem! Just define the problem!
> If it reads right, then it is right!
> Defining the **limiting** OR **boundary conditions** that are required to solve the problem
> The computer uses a "Call Stack" to remember where it left off. Every time a recursive definition is called, it pauses the current step, adds a new step to the top of the stack, and waits for the smaller problem to finish first.

#### Factorial

```java
    public static int factorial(int n){

        ///  Define terminating case... Essentially conditions that make the solution trivial...

        if (n == 1)
            return 1;

        ///  Define the problem in terms of itself...
        return n * factorial(n-1);
}
```

#### Fibonacci Sequence

```java
    public static int fibRec(int n){

        ///  NOTE: positions 0 and 1 are hardcoded to 1 so every other case works!
        if (n == 0)
            return 1;

        if (n == 1)
            return 1;

        return fibRec(n -1) + fibRec(n -2);

  }
```

#### Palindromic Identification

```java
    /// The key here is that we first convert the Integer to String so that we can iterate through it...
    public static boolean palindromic(String n){
        if (n.length() == 0)
            return true;

        if (n.length() == 1)
            return true;

        /// Here we are using the `charAt`: which returns the value of a character at a specific length
        ///  We are also calling the palindromic() function and then calling the `substring` built-in to compare the middle values to each other and ensure that the match...
        return(n.charAt(0) == n.charAt(n.length() -1)) && palindromic(n.substring(1, n.length() - 1));
  }
```

#### Merge Sort

> Here is a snippet from the larger Merge Sort algorithm that I added [here](https://github.com/chumphrey-cmd/Java-Practice/blob/main/dsa/MergeSort.java).

**Snippet A**

```java
int left = mid - lower + 1;
int[] arr_left = new int[left];
```

The "left" variable is being assigned as the primitive type of `int`. It's being used to get the actual length of the array of the left side. To get the exact size we need to take the mid-point (or the middle-most index) subtracted from the lowest index (e.g., 0) + 1 to get the exact **capacity (how many boxes we need to build)**.

Next we're creating another array (`array_left`) with the exact size of the "left" variable that we set in the line above. This sets the correct length of the `arr_left` so that when the array is filled, it doesn't overflow.

---

**Snippet B**

```java
for (int i = 0; i < left; i++)
    arr_left[i] = arr[lower + i];
```

Here we are getting the actual values of the `arr_left` (currently it contains **default 0s**, but not the **real** values). We are iterating through the indices using a for-loop and extracting the values at each index.

* `arr_left[i]` is the array that has the correct length set by Snippet A that is going to be filled as we iterate through the index with the values of the original `array[lower + i]` (lower index + i (iteration up until it is equal to the length arr_left set in Snippet A)).

---

**Snippet C**

```java
while ((i < arr_left.length) && (j < arr_right.length))
    if(arr_left[i] < arr_right[j])
        arr_comb[k++] = arr_left[i++];
    else
        arr_comb[k++] = arr_right[j++];
```

Here we are doing the actual value comparison that serves to sort each part of the array. Earlier we initialized `i`, `j`, and `k` as primitive types of "int" set to 0.

* We are using `i` for `arr_left`, `j` for `arr_right`, and `k` for the combined array (`arr_comb`) which will contain both values from `i` and `j`.

Within the while loop, while both `i` and `j` are less than the length of their respective arrays' length, continue with the conditional statement.

`IF` the values within the arr_left are LESS THAN the values within `arr_right` (here we are describing the actual values at each index (e.g., 0 = 99, 1 = 12, etc.); place the left value into **the next available empty slot in the `arr_comb` array (tracked by `k`)**.

`ELSE` (meaning if the values in `arr_right` are LESS THAN the values of the `arr_left`); place the right value into **the next available empty slot in the `arr_comb` array (tracked by `k`)**.

We're basically **building a new array from scratch**, with each lowest value being **placed sequentially** from left to right (e.g., 1, 2, 3, 4, etc.).

### `P`, `NP`, `NP_complete` Algorithms

* P:
* NP:
* NP_complete:
  * **Greedy Algorithm** (Set coloring problem...)
  * **Nap Sack Problem** (Grabbing the highest weighted or most valuable item or object...)
  * **Genetic Algorithm**
  * **Hungarian Sorting Algorithm**
  * **Tower of Hanoi (ToH)**

# References
1. https://www.geeksforgeeks.org/dsa/control-structures-in-programming-languages/
2. https://www.geeksforgeeks.org/software-engineering/mvc-framework-introduction/
3. https://geeksforgeeks.org/dsa/time-complexities-of-all-sorting-algorithms/
4. https://www.geeksforgeeks.org/advance-java/spring/
5. https://docs.spring.io/spring-data/jpa/reference/jpa/query-methods.html
