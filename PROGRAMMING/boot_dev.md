# Python

## Functions

### None (NoneType)
* **None** is the Type `NoneType`
  * **Essentially**, No value / not set / doesn’t exist (but different than 0 since 0 can be technically an integer)...
  * Useful in error handling, failing gracefully, optional function arguments, variables that will be filled later, items that are there, and items that potentially aren't there, etc.
  * Used in situations where a user hasn't selected any option (e.g., limbo)

* In the case of print debugging, use `type`:

```python
print(type(var_1))
```

### Multi-Variable Declaration

> A way to save space and keep the code clean by specifying setting all of the variables on the same line, BUT they must all be related to one another for sanity's sake!

```python
# This example...
sword_name, sword_damage, sword_length = "Excalibur", 10, 200

# Same as above...
sword_name = "Excalibur"
sword_damage = 10
sword_length = 200
```

### `return`

`return`: Makes the value available to the caller of the function 

> [!NOTE]
>
> `return` keeps the result just in case you want to use the result somewhere else within your program. Another way to think about it is that the `return` function is like an **output port** rather  than a storage area.
> 
> It's used inside a function to send a value back to the place where the function was called. Once the return is executed, the function stops running, and any code written after it is ignored.

* A **function call** is like asking a helper: “Here are some inputs, please compute something and hand me back the result (via `return`)."
* `return` is the moment the helper hands you the result and stops working.

```python
def square(n):
    return n * n

result = square(4)
print(result)

# Output = 16
```

### `f-strings` (Formatted Strings)

> Basically, a really flexible way to create strings and complex statements that require the use of previously defined variables that change over time.

For example:

```python
def f_string(your_name):
  name = f"{your_name} for the f-string example"
  return name

# Usage
print(f_string("John"))
print(f_string("Jane"))

# Output
# John for the f-string example
# Jane for the f-string example
```
* Here we can use f-strings to take the changing variable of `your_name` and append additional text to the desired name. 
* Obviously, f-strings are far more powerful than the example provided, but this gives you the gist...

### Parameters vs. Arguments

**Parameters**
* Are the placeholders, names, or symbols that are used inside the function. They can be whatever you want them to be (`a`, `b`, `var`)
* **P**arameter = **P**laceholder

**Arguments**
* Are the actual values that go into the function (`5`, `6`, `"some value"`)
* **A**rguments = **A**ctual Value

```python
# a and b are parameters
def add(a, b):
    return a + b

# 5 and 6 are arguments
sum = add(5, 6)
```

### Default Values

> Allows you to specify the default output for the function parameter if the arguments are optional. Prevents the function or program from breaking.

```python
def get_greeting(email, name="there"):
    print("Hello", name, "welcome! You've registered your email:", email)

get_greeting("user1@example.com", "User1")
# Hello User1 welcome! You've registered your email: user1@example.com

get_greeting("user1@example.com")
# Hello there welcome! You've registered your email: user1@example.com
```

## Debugging Basics

* Let's say you're looking at a lone function within a massive code base: 

```python
def some_function(foo, bar):
```

* A good way to quickly determine what the function is suppose to do is to include a **`return None, None`** (basically like a "Debug Allow All" or Sanity Check to display the arguments that are required...)

```python
def some_function(foo, bar):
  return None, None
```

## Computing Basics

### **Floor Division**

> Like normal division except the result is **[floored](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions)**, meaning the result is rounded down to the nearest integer using the **`//`** operator.

```python
7 // 3
# 2 (an integer, rounded down from 2.333)
-7 // 3
# -3 (an integer, rounded down from -2.333)
```

### Operators

**`+=`**: Increment
```python
star_rating = 4
star_rating += 1
# star_rating is now 5
```

**`-=`**: Decrease
```python
star_rating = 4
star_rating -= 1
# star_rating is now 3
```

**`+=`**: Multiply
```python
star_rating = 4
star_rating *= 2
# star_rating is now 8
```

**`/=`**: Divide
```python
star_rating = 4
star_rating /= 2
# star_rating is now 2.0
```

### Scientific Notation

> Represented by `e` or `E` followed by a positive or negative integer. 

```python
print(16e3)
# Prints 16000.0

print(7.1e-2)
# Prints 0.071
```

### Underscores

> Python also allows you to represent large numbers in the decimal format using underscores as the delimiter instead of commas to make it easier to read.

```python
num = 16_000
print(num)
# Prints 16000

num = 16_000_000
print(num)
# Prints 16000000
```

