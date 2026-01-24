# Python Fundamentals

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

### Floor Division and Integer Output Puzzle

```python
'''
Here we are ensuring that we're doing pure integer math rather than introducing floats (we want 10 instead of 10.0).
Initially, "int((current_mah / capacity_mah) * 100)" was used, but this would introduce bugs later on with situations with more complex numbers.
'''
def battery_percent_remaining(current_mah, capacity_mah):
    int_percent = current_mah * 100 // capacity_mah
    return int_percent


def minutes_remaining(current_mah, drain_ma):
    total_minutes = current_mah * 60 // drain_ma
    return total_minutes


def format_battery_status(current_mah, capacity_mah, drain_ma):
    format_percent = battery_percent_remaining(current_mah, capacity_mah)
    format_min_remaining = minutes_remaining(current_mah, drain_ma)

    hour = format_min_remaining // 60
    minutes = format_min_remaining % 60

    final_output = f"{format_percent}% - {hour}h {minutes}m"
    return final_output
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

**`*=`**: Multiply
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

### Logic Puzzles

* This problem primarily focused on separation and structure of logical operators, specificially "precedence" when it comes to the grouping specific logical operators...

```python
def logic_gate(a, b, gate):

    a_is_one = (a == 1) # True
    a_is_zero = (a == 0) # False
    
    b_is_one = (b == 1) # True
    b_is_zero = (b == 0) # False

    '''
    Example of situation where the underlying gate condition (LEFT) is compared against the logic (RIGHT).
    Take note of the paraentheses that group each of the logic statments...
    '''
    
    if (gate == "AND" or gate == "OR") and ((a_is_one and b_is_one) or (b_is_one and a_is_one)): 
        return 1

    elif gate == "OR" and ((a_is_one and b_is_zero) or (b_is_one and a_is_zero)):
        return 1

    elif gate == "XOR" and ((a_is_one and b_is_one) or (b_is_one and a_is_one)):
        return 0

    elif gate == "XOR" and ((a_is_one and b_is_zero) or (b_is_one and a_is_zero)):
        return 1

    elif (gate == "AND" or gate == "OR") and ((a_is_zero and b_is_zero) or (b_is_zero and a_is_zero)):
        return 0

    elif (gate == "NAND") and ((a_is_one and b_is_one) or (b_is_one and a_is_one)):
        return 0

    elif (gate == "NAND") and ((a_is_one and b_is_zero) or (b_is_one and a_is_zero)):
        return 1
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

```python
# A deceptively simple (complex) for-loop that stumped me...
# Specifies a start point for you to iterate from "xp = 0" and adds the current xp to (i * 5) to get total xp for the specific level

def calculate_experience_points(level):
    xp = 0
    
    for i in range(1, level):
        xp = xp + (i * 5)

    return xp
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

```python
# Another deceptively simple while-loop that stumped me...
# while-loop that ensures that mana < max_mana AND num_potions > 0, if those conditions are met, +1 to mana and -1 to potions...

def meditate(mana, max_mana, num_potions):
    while mana < max_mana and num_potions > 0:
        mana += 1
        num_potions -= 1
        
    return mana, num_potions
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
# A more complex example that includes a counter + conditional...

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

## Lists `[]`

### List Updates

```python
inventory = ["Leather", "Iron Ore", "Healing Potion"]
inventory[0] = "Leather Armor"
# inventory: ['Leather Armor', 'Iron Ore', 'Healing Potion']
```

### Appending

```python
cards = []
cards.append("nvidia")
cards.append("amd")
# the cards list is now ['nvidia', 'amd']
```

### Pop

* **`.pop()`** is the opposite of **`.append()`**. Pop removes the last element from a list and returns it for use. 

```python
vegetables = ["broccoli", "cabbage", "kale", "tomato"]
last_vegetable = vegetables.pop()
# vegetables = ['broccoli', 'cabbage', 'kale']
# last_vegetable = 'tomato'
```

### Iterating Over a List (using Indexes)

```python
def get_item_counts(items):
    potion_count = 0
    bread_count = 0
    shortsword_count = 0

    '''
    "i": is the specific index that is iterating over the list, 
    "items": are the items that are within the items list.
    '''

    for i in range(0, len(items)): # MORE VERBOSE SYNTAX (used if you DO NOT need to know the index number)
        
        if items[i] == "Potion":
            potion_count += 1

        elif items[i] == "Bread":
            bread_count += 1

        elif items[i] == "Shortsword":
            shortsword_count += 1

    return potion_count, bread_count, shortsword_count
```

### Iterating Over a List (no Index)

```python
trees = ['oak', 'pine', 'maple']
for tree in trees: # MUCH CLEANER SYNTAX
    print(tree)
# Prints:
# oak
# pine
# maple
```

### Float

#### Finding Maximums

* The built-in float() function can create a numeric floating point value of negative infinity. Instead of initializing a base value like 0 or -100000, we can use float("-inf") to represent negative infinity. Because every value will be greater than negative infinity, we can use it as a starting point to help us achieve our goal of finding the max value.

```python
negative_infinity = float("-inf")
positive_infinity = float("inf")
```

