# General Notes

## Object-Oriented Programming (OOP)

* **[Object-Oriented Programming](https://en.wikipedia.org/wiki/Object-oriented_programming)**: Programming paradigm based on objects  (software entities that encapsulate data and function(s)). An OOP computer program consists of objects that interact with objects.

`Class` = like a blueprint or a template. 

`Object` = the actual house built from that blueprint.

### Class (Blueprint/Template)

> Defines the structure of the home and give the features that all houses built from this plan will have a door color, a number of windows, and a garage. It's a new customizable type...

A `Class` defines the **structure** and **capabilities** for what we are building. It guarantees what attributes every version will have, but doesn't store specific data yet.

* **THINK** architectural blueprints for a home. It states that *every* home built from this plan must have a door, wood panels, a roof, and a garage.

#### Classes vs. Dictionaries

> An light-weight heuristic is to think of `Classes` like dictionaries (e.g., key-value pairs), but different and more flexibile as addition behavior can be assigned to it (by other `Objects`)

```python
# Defines a new class called "Soldier"
# with three properties: health, armor, damage
class Soldier:
    health = 5
    armor = 3
    damage = 2
```


### Objects (Home/Instance)

> The concrete result. You can build 10 different houses from one blueprint. One might have a red door, another a blue door. The final result or "Instance" built from the blueprint.

An `Object` is the concrete "home" created from the `Class`. While they share the same structure, they hold their own specific **State** (unique data).

* **THINK:** The actual houses on the street. One house (Object A) has a *Red* door, while the neighbor (Object B) has a *Blue* door. They are infinitely customizable **without** affecting each other.

* **Objects** combine **Data** (Attributes) AND **Behavior** (Methods/Functions). They don't just hold the information; they contain the instructions on how to use or change that information.


## Databases

- Difference between major databases, strengths, weaknesses, use-cases, etc.