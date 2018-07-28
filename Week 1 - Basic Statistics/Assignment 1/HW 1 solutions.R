
## Problem 1 ##
## Doctor or altered coin, where probability of getting heads is p=0.3, p=0.5, p=0.8. Plot on three separate graphs 
## the binomial distribution for p=0.3, p=0.5 and p=0.8 for the total number of trials n=60 as a function of k, the number 
## of successful (heads) trials. Subsequently, place all three curves on the same graph. For each value of p, determine
## 1st Quartile, median, mean, standard deviation and 3rd Quartile. Present those values as a vertical box plot with the
## probability p on the horizontal axis. 

k<-0:60
## k, the number of heads, is between 0 and 60
y3=dbinom(0:60, size=60, prob=0.3)
## binomial distribution function which generates the binomial distribution
y5=dbinom(0:60, size=60, prob=0.5)
y8=dbinom(0:60, size=60, prob=0.8)


plot(k,y3,xlab="Number of Successful Trials",ylab="Binomial Distribution",main="Probability = 0.3")
plot(k,y5,xlab="Number of Successful Trials",ylab="Binomial Distribution",main="Probability = 0.5")
plot(k,y8,xlab="Number of Successful Trials",ylab="Binomial Distribution",main="Probability = 0.8")

plot(k,y3,xlab="Number of Successful Trials",ylab="Binomial Distribution",main="P=0.3(Red), P=0.5(Blue), P=0.8(Green)",col="Red")

## Add to existing plot to plot all three together with points funciton 
points(k,y5,col="Blue")
points(k,y8,col="Green")
## lines function will generate plots with curves as opposed to dots
y1=dbinom(0:60, size=60, prob=0.1)
lines(k,y1,col="Black")


## Boxplots ##
## One good way of doing this is to find stats for each distribution:

#1st Quartile, 3rd Quartile, median, mean, standard deviation for p=0.3
p3q1=quantile(y3)[2]
p3q3=quantile(y3)[4]
p3mean=mean(y3)
p3median=median(y3)
p3sd=sd(y3) ##standard deviation
p3values <- c(p3q1,p3q3,p3mean,p3median,p3sd,0.3)
## feel free to type quantile(y3) in console to see all quantile

#1st Quartile, 3rd Quartile, median, mean, standard deviation for p=0.5
p5q1=quantile(y5)[2]
p5q3=quantile(y5)[4]
p5mean=mean(y5)
p5median=median(y5)
p5sd=sd(y5)
p5values <- c(p5q1,p5q3,p5mean,p5median,p5sd,0.5)

#1st Quartile, 3rd Quartile, median, mean, standard deviation for p=0.8
p8q1=quantile(y8)[2]
p8q3=quantile(y8)[4]
p8mean=mean(y8)
p8median=median(y8)
p8sd=sd(y8)
p8values <- c(p8q1,p8q3,p8mean,p8median,p8sd,0.8)
help(quantile)
p8q = quantile(y8)
p8q

## 3 vectors combined in a matrix -- c means concatanate/combine
m<-matrix(c(p3values,p5values,p8values),nrow=3, byrow=TRUE)
m
## help(boxplot) help(bxp)    # boxplot can take a distribution or summaries. Here using summaries, or 
## already calculated stats
boxplot(m[,c(1:5)]~m[,c(6)],xlab="Probability",ylab='Q1, Median, Mean, SD, Q3',horizontal=FALSE)
## first to fifth column, using the sixt column as a factor. In faithful problem factor was short or long



## Alternate way of doing this problem: 

old.par = par(mfrow=c(2,2)) ## Here we want to create 4 graphs in one plot (2 by 2)

#p=0.3 probability that head comes out
k= 0:60
binomdist.3 = dbinom(k, size=60, prob=0.3, log = FALSE) ##binomdist.3 is the name of the variable
## dbinom is the binomial distribution function
## log is in there because the probabilites are given as numbers not as logarithms of those numbers
plot(k, binomdist.3, xlab="num of successful trials (heads comes out), k", main = "plot for p=0.3")

#p=0.5 probability that head comes out
binomdist.5 = dbinom(k, size=60, prob=0.5, log = FALSE)
plot(k, binomdist.5, xlab="num of successful trials (heads), k", main = "plot for p=0.5")

#p=0.8 probability that head comes out
binomdist.8 = dbinom(k, size=60, prob=0.8, log = FALSE)
plot(k, binomdist.8, xlab="num of successful trials (heads), k", main = "plot for p=0.8")

#plot together
plot(k, binomdist.3, type="l", xlab="num of successful trials (heads), k", ylab="binomdist", ylim=range(binomdist.8))
lines(k, binomdist.5, col="green", xlab="num of successful trials (heads), k")
lines(k, binomdist.8, col="red", xlab="num of successful trials (heads), k")