```python
'''
Finding the maximum value using a for loop and "float("-inf") as the comparison argument. 

NOTE: ensure that you mind the location of where `return` statments are called...

'''
def find_max(nums):
    max_so_far = float("-inf")
  
    for num in nums:
        if num > max_so_far:
            max_so_far = num

    return max_so_far
```

#### Loops, State, Counters, and Tracking Maximums

```python
'''
Quite a tricky puzzle where we work with the Collatz sequence for a positive integer. 

We're: 
1. Using a while-loop to ensure that the integer does not equal 1
2. Determining whether or not it is positive or negative
3. Incrementing steps (# of times the conditional runs) each time that the loop is ran when the positive "n" integer input
4. As the loop is running, if the current value is greater than the previous max_value, update the max_value to current value

'''
def collatz_stats(n):

    current = n
    steps = 0
    max_value = n

    while current != 1:
    
        if current % 2 == 0:
            current = current // 2

        else:
            current = 3 * current + 1

        steps += 1
            
        if current > max_value:
            max_value = current

    return steps, max_value
```

### Modulo Operator (%)

> [!NOTE]
>
> An excellent way to determine if a number is even using the **`%`**. An odd number is a number that when divided by 2, the remainder is not 0. 
> 
> **`x % 2 = 0 (EVEN NUMBER)`** 
> 
> **`x % 2 != 0 (ODD NUMBER)`**

```python
def get_odd_numbers(num):
    odd_numbers = []

    for i in range(0, num):
        
        if i % 2 != 0: # if the value when divided by i % 2 is not 0, the output will be all odd numbers. 
            odd_numbers.append(i)

    return odd_numbers
```

### Slicing Lists

```python
my_list[ start : stop : step ]
```

```python
def get_champion_slices(champions):

    # Starts with the third champion and goes to the end of the list.
    first = champions[2:]

    # Returns champions list that starts at the beginning of the list and includes all champions except for the very last champion.
    second = champions[:-1]

    # Returns champions list that only includes the champions in even numbered indexes
    third = champions[::2]

    return first, second, third
```

```python
# slice scores list from index 1, up to but not including 5, skipping every 2nd value". All of the sections are optional.

scores = [50, 70, 30, 20, 90, 10, 50]
# Display list
print(scores[1:5:2])
# Prints [70, 20]
```

#### Omitting Sections

```python
# numbers[:3] means "get all items from the start up to (but not including) index 3". numbers[3:] means "get all items from index 3 to the end".

numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
numbers[:3] # Gives [0, 1, 2]
numbers[3:] # Gives [3, 4, 5, 6, 7, 8, 9]
```

#### Using only the "step" Section

```python
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
numbers[::2] # Gives [0, 2, 4, 6, 8]
```

#### Negative Indices

* Used to count from the end of the list. For example, `numbers[-1]` gives the last item in the list, `numbers[-2]` gives the second last item, and so on.

```python
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
numbers[-3:] # Gives [7, 8, 9]
```

### List Operations - Concatenation

```python
total = [1, 2, 3] + [4, 5, 6]
print(total)
# Prints: [1, 2, 3, 4, 5, 6]
```

### List Operations - Contains

```python
fruits = ["apple", "orange", "banana"]
print("banana" in fruits)
# Prints: True

fruits = ["apple", "orange", "banana"]
print("banana" not in fruits)
# Prints: False
```

### List Deletion

* **`del`**: deletes items from objects. You can delete specific indexes or entire slices.

```python
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]

# delete the fourth item
del nums[3]
print(nums)
# Output: [1, 2, 3, 5, 6, 7, 8, 9]

# delete the second item up to (but not including) the fourth item
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
del nums[1:3]
print(nums)
# Output: [1, 4, 5, 6, 7, 8, 9]

# delete all elements
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
del nums[:]
print(nums)
# Output: []

# delete the first element and the last two elements
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
del nums[0]
del nums[-2:]
print(nums)
# Output: [2, 3, 4, 5, 6, 7]
```

### List Reversal

```python

'''
So this was a bit of cheeky and quick solution that is technically correct, BUT it skips over the fundamentals of list slicing...
'''

def reverse_list(items):
    return items[::-1] # Successfully reverses the list `items`, BUT this is only common in Python...
```

```python
'''
This is the fundamentals based solution that provides iteration, loop creation, and new list appending. Very good for teaching...

Start: len(items) - 1: Built-in just gets you the total length of the list (e.g., 1, 2, 3), NOT the proper index (e.g., 0, 1, 2)
Stop: -1: This value ensures that our range includes the index of "0", if we were to stop at "0" was would exclude the index "0" (e.g., ) 
Step: -1: This value is consistent with the more efficient [::-1] reversal slicing and ensures that the list is reversed
'''

def reverse_list(items):
    new_list = []
    for i in range(len(items) - 1, -1, -1): 
        new_list.append(items[i])
    return new_list
```

### Tuples

* **`tuples`**: data that are ordered and unchangeable. You can think of a tuple as a List with a fixed size. Tuples are created with round brackets. Often used to store very small groups (like 2 or 3 items) of data

