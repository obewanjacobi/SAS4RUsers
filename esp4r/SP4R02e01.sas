/*SP4R02e01*/
*******************************************************************;
* Chapter 2 Exercise 1
* Importing and Reporting Data
*
* Your local animal shelter needs help with entering data into SAS. 
* The information that they want to keep a record of is the Name, 
* Age, Weight, and Color of each dog, and whether the dog likes Cats.
* 	1. Creating a SAS Data Set by Hand
*		a.  Open SP4R02e01.sas and add the code needed to create a 
*		    data set called Shelter in the SP4R
*			library. The data is shown in the table below.  
*			Each line should correspond to a single observation.
*		b.	Navigate to the SP4R directory to ensure that the 
*			Shelter data set was created correctly
*		c.	Create another data set called Shelter2. This time, 
*			enter all of the data on a single line.
*		d.	Navigate to the SP4R directory to ensure that the 
*			Shelter2 data set was created correctly
*******************************************************************;
/*
Pluto 3 25 Black No
Lizzie 10 43 Tan Yes
Pesci 10 38 Brindle No
*/

/*part a*/
data sp4r.Shelter;
   length Name $ 25 Color $ 25;
   input Name $ Age Weight Color $ Cats $;
   datalines;
	Pluto 3 25 Black No
	Lizzie 10 43 Tan Yes
	Pesci 10 38 Brindle No
;
run;

/*part b*/
* check;

/*part c*/
data sp4r.Shelter2;
   length Name $ 25 Color $ 25;
   input Name $ Age Weight Color $ Cats $ @@;
   datalines;
	Pluto 3 25 Black No Lizzie 10 43 Tan Yes Pesci 10 38 Brindle No
;
run;

/*part d*/
* check;