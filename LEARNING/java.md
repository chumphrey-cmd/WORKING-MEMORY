# Fundamental Concepts

## Terminology

* Interprter: while the programming (normally for scripting languages); translation on the fly
* Compiler: you have to write the entire programming that you would like to run and it compiles after the programming is completed.
* Procedural (Functional) Programming - Procedure focused (Verb)
* Object-Oriented (OOP) Programming - Object focused (Noun)

## Sequence (Sequential; **DO NEXT**)
* The step-wise and iterative process where the computer executes based on a series of instructions provided. [1]

## Selection (Conditional; **DO IF**)
* Programming instructions that run IF specific conditions or parameters are met, and break down into three types: `single`, `double`, and `multiple` alternatives. [1]

```python
# Single Alternative

if (condition):
  print(f"Single Alternative")  
```

```python
# Double Alternative

if (condition):
  print(f"Double Alternative pt. 1")

else:
  print(f"Double Alternative pt. 2")
```


```python
# Multiple Alternative

if (condition):
  print(f"Multiple Alternative pt. 1")

elif (condition):
  print(f"Multiple Alternative pt. 2")

elif (condition):
  print(f"Multiple Alternative pt. 3")

else:
  print(f"End of Multiple Alternative")
```

## Iteration (Repetitive; **DO OVER**)
* Essential the FOR or WHILE loop that repeats the set of instructions until the programming reaches the last line of code or the specific conditions of the program are met. Breaks down into two types: `Repeat-For` and `Repeat-While` structures. [1]

```python
# Repeat-For (For Loop)

num_list = ["1", "2", "3", "4"]

for  x in num_list:
  print(x)
```

```python
# Repeat-While (While Loop)

num = 1

while num < 5: 
  print(num)
  i += 1
```  

## Big O Notatation


# References
1. https://www.geeksforgeeks.org/dsa/control-structures-in-programming-languages/