##Box plots (though the actual plots are not as clear as in the first way of doing this)

old.par = par(mfrow = c(2,2))
combined = rbind(cbind(binomdist.3, c(0.3)), cbind(binomdist.5, c(0.5)), cbind(binomdist.8, c(0.8)))
## rbind means organize data row by row
## cbind means organize data column by column
## taking binomial distribution and adding the probability 0.3, 0.5, 0.8
## rbind is applied to 3 vectors to create a matrix
boxplot(combined[,1]~combined[,2], xlab="probability that head comes out")
## combined [,1] selects the first column that contains distributions for 0.3, 0.5, 0.8
## ~ menas break down those distibutions by factors contained in the second column 
## this box plot is a bit squished compared to the last one we saw, and thus hard to read

#stats for p=0.3
stats = summary(binomdist.3)
stats['sd'] = c(sd(binomdist.3))
stats
##       Min.    1st Qu.     Median       Mean    3rd Qu.       Max. 
## 0.00000000 0.00000000 0.00000836 0.01639000 0.00961300 0.11180000 
##         sd 
## 0.03239755
#stats for p=0.5
stats = summary(binomdist.5)
stats['sd'] = c(sd(binomdist.5))
stats
##       Min.    1st Qu.     Median       Mean    3rd Qu.       Max. 
## 0.00000000 0.00000000 0.00004614 0.01639000 0.01228000 0.10260000 
##         sd 
## 0.03062992
#stats for p=0.8
stats = summary(binomdist.8)
stats['sd'] = c(sd(binomdist.8))
stats
##       Min.    1st Qu.     Median       Mean    3rd Qu.       Max. 
## 0.00000000 0.00000000 0.00000016 0.01639000 0.00584300 0.12780000 
##         sd 
## 0.03527981

# For an alternate way of analyzing binomial distribution, when the number of successful trials
# is placed on y-axis please see solution of John Glieber

##Problem 2 ##
## Finish the plot of the correlation between waiting times and durations of Old Faithful data. 
## Recreate the scatter plot of waiting vs. duration times. 
## As mentioned in class, the best linear assesment in the sense of the least squares fit of a relaitionship between two
## or many variables can be achieved with R function lm() which stands for 'linear model'
## The first argument of lm() is called formula
## The second argument of lm() function is called data, and will take value faithful in our problem

data(faithful)
plot(faithful$eruptions, faithful$waiting, xlab="Eruption duration", ylab="Time waited")
model = lm(waiting ~ eruptions, data=faithful)
print(model)
## 
## Call:
## lm(formula = waiting ~ eruptions, data = faithful)
## 
## Coefficients:
## (Intercept)    eruptions  
##       33.47        10.73
abline(reg=model,lwd=2, col="blue") ##abline adds one or more straight lines through current plot
## abline takes as arguments reg coming from regression, since most linear models are actually regressions
# lwd is line width -- to see the effect of lwd you could use vlaue of 10 instead of 2.





##Problem 3 ##
## Calculate the covariance matrix of the faithful data. 
## Determine the eigenvalues and eigenvectors of that matrix.
## Demonstrate that the two eigenvectors are mutually orthogonal
## Demonstrate that the eigenvector with the larger eigenvalue is parallel wiht line discovered by lm() function in previous problem

#covariance between eruptions and waiting
cov.mat = cov(faithful)
eigen(cov.mat)
## $values
## [1] 185.8818239   0.2442167
## 
## $vectors
##           [,1]       [,2]
## [1,] 0.0755118 -0.9971449
## [2,] 0.9971449  0.0755118
## the columns are eigen vectors
#demonstrate orthogonality
crossprod(eigen(cov.mat)$vectors)
##      [,1] [,2]
## [1,]    1    0
## [2,]    0    1
#crossproduct gives 1 along the diagonal, demonstrating orthogonality
#find slope of eigenvector
ev.slope = eigen(cov.mat)$vectors[2,1]/eigen(cov.mat)$vectors[1,1]
#compare slopes of eigenvector and linear model best fit line
## Here we are dividing  [2,1] by [1,1] to get 13.20515, which is the slope of that vector
ev.slope 
## [1] 13.20515
print(model) 
## 
## Call:
## lm(formula = waiting ~ eruptions, data = faithful)
## 
## Coefficients:
## (Intercept)    eruptions  
##       33.47        10.73
#slope of LM ~= 10 and slope of eigen vector ~= 13. they are not equal, but close
#visual comparison of slope of the eigenvector and the OLS best fit line
#blue line is LM line, red line is the denormalized eigenvector
plot(faithful$eruptions, faithful$waiting, xlab="Eruption duration", ylab="Time waited")
abline(reg=model,lwd=2, col="blue")
lines(faithful$eruptions, (ev.slope*(faithful$eruptions-mean(faithful$eruptions))) + mean(faithful$waiting), col="red") 
# denormalizes the eigenvector back to orginal range of x and y
## this is really smart math. The function is calculated as erruptins minus 
## the mean fo erruptions multiplied b the slope and add the mean of waiting times
#slopes of LM best fit line and eigenvector are close but not totally equal, probably due to the way each are derived. 
##The LM best fit minimizes the error in the direction of y (minimizes the Yhat - Y) where as the reconstructed eigenvector minimizes 
## the error in the direction orthogonal to it. 
# The above analysis is courtesy of April Lim



