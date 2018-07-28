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

while 1:
	try:
		line =sys.stdin.readline()
	except	KeyboardInterrupt:
		break
	if not line:
		break
	print ("sending Message",line)
	producer.send(topic,line)

print 'Done sending messages'
