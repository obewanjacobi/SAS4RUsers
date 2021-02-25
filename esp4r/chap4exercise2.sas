**********************************************************************;
* Chapter 4 Exercise 2
* Exploring PDF, CDF, and Quantiles Variables
*
* a)	Use the DO loop to create quantiles from 0 to 10 by 1.
* b) 	Identify the density and the cumulative density of a binomial 
*		distribution with parameters 0.8 and 10 by creating the 
*		variables PDF and CDF.
* c) 	Use the CDF variable to create the variable Quantile, which 
*		mirrors the DO loop values.
* d) 	Print the data upon completion
**********************************************************************;

data sp4r.random;
 do q=0 to 10 by 1;
 probdense = pdf('Binomial',q,.8,10);   *I refuse to name these things the	;
 cumdist = cdf('Binomial',q,.8,10);		*same name as the function, that's	;
 q = quantile('Binomial',cdf,.8,10);	*stuuuuuupid/inconsiderate			;
 output;
 end;
run;
proc print data=sp4r.random;
run;