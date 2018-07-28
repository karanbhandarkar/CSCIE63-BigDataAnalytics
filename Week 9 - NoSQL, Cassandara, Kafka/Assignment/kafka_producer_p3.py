from kafka import KafkaProducer
import time
import sys

if len(sys.argv) < 3:
        print ("Insufficient arguments entered")
        sys.exit()

# producer = KafkaProducer(bootstrap_servers='localhost:9092')
producer = KafkaProducer(bootstrap_servers=sys.argv[1])

# topic = 'test3'
topic = sys.argv[2]

print("Running script on:")
print("Server: ",sys.argv[1])
print("Topic: ",sys.argv[2])

f = open("orders.txt","r")

lineList = []
for line in f:
	lineList.append(line)
	if (len(lineList)%999) == 0:
		for i,x in enumerate(lineList):
			producer.send(topic,lineList[i])
		time.sleep(1)
	print ("Sent batch #", len(lineList)/999)
print 'Done sending messages'