```python
my_tuple = ("this is a tuple", 45, True)
print(my_tuple[0])
# this is a tuple
print(my_tuple[1])
# 45
print(my_tuple[2])
# True
```

* Special case if you want to store a single item inside of a tuple. You MUST use a **`,`**
```python
dog = ("Fido",)
```

#### Accessing Tuples

```python
my_tuples = [
    ("this is the first tuple in the list", 45, True),
    ("this is the second tuple in the list", 21, False)
]
print(my_tuples[0][0]) # this is the first tuple in the list
print(my_tuples[0][1]) # 45
print(my_tuples[1][0]) # this is the second tuple in the list
print(my_tuples[1][2]) # False
```

```python
# Tuple Unpacking

dog = ("Fido", 4)
dog_name, dog_age = dog
print(dog_name)
# Fido
print(dog_age)
# 4
```

### Helpful List Modifications

#### Splitting

*  **`.split()`** method in Python is called on a string and returns a list by splitting the string based on a given delimiter. If no delimiter is provided, it will split the string on whitespace.

```python
message = "hello there sam"
words = message.split()
print(words)
# Prints: ["hello", "there", "sam"]
```

#### Joining

*  **`.join()`** method is called on a delimiter (what goes between all the words in the list), and takes a list of strings as input.

```python
list_of_words = ["hello", "there", "sam"]
sentence = " ".join(list_of_words)
print(sentence)
# Prints: "hello there sam"
```

### Filter Messages

> The challenge below was on the trickier side, the goal was to use the directions provided to:
>   1. Search a list for any instance of "dang".
>   2. Append the word to a `dangs` list.
>   3. Append and join the non-dang or "good words" into a complete list.
>   4. Get the count of how often dang was used.
> The trickiest part of the challenge was the nested for-loop within a for-loop. We needed to first create a for-loop to split the original message into strings and then create another for-loop that iterates on each word from the split words so that we could search for any instance of "dang". 

```python

def filter_messages(messages):
    filtered_messages = [] # filters dang
    words_removed = [] # counts "dangs" removed from messages

    for message in messages:
        split = message.split()
        good_words = []
        dangs = []
        
        for word in split:
            if word == "dang":
                dangs.append(word)
            else:
                good_words.append(word)
        
        filtered_messages.append(" ".join(good_words)) # quick way to both join all of the good words and then append as a one-liner

        dangs_list = len(dangs)

        words_removed.append(dangs_list)
        
    return filtered_messages, words_removed

```

### List Checking and Percentages 

> A bit of an easier challenge compared to the previous one, here we are taking elements of iteration on a message and using it to compare against items in another list. 
> My initial solve was very bulky and expensive, so I trimmed down the correct item checking function to just use a `correct_ingredients` counter that ONLY increments if a player’s item is within the recipe.


```python
def check_ingredient_match(recipe, inventory):
    missing_ingredients = []
    correct_ingredients = 0 # setting correct as a counter to check if inventory actually matches recipe 
    
    for items in recipe: # simple for loop that checks if player inventory contains items in recipe
        if items in inventory:
            correct_ingredients += 1
            
        else:
            missing_ingredients.append(items)
            
    percentage = correct_ingredients / len(recipe) * 100
        
    return percentage, missing_ingredients
```

## Dictionaries `{}`

* Are used to store data values in `key` -> `value` pairs. Dictionaries are a great way to store groups of information.

```python
# Simple dictionary example...

def get_character_record(name, server, level, rank):
    record = {
        "name": name,
        "server": server,
        "level": level,
        "rank": rank,
        "id": f"{name}#{server}"
    }

    return record
```


### Setting Dictionary Values

* Example of setting dictionary values using a simple for-loop

```python
names = ["jack bronson", "jill mcarty", "john denver"]

names_dict = {}
for name in names:
    # .split() returns a list of strings
    # where each string is a single word from the original
    name_list = name.split()

    # here we update the dictionary
    names_dict[name_list[0]] = name_list[1]

print(names_dict)
# Prints: {'jack': 'bronson', 'jill': 'mcarty', 'john': 'denver'}
```

### Updating Dictionary Values

```python
full_names = ["jack bronson", "james mcarty", "jack denver"]

names_dict = {}
for full_name in full_names:
    # .split() returns a list of strings
    # where each string is a single word from the original
    names = full_name.split()
    first_name = names[0]
    last_name = names[1]
    names_dict[first_name] = last_name

print(names_dict)
# {
#   'jack': 'denver',
#   'james': 'mcarty'
# }
```

### Deleting Dictionary Values

```python
names_dict = {
    "jack": "bronson",
    "jill": "mcarty",
    "joe": "denver"
}

del names_dict["joe"]

print(names_dict)
# Prints: {'jack': 'bronson', 'jill': 'mcarty'}
```

### Checking for Existence and Incrementing

```python
cars = {
    "ford": "f150",
    "toyota": "camry"
}

print("ford" in cars)
# Prints: True

print("gmc" in cars)
# Prints: False
```

