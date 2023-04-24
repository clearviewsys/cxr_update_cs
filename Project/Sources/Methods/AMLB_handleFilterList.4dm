//%attributes = {}

C_LONGINT:C283($1; $iFormEvent)

C_LONGINT:C283($iSelected)
C_TEXT:C284($tSelected)
C_POINTER:C301($ptrSelf; $ptrDate)



If (Count parameters:C259>=1)
	$iFormEvent:=$1
Else 
	$iFormEvent:=Form event code:C388
End if 

$ptrSelf:=Self:C308
$ptrDate:=OBJECT Get pointer:C1124(Object named:K67:5; "AMLB_DatePicker")

Case of 
	: ($iFormEvent=On Load:K2:1)
		$ptrSelf->:=Load list:C383("AML_Browser_Filters")
		
		
	: ($iFormEvent=On Clicked:K2:4)
		GET LIST ITEM:C378($ptrSelf->; Selected list items:C379(Self:C308->); $iSelected; $tSelected)
		
		USE SET:C118("OpenAMLClaimsSet")
		USE SET:C118("OpenAMLReportsSet")
		
		FORM GOTO PAGE:C247(1)  //default to page 1
		
		Case of 
			: ($iSelected=10)  //all
				
			: ($iSelected=11)  //today
				QUERY SELECTION:C341([AML_Alerts:137]; [AML_Alerts:137]date:5<=Current date:C33)
				
			: ($iSelected=12)  //this week
				QUERY SELECTION:C341([AML_Alerts:137]; [AML_Alerts:137]date:5<=Current date:C33)
				
			: ($iSelected=13)  //this month
				QUERY SELECTION:C341([AML_Alerts:137]; [AML_Alerts:137]date:5<=Current date:C33)
				
			: ($iSelected=14)  //this quarter
				QUERY SELECTION:C341([AML_Alerts:137]; [AML_Alerts:137]date:5<=Current date:C33)
				
				
			: ($iSelected=50)  //reports
				FORM GOTO PAGE:C247(2)
				
				
			Else 
				
		End case 
		
		
	: ($iFormEvent=On Data Change:K2:15)
		USE SET:C118("OpenAMLClaimsSet")
		USE SET:C118("OpenAMLReportsSet")
		
		If (Not:C34(Is nil pointer:C315($ptrDate)))
			QUERY SELECTION:C341([AML_Alerts:137]; [AML_Alerts:137]date:5=$ptrDate->)
		End if 
		
	: ($iFormEvent=On Timer:K2:25)
		
		QUERY:C277([AML_Alerts:137]; [AML_Alerts:137]status:8=0)  //<>TODO query for "open" claims
		CREATE SET:C116([AML_Alerts:137]; "OpenAMLClaimsSet")
		
		QUERY:C277([AML_Reports:119]; [AML_Reports:119]reportStatus:13=0; *)  //open
		QUERY:C277([AML_Reports:119];  | ; [AML_Reports:119]reportStatus:13=2)  //not filed
		CREATE SET:C116([AML_Reports:119]; "OpenAMLReportsSet")
		
		
		
	: ($iFormEvent=On Unload:K2:2)
		CLEAR SET:C117("OpenAMLReportsSet")
		CLEAR SET:C117("OpenAMLClaimsSet")
		
		CLEAR LIST:C377(Self:C308->)
		
	Else 
		
End case 