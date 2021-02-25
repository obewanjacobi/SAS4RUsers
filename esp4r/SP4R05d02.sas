/*SP4R05d02*/

/*Part A*/
ods trace on;
proc univariate data=sp4r.ameshousing;
   var saleprice;
   qqplot saleprice / normal(mu=est sigma=est);
run;
ods trace off;

/*Part B*/
ods select basicmeasures qqplot;
proc univariate data=sp4r.ameshousing;
   var saleprice;
   qqplot saleprice / normal(mu=est sigma=est);
run;


*
I'm first going to run the ODS TRACE ON statement to print all the table
and graphic names to my log. Then I'm going to run PROC UNIVARIATE and 
display all the default output. For this UNIVARIATE procedure, I'm going
to analyze the sale price variable again and the VAR statement. And I'm 
also going to generate a Q-Q plot of sale price. And compare the quantiles 
to a normal distribution with estimated parameters. Finally, I'll turn 
ODS TRACE off, so I don't keep printing table and graphic names to the log.

So again, here is all the default output that PROC UNIVARIATE generates. 
But now, maybe I only want to print the basic statistical measures table.
And maybe I only want to print the qqplot graphic. I basically want to 
suppress all other tables in this instance. Well, I turned ODS TRACE on, 
so let's go to the log. And you'll notice, the log prints all the names 
of my tables and graphics. So for example, the Moments table is named 
Moments. The BasicMeasures of location variability table is just called 
BasicMeasures. So the table names that you're going to supply ODS SELECT
might not be identical to the names in the default results page.

In Part B, I'm going to start with my ODS SELECT statement and give it 
the table name basicmeasures and the graphic name qqplot to print those
exclusively. And I'll run the exact same UNIVARIATE procedure. And now 
I get the single table and graphic that I requested. All other tables 
have been suppressed. And again this is equivalent to pulling fields 
from an object with the dollar sign operator in R. You might not want 
to use ODS TRACE if you're running a procedure that takes several minutes
to run. You don't want to have to generate the output, then find the 
table and graphic names, and then run the procedure again to customize
your output.

So an alternative way is to use the online documentation. And let's 
look up the UNIVARIATE procedure in the 9.4 package. I'm going to go 
to SAS syntax look-up 9.4, under Shortcuts. And then I'm just going to 
search for the procedure, Univariate. And select the UNIVARIATE procedure.
And the UNIVARIATE Procedure Modeling a Data Distribution link. And to
find the table and graphics names, I'm going to go to the Details tab, 
and I'm going to scroll towards the bottom and select ODS Table Names.

So here you notice our table with the ODS Table Name. This is again what 
will supply the ODS SELECT statement. The description of what it's going 
to print. And also the option to how to tell SAS to display that 
information. So you'll notice the basic measures table. Of course, it's
called BasicMeasures. Measures of location and variability. And that's 
printed by default.

Another reason I like to come to this page, besides finding the table and
graphics names, is I can look at the other output that can be generated 
from a procedure. For example, the CIBASIC option will generate confidence
intervals for the mean, standard deviation, and variance. And this table
name is called BasicIntervals. So there's lots of other tables and graphics
we can generate, and we can view those options here in the Details tab.

To find the graphics names, again, I'll go to Details, and I'll go to 
the bottom. Where it says ODS Graphics, and I'll select that link. And 
again, here we find the ODS Graph Name that we would supply to ODS SELECT
statement. And it also specifies the statement used to generate the graphic.
And you'll also notice three other possible graphics you can generate 
right in the UNIVARIATE procedure.
*;