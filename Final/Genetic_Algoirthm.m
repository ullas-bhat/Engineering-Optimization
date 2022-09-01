%GA Implementation
%f= function
%x0_size= no of design vectors
%a,b= initial intervals of population generation
function [gen_count,Best_value,Best_vector,exit_flag]= Genetic_Algoirthm(f,a,b,x0_size,population,no_of_iter,Max_stagnant_iter,Tol_F)
gen_count=1;
Elite_count=5;
Stagnant_Iterations=0;
converge_Tol_F=0;
Top_90_prev=ones(1,90);
exit_flag=0;
%Normalized Max Spread For Mutations
sigma=0.15;
Best_value=99999999999999999999999;
%Initial Pop
for i=1:population
x0 = a + (b-a).*rand(x0_size,1);
x0_array(1:x0_size,i)=x0;
end

while gen_count<no_of_iter && Stagnant_Iterations<Max_stagnant_iter && converge_Tol_F==0

gen_count

population=size(x0_array);
population=population(2);
for i=1:population
f_value(i)=f(transpose(x0_array(1:x0_size,i)));
end

for i=1:population
Array=[f_value;x0_array];
end

Array=transpose(sortrows(transpose(Array)))
if(mag(Array(1,90)-Top_90_prev)<Tol_F)
converge_Tol_F=1;
end
Top_10_prev=Array(1,90);

if Array(1,1)<Best_value
Best_value=Array(1,1);
Best_vector=Array(2:1+x0_size,1);
else
Stagnant_Iterations=Stagnant_Iterations+1;
end


%Save Elites
Elites=Array(2:1+x0_size,1:Elite_count);

Remaining_population=population-Elite_count;
Remaining_Array_x0=Array(2:1+x0_size,Elite_count:end);

%Remaining 80 percent crossover from rest and 20 percent mutation

crossover_population=round(Remaining_population*0.8);
mutation_population=round(Remaining_population*0.2);

%Crossover
Crossovers=[];
for i=1:crossover_population
   parent_one=Remaining_Array_x0(1:x0_size,randperm(Remaining_population,1)) ; 
   parent_two=Remaining_Array_x0(1:3,randperm(crossover_population,1))  ;
   
   child=[parent_one(1),parent_two(2),parent_one(1)];
   Crossovers(1:x0_size,end+1)=child;
end

%Mutation
Mutations=[];
for i=1:mutation_population
   parent_one=Remaining_Array_x0(1:x0_size,randperm(Remaining_population,1)) ; 
   j=randperm(x0_size,1);
   child=parent_one;
   child(j)=child(j)+(-sigma+(2*sigma)*rand);
   if child(j)<0
       child(j)=0.002;
   end
   Mutations(1:x0_size,end+1)=child; 
end

%save needed for next convegence and increment gen
x0_array=[Elites Crossovers Mutations];
gen_count=gen_count+1;

if gen_count==no_of_iter
    exit_flag=1;
elseif Stagnant_Iterations==Max_stagnant_iter
    exit_flag=2;
elseif converge_Tol_F==0
    exit_flag=3;
end

end


end