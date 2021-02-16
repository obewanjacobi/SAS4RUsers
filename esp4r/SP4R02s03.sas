/*SP4R02s03*/

data sp4r.state_pop;
	length State $ 25;
	infile "&path/state_pop.txt" dlm='09'x;
	input State $ Population;
run;
