/*SP4R08d01*/

/******************************************************************************************************************/
/*This program calls R from SAS/IML */
/*
/* Calling R from SAS requires an installed version of R, and a configuration setting within the SAS environment. */
/* Because you cannot modify the SAS University Edition configuration, this program will not execute successfully */
/* in SAS University Edition.     (Note this also applies to SAS EG for me)                                       */
/******************************************************************************************************************/

/*Part A*/
ods select basicmeasures histogram;
proc univariate data=sp4r.fish;
   var weight;
   histogram weight;
run;

/*Part B
proc iml;
   submit / r;
     install.packages("boot")
   endsubmit;
quit;*/

/*
NOTE: You must delete the SAS comments in the SUBMIT block.
The comments are passed to R and cause errors!
*/
/*Part C*/
proc iml;
   call ExportDataSetToR("sp4r.fish","fish");

/*Part D*/
   submit / r;
     library(boot)
	 set.seed(802)
	 numreps = 1000

      bootMean <- function(data,variable,index){
      attach(data)
      result <- mean(variable[index],na.rm=TRUE)
      detach(data)
      return(result)
      }

      results <- boot(data=fish,statistic=bootMean,
                    R=numreps,variable=Weight)

/*Part E*/
      boot.ci(results, conf=0.95, type="perc", index=1)
      plot(results)

/*Part F*/
      boots <- data.frame("boots"=results$t)
   endsubmit;

/*Part G*/
   call ImportDataSetFromR("sp4r.RData","boots");

   submit;
     proc print data=sp4r.RData (obs=10); 
     run;
   endsubmit;
quit;


*
Demo: Working with R from IML
In this demonstration, I'll show you how to write R code directly in IML,
send it out to R, do the analyses, and bring back the results to SAS. To
do so, we're going to work with the fish data set in SAS. This data set
contains 159 measurements of fish, specifically the weight of fish caught 
in a lake in Finland. We want to find the sampling distribution of the
weight of fish using the bootstrap algorithm from R. First, let's just 
look at the fish data set.

I'm going to run PROC UNIVARIATE on the variable weight, and also create a
histogram of the weight variable. And I'm only going to return the basic 
measures table and the histogram. So here, we can see the mean weight of
the 159 fish is 398, the median is considerably less at 272, indicating 
skewed data, and the histogram provides evidence of the skew as well. As
a best practice, I encourage you not to install R packages directly in 
IML. I would actually encourage you to open up your R console and submit 
the install.packages() function. When the repository page pops up from R,
it has the ability to cause an error. So just submit the install.packages() 
function directly in the R console.

Next, I'm going to go into IML and first export my data set to R. So 
I'm exporting the fish data set to an R data frame called fish. In Part
D, I'm going to start my SUBMIT block by specifying the R option after 
the forward slash. So all code below the SUBMIT statement, until the 
ENDSUBMIT statement, will be R code exactly as you'd write it in the R
console. First, I'm going to unpack the boot package in R with the library
function. I'll set a seed and I'm going to do 1,000 replications of the
bootstrap algorithm.

Next, I'm going to create the bootMean function. This is simply going
to pass in an index variable for my data set, and take the mean of those
observations, and return that result. Next, I'm going to use the boot 
function to find my bootstrap estimates of all 1,000 replications.

So my data is the fish data frame I passed to R. The statistic is the
bootMean function I've created. R equal to the number of reps is 1,000. 
And the variable I'm analyzing, of course, is the weight variable. I'll
save all that information in the results object.

Next, I'll use the boot.ci function to return confidence limits for my
bootstrap estimates. And unfortunately, in SAS Studio, you can't actually
use the plot function. You can run it, it will simply not open up anything.
But in the windowing environment interface, if you use the plot function,
it'll actually open up an R graphics window. But for now, we'll just 
ignore the plot function.

Next, I'm going to create a data frame called boots which is simply going
to be my bootstrap estimates. And notice, I'm calling the variable name 
boots in my data frame. Make sure you have the ENDSUBMIT statement. And
next, in Part G, I'm going to import the results back to SAS using the 
ImportDataSetFromR subroutine. So I'm specifying the data frame boots 
and a new SAS data set called Rdata. And recall, the data frame column 
names are going to be returned to the SAS data set as variable names.

And finally, I'll just go ahead and print 10 observations of my new data
set to make sure it was returned. And before we run this script, let's 
go back to the note. You must delete the SAS comments in the SUBMIT block. 
The comments are passed to R, and of course, R does not know how to 
interpret them and will throw an error. So anything between SUBMIT and 
ENDSUBMIT that is a comment, we need to delete.

So first, we see the results that were printed to the R console output. 
Specifically, the confidence limits for my bootstrap estimates. Here, we
see our confidence limits for the weight of fish is about 350 to 450. 
And also remember, I printed the data set I returned to SAS. So this is
10 observations of my 1,000 replications, just to make sure it returned.
*;
