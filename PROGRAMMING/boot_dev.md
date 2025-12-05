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