```python
def count_enemies(enemy_names):
    enemies_dict = {}
    for enemy_name in enemy_names:

        if enemy_name in enemies_dict:
            enemies_dict[enemy_name] += 1 # If the value is found in the dictionary, increment that value {'gremlin': 3}

        else:
            enemies_dict[enemy_name] = 1 # Setting the dictionary value to 1 if the value is missing {'jackal': 1, 'kobold': 1, 'gremlin': 1}
        
    return enemies_dict
```

### Iterating Over a Dictionary
* Neat way to iterate over a dictionary to identify the highest value assigned to the “key” within the dictionary. 
* Here we checked to determine if the list itself was empty, if so, the function or loop should end.

```python

def get_most_comm​on_enemy(enemies_dict):
    max_so_far = float("-inf")
    max_name = None

    if not enemies_dict:

        return max_name

    for name, value in enemies_dict.items():

        #print(f"Debug: {name}, {value}")

        if value > max_so_far:
            max_so_far = value
            max_name = name
    return max_name
```
### Chaining Dictionaries

* Used to access nested dictionaries

```python

# Similar location and identification as using `jq` in when trying to parse JSON files
outer_dictionary["outer_key"]["inner_key"]["inner_inner_key"]
```

### Merge Dictionaries

* This took me quite some time to solve as I was getting hung up on the process of extracting the key-value pairs from a dictionary and then placing them into a new dictionary.

```python

# This is my initial and more verbose solution to iterating over two dictionaries and merging them...

def merge(dict1, dict2):
    merged_1 = {}
    merged_2 = {}

    for guild1, value in dict1.items():
        #print(f"Debug: {guild1} {value}") 
        merged_1.update({guild1: value})
        #print(merged_1)

    for guild2, value in dict2.items():
        merged_2.update({guild2: value})
        #print(merged_2)

    merged_3 = merged_1 | merged_2
    #print(merged_3)

    return merged_3
```

#### Creating Dictionary via For-Loop

* As you can see, it's verbose and duplicates the merging process...

```python
# This is the refactored solution that uses only a single empty dictionary and merges...

def merge(dict1, dict2):
    merged_dict = {}

    for key in dict1:
        merged_dict[key] = dict1[key] # Pythonic way to create dictionaries via for-loops...

    for key in dict2:
        merged_dict[key] = dict2[key]

    return merged_dict
```

* `merged_dict[key] = dict1[key]`: This was missing piece for how to iteratively move through the dictionary and create key-value pairs using a for-loop.
    * `merged_dict[key]`: Takes the key name (like "Frodo") from dict1.
    * `dict1[key]`: Retrieves the corresponding value (like 56) using `dict1[key]`

## Sets

* Essentially like Lists, but they are **unordered** and they **guarantee uniqueness**. Only ONE of each value can be in a set

```python
fruits = {"apple", "banana", "grape"}
print(type(fruits))
# Prints: <class 'set'>

print(fruits)
# Prints: {'banana', 'grape', 'apple'}
```

### Add Values

* `.add()`: used to **add** items to the set.

> [!NOTE]
> No error will be raised if you add an item already in the set, and the set will remain unchanged.

```python
fruits = {"apple", "banana", "grape"}
fruits.add("pear")
print(fruits)
# Prints: {'pear', 'banana', 'grape', 'apple'}
```

### An Empty Set

* Because the empty bracket `{}` syntax creates an empty dictionary, to create an empty set, you need to use the `set()` function

```python
fruits = set() # This assigns the variable as a set.
fruits.add("pear")
print(fruits)
# Prints: {'pear'}
```

#### Set Iteration

```python
fruits = {"apple", "banana", "grape"}
for fruit in fruits:
    print(fruit)
    # Prints:
    # banana
    # grape
    # apple

# NOTE: Sets are unordered, so the order of iteration is not guaranteed
```

### Converting a List > Set > List

```python

'''
A really neat and easy way to convert a list into a set and back into a list again using nested parentheses...

list(): converts an chars into a list
set(): converts chars into a set. 
'''

def remove_duplicates(spells):
    return list(set(spells))
```

### Iterating Using Sets

* Here we are iterating over each of the characters inside of `text` to identify list of vowels both upper and lower case. 

```python
    new_set = {"a", "A", "e", "E", "i", "I", "o", "O", "u", "U"} # Dictionary to store the unique values
    counter = 0
    vowels = set()
    
    for char in text:
        if char in new_set:
            counter += 1
            vowels.add(char)

    return counter, vowels
```

### Set Subtraction

* You can subtract one set from another. It **removes all the values in the second set from the first set**.

```python
set1 = {"apple", "banana", "grape"}
set2 = {"apple", "banana"}
set3 = set1 - set2

print(set3)
# Prints: {'grape'}
```

```python
# Quick way to subtract ids from one another...

def find_missing_ids(first_ids, second_ids):
    return (set(first_ids) - set(second_ids))
```

## Dictionary + Set Practice

* I solved this puzzle in a bit of an unconventional and a bit inefficient way if I'm being honest. Below is my initial solve...
* The goal was to return a list of dictionaries each with specific outputs (e.g., unique terms, no duplicates, etc.)

