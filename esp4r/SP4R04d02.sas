/*SP4R04d02*/

/*Part A*/
data sp4r.hist_data;
   call streaminit(123);
   do i=1 to 1000;
      x = rand('exponential')*10;
      output;
   end;
run;

proc sgplot data=sp4r.hist_data;
   histogram x;
run;

proc sgplot data=sp4r.hist_data;
   histogram x / binwidth=1;
   density x / type=normal;
   density x / type=kernel;
run;

/*Part B*/
data sp4r.boxplot_data (drop=rep);
   call streaminit(123);
   do group=1 to 3;
      do rep=1 to 100;
         response = rand('exponential')*10;
         output;
      end;
   end;
run;

proc sgplot data=sp4r.boxplot_data;
   hbox response;
run;

proc sgplot data=sp4r.boxplot_data;
   hbox response / category=group;
run;

/*Part C*/
data sp4r.sales;
   call streaminit(123);
   do month=1 to 12;
      revenue = rand('Normal',10000,5000);
      output;
   end;
run;

proc sgplot data=sp4r.sales;
   vbar month / response=revenue;
run;

/*Part D*/
data sp4r.series_data (keep=x y1 y2);
   call streaminit(123);
   do x=1 to 30;
      beta01 = 10;
      beta11 = 1;
      y1 = beta01 + beta11*x + rand('Normal',0,5);
      beta02 = 35;
      beta12 = .5;
      y2 = beta02 + beta12*x + rand('Normal',0,5);
      output;
   end;
run;

proc sgplot data=sp4r.series_data;
   scatter x=x y=y1;
   scatter x=x y=y2;
run;

proc sgplot data=sp4r.series_data;
   series x=x y=y1;
   series x=x y=y2;
run;

proc sgplot data=sp4r.series_data;
   series x=x y=y1;
   scatter x=x y=y1;
   series x=x y=y2;
   scatter x=x y=y2;
run;

/*Part E*/
proc sgplot data=sp4r.series_data;
   reg x=x y=y1 / clm cli;
   reg x=x y=y2 / clm cli;
run;


*
In this demonstration I want to reproduce the basic R plotting capabilities 
all in sgplot. So first I'm going to generate some histogram data. I'll set 
a seed of 123. And I'm going to simulate 1,000 observations. My variable x
will be exponentially distributed with a mean of 10. So I'll just multiply 
every value by a value of 10.

And once I create that data I'm going to use PROC SGPLOT and the HISTOGRAM 
statement to create a histogram. And I'll run the first DATA and PROC step. 
So of course our distribution is skewed because we simulated from an 
exponential distribution.

Let's go ahead and create the histogram distribution again. This time as 
an option, I'm going to change the binwidth to a value of 1. And to overlay 
a density estimate I'll use the DENSITY statement and specify my variable 
x. And as options I can say type equal to normal and type equal to kernel. 
So I'm overlaying two different density estimates here. So again, I've 
combined HISTOGRAM and DENSITY statements all in a single SGPLOT procedure.

So as you can see my bins are much smaller because I changed the binwidth. 
My kernel density estimate is here in orange and my normal kernel density 
estimate is here in blue. And of course it's not normally distributed 
because the exponential distribution is skewed.

In Part B I'm going to generate some boxplot data and I'm going to drop 
the value rep. I'll set a seed, and I'm going to create another 
classification variable called group. So I go from group equals 1 to 3, 
and for each group I'll simulate 100 observations.

I'll specify a new variable called response which again will be 
exponentially distributed with a mean of 10. And first I'll go ahead 
and create a horizontal boxplot with all the data. So in this case, 
I'm ignoring the group. I'm just plotting all 300 observations as one. 
So here we have our boxplot. Of course the blue line is the median, the 
blue diamond is the mean, and we do have some outliers because it's 
exponentially distributed.

Now let's go ahead and account for the groups. In the HBOX statement, 
as an option after the forward slash, specify the keyword category and 
set that equal to our classification variable group. This is going to 
divide up the data according to the group and print three separate 
boxplots. So here we have the boxplot for group 1, group 2, and group 
3 separately, all in a single window. And of course they look similar 
because they are all generated the same way.

In Part C I'll create a data is called sales. And my index variable will 
be called month, and I'll go from 1 to 12. I'll create a new variable 
called revenue and that's going to be normally distributed with a mean 
of 10,000 and a standard deviation of 5,000. And I'll create a vertical 
bar chart using the classification variable month. And as an option I'm 
going to specify the response is equal to the revenue that I just generated.

So here on the x axis is the 12 months. The revenue is on the y axis. 
And of course this is fake data, but as you can see, it looks like our 
company did a little bit better towards the end of the year. Next I want 
to go ahead and generate simple linear regression data. I'll call this 
data set series_data.

My index variable x will be from 1 to 30, and for my first simple linear 
regression model, my intercept beta01 will be equal to 10, my slope beta11 
will be equal to 1, and my observed values y1 will be equal to my intercept 
plus my slope times my index variable x. And I'll go ahead and add in some 
random numbers, which will be normally distributed with a mean of 0 and a 
standardization of 5.

My second simple linear regression model will have an intercept of 35 and 
a slope of 0.5. And again, my observations are created the exact same way-- 
intercept plus slope times my index variable x plus some random noise.

And here I have three separate SGPLOT procedures. The first has two 
SCATTER statements. So this is equivalent to running the plot function in R 
and then using the points function. The second has two SERIES statements 
which is equivalent to using the lines function. And finally, I have two 
SERIES and two SCATTER statements in the final SGPLOT procedure. So that's 
going to plot the lines and will put the points symbols on top of the 
lines as well.

So in my first plot, I have the simple linear regression data. y1 is in 
blue, and y2 is in red. And SAS automatically separates the colors for 
you and provides the legend. And again, this was created using multiple 
SCATTER statements.

The next plot was created using multiple SERIES statements. So again, I 
have y1 and y2 separated-- y1 in blue, y2 in red. And finally, if I 
want to plot them together so I can see both the lines and the actual 
observation values, I'll use two SCATTER and two SERIES statements. 
And unfortunately in this case SAS uses the color blue for everything. 
And you'll notice as well, in the legend I actually have values for y1 
as both lines and points. Same for y2.

So by default it adds in the legend value for every statement that 
you use. In the following demonstration when I show you how to enhance 
the plot, I'll show you how to touch up the legend so you don't actually 
have two values for the same variable. And finally, if you are using 
simple linear regression data I highly recommend using the REG statement. 
Specify your x axis variable and your response y, and as options you 
can use clm and cli to request confidence limits and prediction limits.
And these will be printed right on the plot. So this is equivalent to 
using the abline function in R.

So here again in blue is y1 and in red I have y2. So the dark blue line 
of course, is the line of best fit. The shaded blue line is the 
confidence limits. And the gray lines are the prediction limits. And 
the same can be said for the values in red.
*;