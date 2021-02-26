/*SP4R07d06*/

/*Part A*/
proc iml;
   numberIterations=10000;
   call randseed(802);

/*Part B*/
   do iteration=1 to numberIterations;
      doors = {1 2 3};
      carDoor=sample(doors,1);

/*Part C*/
     *Pick door for Monty Hall to open;
     if carDoor=1 then openDoor=randfun(1,"Bernoulli",.5) + 2;
     else if carDoor=2 then openDoor=3;
     else if carDoor=3 then openDoor=2;

/*Part D*/
     *Determine door for switching strategy;
     if openDoor=2 then switchDoor=3;
     else if openDoor=3 then switchDoor=2;

/*Part E*/
     *Determine which strategy wins;
     if carDoor=1 then stayWin=1;
     else stayWin=0;

     if carDoor=switchDoor then switchWin=1;
     else switchWin=0;
	 /*switchWin=carDoor=switchDoor;*/

/*Part F*/
     *Collect results to a single matrix;
     results=results // (iteration || carDoor || openDoor || stayWin || switchWin);
   end;

/*Part H*/
   reset noname;
   resultsSubset = results[1:10,];
   print resultsSubset [colname={iteration carDoor openDoor 
      stayWin switchWin}];

   percentageWins=results[:,{4 5}];
   print percentageWins [colname={stay switch}];
quit;


*
Demo: The Monty Hall Simulation
For the Monty Hall example, let's run 10,000 iterations. And don't 
forget to set a seed to duplicate your results. In Part B we'll use 
the DO loop, again, the same way as we'd use a FOR loop.

So I'll specify my index variable iteration equal 1 to 10,000, the 
number of iterations. And my vector doors will simply be the 3 Doors,
1, 2, and 3. And on each iteration, I'll create a new variable called 
carDoor by sampling that door's vector one time. So it can only be a 
value of 1, 2, or 3.

Next, I'm going to pick a door for Monty Hall to open. And for the sake
of simplicity, let's assume we always choose Door number 1. This will 
not affect our results at all, but make the code a little bit easier. So
IF the carDoor is equal to number 1, meaning the car is behind Door 
number 1 then we're going to open either Door 2 or Door 3.

So we'll simulate a Bernoulli value, which will give us either a 0 or 
a 1 value, and then I'll just add 2 get a value of 2 or 3. ELSE IF the 
carDoor is equal to number 2, then the host has to open Door number 3. 
And likewise, IF the car is behind Door number 3, the host has to open 
Door number 2, because of course, I picked Door number 1.

Now let's determine the door for the switching strategy. So IF the host
opens Door number 2, then I switch to Door number 3. Otherwise, IF the
host opens Door number 3, then I'll switch to Door number 2.

Now, in Part E, let's determine which strategy wins for each iteration.
So IF the car is behind Door number 1, then we'll say the variable 
stayWin is equal to 1 for a success, ELSE, stayWin is 0. IF the car
Door is equal to switchDoor, then the switchWin variable is equal to 1 
for success and 0 otherwise.

Now you'll notice I've been using IF ELSE syntax. You can also use 
ASSIGNMENT statements and the equal sign. And again, it looks a little
bit funny in SAS because we don't use the double equal sign. So the first
equal sign is the ASSIGNMENT statement.

So I'm creating a new variable called switchWin. And I'm setting it
equal to the following, carDoor equals switchDoor. And because this is
the second instance of the equal sign, it's the Bernoulli operator or
simply the double equal sign in R. But in SAS, we just use the single
equal sign. So this will give the exact same result as using the IF 
and ELSE statements.

Next, for each iteration, I'm going to collect all my results. To the 
results matrix, I'm going to row bind the following. The iteration number,
the carDoor, openDoor, stayWin, and switchWin values. And I'm using 
the vertical pipe to concatenate each one of those.

Next, in Part H, I'm going to simply pull out the first 10 iterations 
of this game, just to look at my data. And I'll print the resultsSubset, 
with the option for column names.

Next, I'm going to find the percentage that the switchWin method wins
and the stayWin method wins. So I'm going to use the reduction operator
of colon. That simply finds the mean, and in this case, for columns 4 
and 5. Column 4 is the stayWin column, column 5 is the switchWin column.
So find the mean of those two columns and print those results with the 
column names.

Let's run this program. So here are the first 10 games from this 
simulation. You'll notice the STAYWIN method is successful only when the 
CARDOOR is behind Door number 1. Otherwise, the SWITCHWIN method is 
successful. So here my empirical result is about a 2/3 chance of success
for the SWITCHWIN method and one third for the STAY method, very similar
to our analytical results.
*;