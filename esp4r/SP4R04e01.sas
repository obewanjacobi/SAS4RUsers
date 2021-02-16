/*SP4R04e02*/

data test; 
   do i=1 to 2; 
      output; 
   end; 
run; 

proc print data=test; 
run; 

data test; 
   set test; 
   do j=1 to 5; 
      output; 
   end; 
run; 

proc print data=test; 
run;
