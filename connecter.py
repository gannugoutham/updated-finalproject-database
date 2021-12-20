#!/usr/bin/env python
# coding: utf-8

# In[10]:


import datetime
import mysql.connector

cnx = mysql.connector.connect(user='root', database='computerstores')
cursor = cnx.cursor()

query = ("select * from list")

hire_start = datetime.date(1999, 1, 1)
hire_end = datetime.date(1999, 12, 31)

cursor.execute(query)

for (name) in cursor:
  print(name)

cursor.close()
cnx.close()


# In[ ]:




