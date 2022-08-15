//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/11/18, 22:21:13
// ----------------------------------------------------
// Method: webGetChoiceListCountries
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)  //option
C_POINTER:C301($2)  //value
C_POINTER:C301($3)  //label

//QUERY([Currencies];[Currencies]CurrencyCode#<>BASECURRENCY)
READ ONLY:C145([Accounts:9])

//TRACE
C_TEXT:C284($tContext)
$tContext:=WAPI_getSession("context")

Case of 
	: ($tContext="agents")
		QUERY:C277([Accounts:9]; [Accounts:9]CountryCode:39#"")
		
		DISTINCT VALUES:C339([Accounts:9]CountryCode:39; $1->)
		If (Count parameters:C259>=2)
			DISTINCT VALUES:C339([Accounts:9]CountryCode:39; $2->)
		End if 
		If (Count parameters:C259>=3)
			DISTINCT VALUES:C339([Accounts:9]CountryCode:39; $3->)
		End if 
		
		
		//: (webContext="customers")
		
	Else 
		
		ALL RECORDS:C47([Countries:62])
		ORDER BY:C49([Countries:62]; [Countries:62]CountryName:2; >)
		SELECTION TO ARRAY:C260([Countries:62]CountryName:2; $1->)
		If (Count parameters:C259>=2)
			SELECTION TO ARRAY:C260([Countries:62]CountryCode:1; $2->)
		End if 
		If (Count parameters:C259>=3)
			SELECTION TO ARRAY:C260([Countries:62]CountryName:2; $3->)
		End if 
		
		
End case 


INSERT IN ARRAY:C227($1->; 1)
$1->{1}:="-Select a Country-"

If (Count parameters:C259>=2)
	INSERT IN ARRAY:C227($2->; 1)
	$2->{1}:=""
End if 

If (Count parameters:C259>=3)
	INSERT IN ARRAY:C227($3->; 1)
	$3->{1}:=$1->{1}
End if 
