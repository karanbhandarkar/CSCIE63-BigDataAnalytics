# import Cluster
from cassandra.cluster import Cluster
cluster =Cluster()
## Connect to keySpace 
session =cluster.connect('mykeyspace')

### Insert Rows 
session.execute("""
insert into person (person_id ,fname,lname ,city,cellphone1,cellphone2,cellphone3) VALUES (4,'Tom','Bowmore','Boston','508-111-1111' ,'508-222-2222','508-333-3333' )""")
session.execute("""
insert into person (person_id ,fname,lname ,city,cellphone1,cellphone2,cellphone3) VALUES (5,'Smith','Duncun','Buffalo','508-767-1111' ,'508-222-4535','508-333-3333' )""")
session.execute("""
insert into person (person_id ,fname,lname ,city,cellphone1,cellphone2,cellphone3) VALUES (6,'Sam','Richard','Cleveland','508-617-1511' ,'508-222-2222','508-333-3333' )""")
print ("Insert Done")
