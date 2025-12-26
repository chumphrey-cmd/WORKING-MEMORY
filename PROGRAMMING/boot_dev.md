# Python

## None (NoneType)
* **None** is the Type `NoneType`
  * **Essentially**, No value / not set / doesn’t exist (but different than 0 since 0 can is technically an integer)...
  * Useful in error handling, failing gracefully, optional function arguments, variables that will be filled later, items that are there and items that potentially aren't there, etc.
  * Used in situations where a user hasn't selected any option (e.g., limbo)

* In the case of print debugging use `type`:

```python
print(type(var_1))
```

## Multi-Variable Declaration

> A way to save space and keep the code clean by specifying setting all of the variables on the same line, BUT they must all be related to one another for sanity's sake!

```python
# This example...
sword_name, sword_damage, sword_length = "Excalibur", 10, 200

# Same as above...
sword_name = "Excalibur"
sword_damage = 10
sword_length = 200
```

## `return`

`return`: Makes the value available to the caller of the function 

> [!NOTE] return further explained:
>
> `return` keeps the result just in case if you want to use the result on somewhere else within your program. Another way to think about it is that `return` function’s like an **output port** than a storage area.
> 
> It's used inside a function to send a value back to the place where the function was called. Once return is executed, the function stops running, and any code written after it is ignored.

* A **function call** is like asking a helper: “Here are some inputs, please compute something and hand me back the result (via `return`)."
* `return` is the moment the helper hands you the result and stops working.

```python
def square(n):
    return n * n

result = square(4)
print(result)

# Output = 16
```

## `f-strings` (Formatted Strings)

> Basically a really flexible way to create strings and complex statements that require the use previously defined variables that change over time.

For example:

```python
def f_string(your_name):v
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
* Obviously f-strings is far more powerful than the example provided, but this gives you the gist...

## Parameters vs. Arguments

**Parameters**
* Are the placeholders, names, or symbols that are used inside of the function. They can be whatever you want them to be (`a`, `b`, `var`)
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

## Default Values

> Allow you to specify the default output for the function parameter in the event that the arguments are optional. Prevents the function or program from breaking.

```python
def get_greeting(email, name="there"):
    print("Hello", name, "welcome! You've registered your email:", email)

get_greeting("user1@example.com", "User1")
# Hello User1 welcome! You've registered your email: user1@example.com

get_greeting("user1@example.com")
# Hello there welcome! You've registered your email: user1@example.com
```

