/*SP4R05d01*/

/*Part A*/
proc contents data=sp4r.ameshousing varnum;
run;

/*Part B*/
proc univariate data=sp4r.ameshousing;
   var saleprice;
   histogram saleprice / normal kernel;
   inset n mean std / position=ne;
   qqplot saleprice / normal(mu=est sigma=est);
run;


*
Going forward in this course, we're going to be using the Ames Home Sales 
Data Set, as well as a few others in addition to the Cars Data Set. The 
Ames Housing Data Set is a random sample of 300 houses sold in Ames, Iowa 
during 2006 to 2010. In this demonstration, I want to look at the Ames 
Housing Data Set and run the UNIVARIATE procedure to see the default output. 
In Part A, I'm running PROC CONTENTS, which we've already seen on the 
ameshousing data set. And I'm using the VARNUM option to print variables 
in order that they appear in the data set. So let's look at this data set 
that we'll be working with going forward in this course.

So here we have 300 observations, and there are 32 variables. And you'll
notice, if you look through the variable names, they pertain to details 
of the homes sold. So for example, the House Style, the Overall Quality, 
the Year it was Built, the Heating Quality. Does it have Central Air? The 
Ground Living area and Square Feet and so on. So these are the types of 
variables you will use to create a model in Chapter 6, when we get into 
inferential modeling. And most likely will use the sale price variable as 
our response.

So how much did the homes sell for? Because we're going to be using the 
sale price variable going forward, let's analyze it in the UNIVARIATE 
procedure. So I'll use the saleprice variable in the VAR statement. And 
I'll also request a histogram with the HISTOGRAM statement. And as an 
option, I want to overlay a normal and kernel density estimate. And in the 
histogram, I'm going to use the INSET statement and print the number of 
observations, mean, and standard deviation on the graphic. And as an option,
I'm going to give the position equal to NE for northeast.

And finally, I'll use the QQPLOT statement, and as an option I want to 
compare it to a normal distribution. And I want to estimate the mean mu 
and also the standard deviation sigma. You could also put values in for 
EST if you wanted. But most likely you'll just want to use the estimated 
distribution.

So first we get the Moments table. Again we have 300 observations. The Mean 
sale price is about $137,000. The Standard Deviation is about $37,600. And 
lots of other information that you can look at. The Basic Statistical 
Measures table-- Mean, Median, Mode, Standard Deviation, Variance, Range,
Interquartile Range. We get the hypothesis test-- the test for location 
table. It says Mu0=0, meaning is the variable sale price equal to 0? Well, 
of course not, no one is going to sell their home for nothing. And you 
can change Mu0 in the PROC UNIVARIATE statement with the Mu0 option, if 
you'd like to use the hypothesis test.

We get the pre-defined Quantiles, as well as the Extreme Observations. 
Again the five lowest and five highest observations in our data set. So 
for this data set, the lowest home price was $35,000 and the highest was 
$290,000. And remember I use the HISTOGRAM statement to generate a 
histogram of SalePrice, which appears to be normally distributed, based 
on this normal and kernel density estimate. And I also remember, printed
with the INSET statement, the Number observations, Mean, and Standard 
Deviation in the Northeast or upper right corner.

Because I requested the normal density overlay on the histogram, I also 
get the following output. I get the parameters for the normal distribution, 
again the same Mean and Standard Deviation as before. And I also get 
Goodness-of-Fit test for that normal distribution as well.

And finally, I get the Observed versus Estimated Quantiles table too.
Looking at the QQPLOT, we can see our data is definitely normal. With 
maybe a slight tail on the upper right. But here I added in the line 
representing the normal quantiles to do a comparison between the observed
data and the estimated distribution.
*;