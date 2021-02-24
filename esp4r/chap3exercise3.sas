**********************************************************************;
* Chapter 3 Exercise 3
* Creating New Variables, Functions, and Data Tables
*
* Use the Cars data set in the SP4R library to complete this exercise.
*
* a)	Create a function called tier with a single numeric argument, 
*		which returns a character value. The function should return 
*		values according to the table in the pdf in the course.
* b)	Use the function that you created to create a new variable in 
*		the Cars data set. Name the new variable mpg_quality2 and name 
*		the argument of the function tier as mpg_average. As a result,
*		mpg_quality and mpg_quality2 are identical.
* c)	Print observations 65 through 70 for the variables 
*		mpg_average, mpg_quality, and mpg_quality2 to ensure that the 
*		variable is created.
**********************************************************************;

/*Checking out the data*/
proc print data=sp4r.cars(obs=10);
run;

/*part a*/
proc fcmp outlib=sp4r.functions.newfuncs;
	function tier(x) $; 
		length final $ 6;
        if x < 20 then final = 'Low';
        else if x <30 then final='Medium';
	    else final='High';
        return(final);
	endsub;
quit;

/*part b*/
*options cmplib=sp4r.functions;
*data sp4r.cars;
*   set sp4r.cars;
*   mpg_quality2=tier(mpg_average);
*run;

*...the variables requested in the problem aren't in the data...wow. Guess I 
* won't be doing part c either. no mpg_average and no mpg_quality.
*;