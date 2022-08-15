
C_TEXT:C284($method)


Case of 
	: (Position:C15("/"; [CalendarEvents:80]executeMethod:23)>0)
		$method:=Substring:C12([CalendarEvents:80]executeMethod:23; 1; Position:C15("/"; [CalendarEvents:80]executeMethod:23)-1)
	Else 
		$method:=[CalendarEvents:80]executeMethod:23
End case 

If (UTIL_isMethodExists($method))
	myAlert("Method is valid.")
Else 
	myAlert("Method is NOT valid.")
End if 


//ARRAY TEXT($atMethods;0)

//METHOD GET NAMES($atMethods;[CalendarEvents]executeMethod;*)

//If (Size of array($atMethods)>0)
//myAlert ("Method is valid.")
//Else 
//myAlert ("Method is NOT valid.")
//End if 