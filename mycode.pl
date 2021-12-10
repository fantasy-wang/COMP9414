
%Question1: 
%base case, empty list
sumsq_even([],0).

%recursion  
%check the Head is even or not
%if it is, do the rest of list and add squart head to Sum
 %if it is not, not add and do the rest of list
sumsq_even([Head | Tail], Sum) :-    
	0 is Head mod 2,              
	sumsq_even(Tail, Sum1),        
	Sum is Head * Head+Sum1.     

sumsq_even([Head | Tail], Sum) :-
	not(0 is Head mod 2),           
	sumsq_even(Tail, Sum).          
	


%Question2:
%male descendant
%base case, if the person is ancestor, Person has to be a male
%base case, if Person is parent of Descendant and Person is male
maledescendant(Person, Descendant) :-
	Person = Descendant,               
	male(Person).		  
maledescendant(Person, Descendant) :-
	parent(Person, Descendant),  	
	male(Person).			
%recursion
%Descendant is directly or indirectly descendant of Person and Person is a male
%recursion of Child of Person
maledescendant(Person, Descendant) :-
	parent(Person, Child),
	male(Person),
	maledescendant(Child, Descendant).

%same_name, check if Person1 and Person2 have same Ancestor and the Ancestor is male
same_name(Person1, Person2) :-
	maledescendant(Ancestor, Person1),
	maledescendant(Ancestor, Person2).

%Question3��
%base case, empty list
sqrt_list([], []).
%recursion, add the sqrt of every element of list in to a newlist
sqrt_list([ Head | Tail],[[First, Tail1] | ResultList]) :-
	First is Head,
	Tail1 is sqrt(Head),
	sqrt_list(Tail, ResultList).

%Question4:
%if the number is negative
nnumber([H | T], Temp, Rest) :-
	Temp = [H],
	T = [],
	Rest = T.
nnumber([H | T], Temp, Rest) :-
	T = [H1 | _],
	H1 >=0,
	Temp = [H],
	Rest = T.
nnumber([H | T], Temp, Rest) :-
	T = [H1 | _],
	H1 <0,
	nnumber(T, Temp1, Rest1),
	Temp = [H | Temp1],
	Rest = Rest1.

%if the number is positive
pnumber([H | T], Temp, Rest) :-
	Temp = [H],
	T = [],
	Rest = T.
pnumber([H | T], Temp, Rest) :-
	T = [H1 | _],
	H1 <0,
	Temp = [H],
	Rest = T.
pnumber([H | T], Temp, Rest) :-
	T = [H1 | _],
	H1 >=0,
	pnumber(T, Temp1, Rest1),
	Temp = [H | Temp1],
	Rest = Rest1.
%base case, empty list
sign_runs([],[]).
sign_runs([H],[[H]]).
sign_runs([H | T], RunList) :-
	H >= 0,
	pnumber([H | T], Temp, Rest),
	sign_runs(Rest, RestRunList),
	RunList = [Temp | RestRunList].

sign_runs([H | T], RunList) :-
	H < 0,
	nnumber([H | T], Temp, Rest),
	sign_runs(Rest, RestRunList),
	RunList = [Temp | RestRunList].

%Question5:
%if tree is empty
is_heap(empty).

%if left and right of tree are empty
is_heap(tree(empty, _, empty)).

%if Left is not empty
is_heap(tree(tree(LeftLeft, LeftNum, LeftRight), Num, empty)) :-
	Num =< LeftNum,
	is_heap(LeftLeft),
	is_heap(LeftRight).

%if Right is not empty
is_heap(tree(empty, Num, tree(RightLeft, RightNum, RightRight))) :-
	Num =<RightNum,
	is_heap(RightLeft),
	is_heap(RightRight).

%if left and right of tree are not empty
is_heap(tree(tree(LeftLeft, Num1, LeftRight), Num, tree(RightLeft, Num2, RightRight))) :-
	Num =<Num1,
	Num =<Num2,
	is_heap(LeftLeft),
	is_heap(LeftRight),
	is_heap(RightLeft),
	is_heap(RightRight).