### Logical Operators

**Cheatsheet**

True and True == True
True and False == False
False and False == False

True or True == True
True or False == True
False or False == False

**Python Syntax**

```python
print(True and True)
# prints True

print(True or False)
# prints True

print(not True)
# Prints: False

print(not False)
# Prints: True
```

### Binary 

> Use the **`0b`** prefix to specify binary

```python
print(0b0001)
# Prints 1

print(0b0101)
# Prints 5
```

### Bitwise "&" and "|" Operators

```python
# "&"
0b0101 & 0b0111
# equals 5

binary_five = 0b0101
binary_seven = 0b0111
binary_five & binary_seven
# equals 5

# "|"
0b0101 | 0b0111
# equals 0111 (7)
```

### Binary Conversion

> You can use the `int()` function to convert a binary string to an integer. It takes the second argument that specifies the base of the number (e.g., binary = base 2).

```python
# this is a binary string
binary_string = "100"

# convert binary string to integer
num = int(binary_string, 2)
print(num)
# 4
```

## Comparisons (if...else)

### if

> [!NOTE]
>
> Within if statements, the **`return`** block is used as a sort of stop-gap/check within the function. IF the function sucessfully completes the comparison, DON'T continue any further and repeat the comparison until the end.

```python
def show_status(boss_health):
    if boss_health > 0:
        print("Ganondorf is alive!")
        return
    print("Ganondorf is unalive!")
```
If boss_health is greater than 0, then this will be printed: **`Ganondorf is alive!`** 
Otherwise, **`Ganondorf is unalive!`**

### if-elif-else

```python
def player_status(health):
    if health <= 0:
        return "dead"
    elif health <= 5:
        return "injured"
    else:
        return "healthy"
```

## Loops

### Simple "for loop" in Python

```python

# Simple for loop syntax...

for i in range(0, 10):
    print(i)
```

```python

# Simple for loop with step count...

for i in range(0, 10, 2):
    print(i)
# prints:
# 0
# 2
# 4
# 6
# 8

for i in range(3, 0, -1):
    print(i)
# prints:
# 3
# 2
# 1
```

```python
# A more complex for-loop with a nested if-statement...
def countdown_to_start():
    for i in range(10, 0, -1):

        if i == 1:
            print(f"{i}...Fight!")

        else:
            print(f"{i}...")
```

### Simple "while loop" in Python

```python
while 1:
    print("1 evaluates to True")

# prints:
# 1 evaluates to True
# 1 evaluates to True
# (...continuing)
```

```python
num = 0
while num < 3:
    num += 1
    print(num)

# prints:
# 1
# 2
# 3
# (the loop stops when num >= 3)
```

### `continue` statements

* **`continue`**: means "go directly to the next iteration of this loop." Whatever else was supposed to happen in the current iteration is skipped.

```python
# Remember, `range` is inclusive of the start, but exclusive of the end
counter = 0
for number in range(1, 51):
    counter = counter + 1

    if counter == 7:
        counter = 0 # Reset the counter
        continue # Skip this number

    print(number)
```

```python
# A more complex example that handles includes a counter + conditional...

def award_enchantments(start, end, step):
    counter = 0
    for quest_number in range(start, end, step):
        counter = counter + 1

        if counter < 3:
            continue
        else:
            counter = 0
        
        enchantment_strength = quest_number * 5
        print(
            f"Enchantment of strength {enchantment_strength} awarded for completing {quest_number} quests!"
        )
```

* **`continue`** can also halt the current iteration and jump to the next one, which saves the program from doing unnecessary work.

```python
numbers = [16, -4, 25, -9, 36, 0, 49]

for number in numbers:
    if number < 0:
        continue  # Skip negatives to avoid complex numbers

    print(f"The square root of {number} is {number ** 0.5}.")
```

### `break` statements

* **`break`**: are used to stop the execution of a loop (e.g., like a fail-safe to prevent indefinite execution).

```python 
for n in range(42):
    print(f"{n} * {n} = {n * n}")
    if n * n > 150:
        break

# 0 * 0 = 0
# 1 * 1 = 1
# 2 * 2 = 4
# 3 * 3 = 9
# 4 * 4 = 16
# 5 * 5 = 25
# 6 * 6 = 36
# 7 * 7 = 49
# 8 * 8 = 64
# 9 * 9 = 81
# 10 * 10 = 100
# 11 * 11 = 121
# 12 * 12 = 144
# 13 * 13 = 169
```