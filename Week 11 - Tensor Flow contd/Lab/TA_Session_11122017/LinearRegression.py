import tensorflow as tf 
import numpy as np 
import matplotlib.pyplot as plt 

#Define some constants used by the learning algorithm. There are called hyper-parameters.
learning_rate = 0.01 
training_epochs = 100 

#Set up data that we will use to find a best fit line
x_train = np.linspace(-1, 1, 100)
y_train = 2 * x_train + np.random.randn(*x_train.shape) * 0.33 

#Set up the input and output nodes as placeholders since the value will be injected by x_train and y_train.                     
X = tf.placeholder("float") 
Y = tf.placeholder("float") 

#Define the model as y = w*x
def model(X, w): 
	return tf.multiply(X, w)

#Set up the weights variable                     
w = tf.Variable(0.0, name="weights") 

#Define the cost function
y_model = model(X, w) 
cost = tf.square(Y - y_model) 
print ("cost: ", cost)


#Define the operation that will be called on each iteration of the learning algorithm
#Optimizer that implements the gradient descent algorithm -- The learning rate to use.
train_op = tf.train.GradientDescentOptimizer(learning_rate).minimize(cost) 


#Set up a session and initialize all variables                     
sess = tf.Session() 
init = tf.global_variables_initializer()
sess.run(init)


#Loop through the dataset multiple times
#Each step of updating the parameters is called an epoch
for epoch in range(training_epochs):
 for (x, y) in zip(x_train, y_train): #Loop through each item in the dataset
  sess.run(train_op, feed_dict={X: x, Y: y}) #Update the model parameter(s) to try to minimize the cost function

#Obtain the final parameter value                     
w_val = sess.run(w)

sess.close() 
plt.scatter(x_train, y_train) 
y_learned = x_train * w_val 

#matplotlib.pyplot
plt.plot(x_train, y_learned, 'r') 
plt.show()