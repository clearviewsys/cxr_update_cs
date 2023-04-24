//%attributes = {}
// Query Customers with Birthdays
// Paramaters:
//     getCustomersWithUpcomingBday(1) gets BDays today
//     getCustomersWithUpcomingBday(7) gets BDays for the next week (7 days) including today

C_LONGINT:C283($1; $days; $n)


If (Count parameters:C259=1)
	$days:=$1
	$n:=$days-1
Else 
	assertInvalidNumberOfParams
End if 

If ($days=2)
	// For $days=2 we are looking for bdays tomorrow not bdays in the next 2 days
	QUERY BY FORMULA:C48([Customers:3]; (Month of:C24([Customers:3]DOB:5)=Month of:C24(Add to date:C393(Current date:C33(*); 0; 0; 1))) & (Day of:C23([Customers:3]DOB:5)=Day of:C23(Add to date:C393(Current date:C33(*); 0; 0; 1))))
Else 
	QUERY BY FORMULA:C48([Customers:3]; ((((Current date:C33(*)<=Date:C102((String:C10(Year of:C25(Current date:C33(*)))+\
		Substring:C12(String:C10([Customers:3]DOB:5; ISO date:K1:8); 5))))) & ((Add to date:C393(Current date:C33(*); 0; 0; $n)>=Date:C102((String:C10(Year of:C25(Current date:C33(*)))+\
		Substring:C12(String:C10([Customers:3]DOB:5; ISO date:K1:8); 5)))))) | (((Current date:C33(*)<=Date:C102((String:C10(Year of:C25(Add to date:C393(Current date:C33(*); 0; 0; $n)))+\
		Substring:C12(String:C10([Customers:3]DOB:5; ISO date:K1:8); 5))))) & ((Add to date:C393(Current date:C33(*); 0; 0; $n)>=Date:C102((String:C10(Year of:C25(Add to date:C393(Current date:C33(*); 0; 0; $n)))+\
		Substring:C12(String:C10([Customers:3]DOB:5; ISO date:K1:8); 5))))))))
End if 
//QUERY BY FORMULA([Customers];isBirthdayToday([Customers]DOB;$days))  // simplified by @tiran on Dec 31/2020 ; not tested; unit test_isBirthdayToday


// OLD WAY
//QUERY BY FORMULA([Customers];((((Current date(*)<=Date(String(Month of([Customers]DOB))+"/"+String(Day of([Customers]DOB))+"/"+String(Year of(Current date(*)))))) & ((Add to date(Current date(*);0;0;$n)>=Date(String(Month of([Customers]DOB))+"/"+String(Day of([Customers]DOB))+"/"+String(Year of(Current date(*))))))) | (((Current date(*)<=Date(String(Month of([Customers]DOB))+"/"+String(Day of([Customers]DOB))+"/"+String(Year of(Add to date(Current date(*);0;0;$n)))))) & ((Add to date(Current date(*);0;0;$n)>=Date(String(Month of([Customers]DOB))+"/"+String(Day of([Customers]DOB))+"/"+String(Year of(Add to date(Current date(*);0;0;$n)))))))))

//QUERY BY FORMULA([Customers];((((Current date(*)<=Date((Substring(String([Customers]DOB);1;Length(String([Customers]DOB))-4)+String(Year of(Current date(*))))))) & ((Add to date(Current date(*);0;0;$n)>=Date((Substring(String([Customers]DOB);1;Length(String([Customers]DOB))-4)+String(Year of(Current date(*)))))))) | (((Current date(*)<=Date((Substring(String([Customers]DOB);1;Length(String([Customers]DOB))-4)+String(Year of(Add to date(Current date(*);0;0;$n))))))) & ((Add to date(Current date(*);0;0;$n)>=Date((Substring(String([Customers]DOB);1;Length(String([Customers]DOB))-4)+String(Year of(Add to date(Current date(*);0;0;$n))))))))))