```python
def analyze_tags(tags_a, tags_b):
    all = tags_a + tags_b # Combined List
    set_a = set(tags_a)
    set_b = set(tags_b)
    
    all_tags = {} # Initializing an empty dictionary
    all_unique = set(all)
    all_tags["all_tags"] = all_unique # Creating the dictionary following key-value naming conventions
    
    shared_tags = {}
    shared = set(tags_a) & set(tags_b)
    shared_tags["shared_tags"] = shared
    
    unique_to_a = {}
    unique_set_a = set_a - set_b
    unique_to_a["unique_to_a"] = unique_set_a
    
    unique_to_b = {}
    unique_set_b = set_b - set_a
    unique_to_b["unique_to_b"] = unique_set_b

    merged = all_tags | shared_tags | unique_to_a | unique_to_b # Merging all of the dictionaries
    
    return merged # Returning the merged dictionary
```

* Below is the more concise and Pythonic way to return dictionaries...
* Overall, it is much cleaner and utilizes the native `set` features like `interection`, `difference`, and `union`

```python
def analyze_tags(tags_a, tags_b):
    set_a = set(tags_a)
    set_b = set(tags_b)

    all_tags = set_a.union(set_b)
    shared_tags = set_a.intersection(set_b)
    unique_to_a = set_a.difference(set_b)
    unique_to_b = set_b.difference(set_a)

    # Proper way to create and return dictionaries that is more intuitive...
    return {
        "all_tags": all_tags, # Key = "all_tags" and Value = set_a.union(set_b)
        "shared_tags": shared_tags,
        "unique_to_a": unique_to_a,
        "unique_to_b": unique_to_b,
    }
```

# Python - Object-Oriented Programming (OOP)

