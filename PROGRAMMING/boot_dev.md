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