## Problem 4 ##
## Eruptions clearly fall into two categories, short and long
## Use teh boxplot() funciton to show basic statistical measures for waiting and duration

oldpar=par(mfrow=c(1,2)) ## want to have two diagrams, one for eruption durations one for waiting times
faithful["type"] = ifelse(faithful$eruptions<=3.1,"short","long")
## we add a column with type of eruption -- short or long. That column is a factor or categorical variable
#boxplot(faithful$waiting)
## to see what kind of sturcture faithful is, type str(faithful) -- you'll see that it's a data frame 
## with named columns and rows
boxplot(waiting ~ type, data=faithful, main = "waiting times", sub="grouped by long and short eruption times")
## waiting ~ type means break down the values by factor type -- short or long
## data = faithful means take data from the data frame faithful
#boxplot(faithful$eruptions, main = "eruption times")
## now, boxplot for erruptions:
boxplot(eruptions~type, data=faithful, main = "eruption times", sub="grouped by long and short eruption times")



## Problem 5 ##
## Create a matrix with 40 columns and 100 rows. Populate each columns with a random variable 
## of the unifrom distribution type. Make those distributions symmetric around 0.
## Present two distributions contained in any two randomly selected columns of your matrix on two separate plots.

mm <- matrix(runif(100*40, min=-1, max=1), nrow=100, ncol=40)
## runif is run 400 times between 1 and -1
## those values are placed in 100 rows and 40 columns
## this means all is run at once
par(mfrow=c(1,2))
## partition graph
hist(mm[,1], xlim=c(-2,2), col="black")
hist(mm[,2], xlim=c(-2,2), col="black")
hist(mm[,7], xlim=c(-2,2), col="black")
hist(mm[,5], xlim=c(-2,2), col="black")

#From plots the distibution does seem like a unifrom distribution centered around zero. The variance in shape of 
## its probability density function seem to be fairly random and small. 
## To get something that resembles a normal distribution, lets try replacing 100 with 10,000
## Keep in mind that these are random generators, so the histogram looks different every time
mm2 <- matrix(runif(10000*2, min=-1, max=1), nrow=10000, ncol=2)
hist(mm2[,1], xlim=c(-2,2), col="black")
hist(mm2[,2], col="black")



## Problem 6 ##
## Start with matrix from problem 5. Add yet another columns to that matrix and populate that column with the sum 
## of the original 40 columns. We actually created a new vector total and injected the sum into that vector.
## Create a histogram of values in the new columns showing that the distribution starts to resemble the Gaussian curve.
# The elegant way of solving this problem is courtesy of Barbara Bryant
par(mfrow = c(1,2))

## Let's go back to our matrix from Problem 5
mm <- matrix(runif(100*40, min=-1, max=1), nrow=100, ncol=40)
# Assume variance of the generated data is n=40 times variance of uniform dist (1/3)
## Variance of uniform distribution is the integral between -1 and 1 of (0.5)*x^2 dx
## This integral will give you 1/3 for the variance of the uniform distrbution with range 
# of values between -1 and 1. 
## If you sum 40 such distributions, the variance of the resulting distribution is 40 * 1/3
total <- apply(mm, 1, sum)
## the 1 means sum on the first dimension of the matrix -- sum on columns. 
myhist <- hist(total, density = 15, prob = TRUE, col="blue", xlim=c(-15, 15))
## prob = TRUE gives us a histogram that represents probability density and not frequencies 
## Integral under such histogram sums to 1 
xx <- seq(-15, 15, by=.2)
## this gives us the x-coordinates for the curve we want to draw
gxx <- dnorm(xx, mean = 0, sd=sqrt(40*(1/3.0)))
## This calculates the normal distribution 
lines(xx, gxx, col="red", lwd=2)

## The normal distribution is normalized -- the area under the curve is 1, i.e. the integral is 1

# Alternative way: extract standard deviation from generated data  
total <- apply(mm, 1, sum)
myhist <- hist(total, density = 15, prob = TRUE, col="red", xlim=c(-15, 15))
xx <- seq(-15, 15, by=.2)
m = mean(total)
std = sd(total)
## standard deviation of random variable total
##
gxx <- dnorm(xx, mean=m, sd=std)
lines(xx, gxx, col="green", lwd=2) 
m
## green distribution is slightly off 0 -- the mean value does not have to be right at 0 