* **[Object-Oriented Programming](https://en.wikipedia.org/wiki/Object-oriented_programming)**: Programming paradigm based on objects  (software entities that encapsulate data and function(s)). An OOP computer program consists of objects that interact with objects.

## Clean Code

* The sole purpose of OOP is to simply write human-readable code that is elegant and easy to maintain and understand for HUMANS. 

> [!NOTE]
> This also plays into the information security POV... Code that is lean and easy to understand is, easier to update, and easier to secure throughout the life of a project. New developers are less likely and potentially unable to secure and update code that is difficult to understand...

### Don't Repeat Yourself (DRY)

* "Rule of thumb" for writing maintainable code is **"Don't Repeat Yourself" (DRY)**. It means that, when possible, you should avoid writing the same code in multiple places because:
  * A single update will need to be repeated in multiple places.
  * If you forget it in one place, you'll have a bug
  * It's more work to write it over and over again

```python

'''
A simple example of cleaner code where we use a helper function `get_solider_dps` to calculate a soldier's dps that is used twice inside of the `fight_soldiers` function...
'''

def get_soldier_dps(soldier):
    return soldier["damage"] * soldier["attacks_per_second"]

def fight_soldiers(soldier_one, soldier_two):

    soldier_one_dps = get_soldier_dps(soldier_one)
    soldier_two_dps = get_soldier_dps(soldier_two)
    
    if soldier_one_dps > soldier_two_dps:
        return "soldier 1 wins"
    if soldier_two_dps > soldier_one_dps:
        return "soldier 2 wins"
    return "both soldiers die"
```

## Classes

* A `class` is a new custom type similar to dictionaries, but more customizable.
* `classes` are used to define the properties and behavior of a category of things. E.g. A "Car" class might dictate that all cars be defined by their make, model, year, and mileage.

```python 
# Defines a new class called "Soldier"
# with three properties: health, armor, damage
class Soldier:
    health = 5
    armor = 3
    damage = 2
```

## Object (Instance)

* An `object` is an **instance**, the "specifics of" OR "case of" that `class`.
* But you can't provide specifics about a particular car (for example, that 1978 Chevy Impala with 205,000 miles on it that your uncle Mickey drives) until you create an `instance` of a Car. 
* It's the `instance` that captures the detailed information about one particular `class`.

### Attributes
* An `attribute` (or instance variable) belongs to each object. They are not new objects or instances of the class; **they are data stored on the instances**.

```python
wall1 = Wall() # Class

wall1.armor = 10 # Object/instance of Wall() + attribute of object (10)

wall1.fortify() # Method
```
* `wall1 = Wall()`: Class
* `wall1.armor`: Object/instance of `Wall()`
* `.armor = 10`: Attribute of object
* `wall1.fortify()`: Method

## Methods 

* A `method` is just a function that's tied directly to a `class` and has access to its properties.

```python
class Soldier:
    health = 5

    # This is a method that reduces the
    # health of the soldier
    def take_damage(self, damage):
        self.health -= damage

soldier_one = Soldier()
soldier_one.take_damage(2)
print(soldier_one.health)
# prints "3"

soldier_two = Soldier()
soldier_two.take_damage(1)
print(soldier_two.health)
# prints "4"
```

### Self

* `self` is a strong convention in Python—everyone expects to see it, and tools/docs assume it.

```python
my_object.my_method() # General way to use the method tied to the class...
```

```python
class Wall:
    armor = 10
    height = 5

    def fortify(self):
        self.armor *= 2
```

```python
class Soldier:
    health = 100

    def take_damage(self, damage, multiplier):
        # "self" is dalinar in the first example
        #
        damage = damage * multiplier
        self.health -= damage

dalinar = Soldier()
# "damage" and "multiplier" are passed explicitly as arguments
# 20 and 2, respectively
# "dalinar" is passed implicitly as the first argument, "self"
dalinar.take_damage(20, 2)
print(dalinar.health)
# 60

adolin = Soldier()
# Again, "adolin" is passed implicitly as the first argument, "self"
# "damage" and "multiplier" are passed explicitly as arguments
adolin.take_damage(10, 3)
print(adolin.health)
# 70
```

## Constructors

* Are a specific method on a class called `__init__` that is called automatically when you create a new instance of a class. 
* `constructors` make the objects’ state (their attributes) configurable. The methods then use that state.

```python
class Soldier: # Class
    def __init__(self, name, armor, num_weapons): # Constructor
        self.name = name # Instance attributes (or properties)
        self.armor = armor
        self.num_weapons = num_weapons

soldier_one = Soldier("Legolas", 2, 10) # instance of the class Soldier
print(soldier_one.name)
# prints "Legolas"
print(soldier_one.armor)
# prints "2"
print(soldier_one.num_weapons)
# prints "10"

soldier_two = Soldier("Gimli", 5, 1) # another instance of the class Soldier
print(soldier_two.name)
# prints "Gimli"
print(soldier_two.armor)
# prints "5"
print(soldier_two.num_weapons)
# prints "1"
```

### Constructor Practice

* For me, the difficulty comes from getting the correct syntax when calling objects and methods within the `raise Exception` blocks.

```python
'''
NOTE: be sure to remember that when using constructors, the instance attributes shared with all of the methods contained witin the class. 

The arguments inside of each of the methods all have the associated ".name, .health., .num_arrows"
'''
class Archer:
    def __init__(self, name, health, num_arrows):
        self.name = name # Instance attributes
        self.health = health
        self.num_arrows = num_arrows

    def take_hit(self):
        self.health -= 1

        if self.health <= 0: 
            raise Exception(f"{self.name} is dead")
            
    def shoot(self, target):
        if self.num_arrows == 0:
            raise Exception(f"{self.name} can't shoot")
            self.num_arrows -= 1

        print(f"{self.name} shoots {target.name}")
        self.num_arrows -= 1
        target.take_hit() # Here we need to initiate the method by following the object-method syntax
```

### Class Variables vs. Instance Variables

#### Instance Variables

* Instance variables vary from object to object and are declared in the constructor, **more common**

```python
class Wall:
    def __init__(self):
        self.height = 10 # instance variable (per object)

south_wall = Wall()
south_wall.height = 20 # only updates this instance of a wall
print(south_wall.height)
# prints "20"

north_wall = Wall()
print(north_wall.height)
# prints "10"
```

#### Class Variables

* Class variables are shared between instances of the same class and are declared at the top level of a class definition, **less common**.
* Like global variables and should be used with caution!

```python
class Wall:
    height = 10 # class variable (shared across all instances)

south_wall = Wall()
print(south_wall.height)
# prints "10"

Wall.height = 20 # updates all instances of a Wall

print(south_wall.height)
# prints "20"
```

### Tying it All Together

* Very conceptually difficult lesson, the fundamentals of lists, loops, and conditionals are all there, but OOP syntax to access the specific instances from within methods from within classes gets a bit confusing. 
* See examples below for more clarity:

```python
class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author

class Library:
    def __init__(self, name):
        self.name = name
        self.books = [] # .books member to empty list

    def add_book(self, book):
        self.books.append(book)
        #debug = len(self.books)
        #print(f"Debug: {debug}")

    def remove_book(self, book):
        new_books = []
        for lib_book in self.books:
            if lib_book.title != book.title or lib_book.author != book.author:
                new_books.append(lib_book)

            #debug = len(new_books)
            #print(f"Debug: {debug}")

        self.books = new_books

    def search_books(self, search_string):
        results = []
        for book in self.books:
            if search_string.lower() in book.title.lower() or search_string.lower() in book.author.lower():
                results.append(book)
        return results
```

#### Classes Practice

> [!NOTE]
> The following examples are specific patterns that are commonly used for separate classes to call one another. The syntax and naming convention was a bit tricky so I wanted to provide some more examples for how a `class` can be referenced between a `method`. 

##### Pattern 1: Caller creates Book



```python
class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author

class Library:
    def __init__(self, name):
        self.name = name
        self.books = []

'''
In OOP the "Pythonic way" to reference another class is to simply lower the class name (e.g., Book -> book) when initialized inside of a method...

This allows you to manipulate the objects inside of the "Book" class using the "book" instance.
'''
    def add_book(self, book):  # get a Book instance from the class Book above
        self.books.append(book)

```

**Pattern 1 Usage: Caller creates Book, passes it in**

* You want the caller to control how Book objects are created.
* Book might have extra setup, validations, or subclasses the caller cares about.
* Library should just store books, not decide how to build them.

```python
library = Library("Town Library")

book1 = Book("Dune", "Frank Herbert")
library.add_book(book1)  # pass a Book instance
```

##### Pattern 2:  Library constructs Book itself

```python
class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author


class Library:
    def __init__(self, name):
        self.name = name
        self.books = []

'''
The proper way to describe this is that book assigned as an instance of the Book class.
'''
    # Pattern 2 version
    def add_book(self, title, author):
        book = Book(title, author)   # Library calls the Book constructor, more explicit and not called within the add_book(self, title, author) method
        self.books.append(book)
```

**Pattern 2 Usage: Library creates Book from raw data**

* You want a simple API for the caller (just give title/author).
* Library is the main “owner” that knows how Book should be built.
* You don’t need callers to ever touch the Book class directly.

```python
library = Library("Town Library")
library.add_book("Dune", "Frank Herbert")
library.add_book("1984", "George Orwell")
```

##### Pattern 3: Mixed – allow both

```python
class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author


class Library:
    def __init__(self, name):
        self.name = name
        self.books = []

    def add_book(self, book_or_title, author=None):
        # Case 1: caller passed a Book instance
        if isinstance(book_or_title, Book):
            book = book_or_title

        # Case 2: caller passed raw data: title (and author)
        else:
            book = Book(book_or_title, author)

        self.books.append(book)
```

**Pattern 3 Usage: Library accepts either a Book or raw data**

* You want a flexible API for when:
  * You already have a Book instance
  * You only have title/author
* Internally you always normalize to a Book instance before storing.

```python
lib = Library("City Library")

# Pattern 1 style:
b = Book("Dune", "Frank Herbert")
lib.add_book(b)

# Pattern 2 style:
lib.add_book("The Hobbit", "J.R.R. Tolkien")
```

##### Pattern 4: Method that returns a Book

```python
class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author


class Library:
    def __init__(self, name):
        self.name = name

    def make_book(self, title, author):
        return Book(title, author)
```

**Pattern 4 Usage**

* Library knows how to build Books, but shouldn’t automatically store them.
* You want a factory/helper that creates books for other code to use.
* The caller decides whether/where to store the created Book

```python
library = Library("City Library")

b1 = library.make_book("Dune", "Frank Herbert") # return book
b2 = library.make_book("The Hobbit", "J.R.R. Tolkien")
```

## Encapsulation

* Basically the practice of hiding complexity inside a "black box" so that it's easier to focus on the problem at hand.

```python
# who even knows how this function works???
# I sure don't, I just call it and assume
# it calculates the acceleration correctly
acceleration = calc_acceleration(initial_speed, final_speed, time)
```
* Here we just need to know that the function `calc_acceleration` needs
  * `initial_speed`, `final_speed`, and `time` to calculate and produce `acceleration`.

### Public and Private

* By default, all properties and methods in a class are **public**. That means that you can access them with the `.` operator

```python
# Accessing Pubic Property...

wall.height = 10
print(wall.height)
# 10
```

* **Private** data members  are a way to encapsulate logic and data within a class definition. To make a property or method private just prefix it with two underscores (`__`):

```python
class Wall:
    def __init__(self, armor, magic_resistance):
        self.__armor = armor
        self.__magic_resistance = magic_resistance

    # Calculations for the public facing method performed here!

    def get_defense(self):
        return self.__armor + self.__magic_resistance

front_wall = Wall(10, 20)

# This results in an error
print(front_wall.__armor)

# This works
print(front_wall.get_defense())
# 30
```

> [!NOTE]
> **PURPOPSE OF PRIVATE MEMBERS?**
> * To abstract away any additional complexity **[black box](https://en.wikipedia.org/wiki/Black_box)** that is irrelevant to the function being called... 
> * Simply call the public `get_defense()` method (which CAN access the private property) and know that the correct value will be returned.
> * **Encapsulation is about organization, NOT security.**

#### Updating Attributes vs Calculations

* This was an easier problem to solve BUT there was a bit of a hang up due to me forgetting up update the **attribute** vs just assigning a **variable**. See example solve below: 

```python
class Wizard:
    def __init__(self, name, stamina, intelligence):
        self.name = name
        self.__stamina = stamina
        self.__intelligence = intelligence
        self.mana = self.__intelligence * 10
        self.health = self.__stamina * 100

    def get_fireballed(self, fireball_damage):
        damage = fireball_damage - self.__stamina # alt.: fireball_damage -= self.__stamina
        self.health = self.health - damage          # alt.: self.health -= fireball_damage

    def drink_mana_potion(self, potion_mana):
        potion = potion_mana + self.__intelligence  # alt.: potion_mana += self.__intelligence
        self.mana = self.mana + potion              # alt.: self.mana += potion_mana
```

### Encapsulation Practice

* Another puzzle that stumped me a bit...
* Referencing a `method` within a `method` is straight forward you just have to use the variable within the method (e.g., `target.get_fireballed`)

```python
class Wizard:
    def __init__(self, name, stamina, intelligence):
        self.name = name
        self.__stamina = stamina
        self.__intelligence = intelligence
        self.mana = self.__intelligence * 10
        self.health = self.__stamina * 100

    def cast_fireball(self, target, fireball_cost, fireball_damage):
        if fireball_cost > self.mana:
            raise Exception(f"{self.name} cannot cast fireball")

        elif self.mana >= fireball_cost:
            self.mana -= fireball_cost
            target.get_fireballed(fireball_damage) # NOTE: this the correct way to use the variable "target" and set it to the method "get_fireballed".
            
    def is_alive(self):
        return self.health > 0 # Nice way to include a True or False statement without having to specify it.

    def get_fireballed(self, fireball_damage):
        fireball_damage -= self.__stamina
        self.health -= fireball_damage

    def drink_mana_potion(self, potion_mana):
        potion_mana += self.__intelligence
        self.mana += potion_mana
```

### Encapsulation Practice II 

* Another example use of encapsulation, this was a bit easier (probably due to the psuedo-code that we were provided). Overall, I feel like it was a nice solve.

> [!NOTE]
> Normally, I like the use of nested `if`, `elif`, and `else` statments but in this example the code is "flatter" and cleaner due to the use of errors we have inserted.
>
> If a branch ends the function (`return`, `raise`, `break`, etc.), you usually don’t need an `else` after it.
>
> Use `elif/else` when you’re truly choosing between **alternative paths** that all continue execution.

```python
class BankAccount:
    def __init__(self, account_number, initial_balance):
        self.__account_number = account_number
        self.__balance = initial_balance

    def get_account_number(self):
        return self.__account_number

    def get_balance(self):
        return self.__balance

    def deposit(self, amount):
        if amount <= 0:
            raise ValueError("cannot deposit zero or negative funds")
        self.__balance += amount

    def withdraw(self, amount):
        if amount <= 0:
            raise ValueError("cannot withdraw zero or negative funds")

        if self.__balance < amount:
            raise ValueError("insufficient funds")
        self.__balance -= amount
```

## Abstraction vs Encapsulation

> `abstraction` = focuses on exposing essential features while hiding complexity (**THINK** importing libraries in Python like `numpy`, `pandas`, `scipy`, etc.) 
> 
> `encapsulation` = focuses on bundling data with methods and restricting direct access to implementation details (**THINK** specific methods and classes that you use when utilizing imported libraries.)
>
> Abstraction is more about reducing complexity, encapsulation is more about maintaining the integrity of system internals.

**Encapsulation:** is about hiding internal state. It focuses on **tucking away the implementation details (private)**. It makes is easy to do important items by taking away the complexity under the hood (e.g., driving a car)

```python
# Encapsulation Example: Making a HTTP GET request
request.get('https://api.github.com/foo-bar/user/auth')
```
* The underlying process of the TCP handshake with the GitHub server is removed and the content of the packets that are sent are packaged into `request.get` which **"encapsulates"** the complexity.

**Abstraction:**  is about creating a *simple* interface for complex behavior. It focuses on what's exposed (public) with an emphasis on a **clean developer interface** when the call our `function`, `method`, or `class`

```python
# Abstraction Example: The specific syntax behind the request.get(...) tool

# Option 1:
request.get(url)

# Option 2: 
request.fetch(url, headers)
```

### Practice - Abstraction and Encapsulation

* A nice example of abstraction adn encapsulation in a simple example

```python
class Human:
    def sprint_right(self):
        self.__raise_if_cannot_sprint()
            
        self.__use_sprint_stamina()
        self.move_right()
        self.move_right()

    def sprint_left(self):
        self.__raise_if_cannot_sprint()

        self.__use_sprint_stamina()
        self.move_left()
        self.move_left()

    def sprint_up(self):
        self.__raise_if_cannot_sprint()

        self.__use_sprint_stamina()
        self.move_up()
        self.move_up()

    def sprint_down(self):
        if self.__stamina <= 0:
            self.__raise_if_cannot_sprint()

        if self.__stamina > 0:
            self.__use_sprint_stamina()
            self.move_down()
            self.move_down()

    def __raise_if_cannot_sprint(self):
        if self.__stamina <= 0:
            raise Exception("not enough stamina to sprint")

    def __use_sprint_stamina(self):
        self.__stamina -= 1
```

### Deck of Cards 

* This was a diffcult puzzle to solve, I was able to get ~70% solved but got stuck at the `create_deck()` for-loop logic. 
    * **Outer Loop:** Hits the first suit (e.g., Hearts) and initiates the inner loop.
        * **Inner Loop:** Iterates through the entire list of ranks, once it finishes, exits and iterates through outer loop.

```python
import random

class DeckOfCards:
    SUITS = ["Hearts", "Diamonds", "Clubs", "Spades"]
    RANKS = [
        "Ace",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "Jack",
        "Queen",
        "King",
    ]

    def __init__(self):
        self.__cards = []
        self.create_deck()
        #print(f"Debug: {self.__cards}")

    def create_deck(self):
        for suit in self.SUITS: # Iteration over each of the suits
            #print(f"Debug SUIT: {suit}")
            
            for rank in self.RANKS: # Iteration over each of the ranks
                #print(f"Debug RANK: {rank}")
                self.__cards.append((rank, suit))

    def shuffle_deck(self):
        random.shuffle(self.__cards)

    def deal_card(self):

        if self.__cards: # Boolean statement to determine if the list filled (True) or empty (False)
            return self.__cards.pop()
        else:
            return None
```

## Inheritance