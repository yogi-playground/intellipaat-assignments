# -*- coding: utf-8 -*-
"""Python Module 1: Case Study - 2.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1n2FwLxVKXgPOMHPrJdIO8IigjGMeo2V-

# Module 1: Case Study - 2

**Problem Statement:**
Consider yourself to be Sam who is a data scientist. He has been invited as a
guest lecturer at a college to take an introductory session on Python.

Tasks To Be Performed:

1. Create 1st tuple with values -> (10, 20, 30), 2nd tuple with values -> (40,
50, 60):

a. Concatenate the two tuples and store it in “t_combine”

b. Repeat the elements of “t_combine” 3 times

c. Access the 3rd element from “t_combine”

d. Access the first three elements from “t_combine”

e. Access the last three elements from “t_combine”
"""

t1=(10, 20, 30)
t2=(40, 50, 60)
t_combine=t1+t2

print(t_combine)
t_combined_repeated = t_combine * 3
print(t_combined_repeated)
print(t_combine[2])
print(t_combine[0:3])
print(t_combined_repeated[-3:3])

"""2. Create a list ‘my_list’ with these elements:

a. First element is a tuple with values 1, 2, 3

b. Second element is a tuple with values “a”, “b”, “c”

c. Third element is a tuple w
"""

my_list=[(1,2,3),("a","b","c"),(True,False)]
my_list

"""3. Append a new tuple – (1, ‘a’, True) to ‘my_list’:

a. Append a new list – *“sparta”, 123+ to my_list

"""

my_list.append((1, 'a', True) )
my_list
new_list=["sparta", 123]
my_list.append(new_list)
my_list

"""4. Create a dictionary ‘fruit’ where:

a. The first key is ‘Fruit’ and the values are (“Apple”, “Banana”, “Mango”,
“Guava”)
b. The second key is ‘Cost’ and the values are (85, 54, 120, 70)
c. Extract all the keys from ‘fruit’
d. Extract all the values from ‘fruit
"""

Fruit = {"Apple": 85, "Banana": 54, "Mango": 120, "Guava": 70}
print(Fruit.keys())
print(Fruit.values())

"""5. Create a set named ‘my_set’ with values (1, 1, “a”, “a”, True, True) and
print the result
"""

my_set = set((1, 1, "a", "a", True, True))
print(my_set)