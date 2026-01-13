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

### Iterating Over Python Dictionary

