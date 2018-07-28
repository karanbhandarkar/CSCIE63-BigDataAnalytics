# import Cluster
from cassandra.cluster import Cluster
cluster =Cluster()
## Connect to keySpace 
session =cluster.connect('mykeyspace')

###  Rows 

print ( " Now Doing Update")
session.execute("""
update person set city='Erie' where person_id =5
""")
upd = session.execute ("select * from person where person_id=5")[0]
print ( "First Name=",upd.fname,
	"Last Name =",upd.lname,
	"City =", upd.city)
