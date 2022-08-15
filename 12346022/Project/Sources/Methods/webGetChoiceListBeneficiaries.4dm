//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/16/18, 09:36:45
// ----------------------------------------------------
// Method: webGetBeneficiaryList
// Description
// 
//
// Parameters
// ----------------------------------------------------

//TRACE

C_POINTER:C301($1)  //option - pointer to array to fill
C_POINTER:C301($2)  //option value
C_POINTER:C301($3)  //option label

C_TEXT:C284($tContext; $countries)

$tContext:=WAPI_getSession("context")

C_TEXT:C284($tLinkID)
C_LONGINT:C283($i)
Case of 
	: ($tContext="agents")
		webSelectAgentRecord
		
		//we should have the current ewire record with the source link id
		//now use the source link id to get all links with that "sameAsLinkID"
		
		ARRAY TEXT:C222($atOptions; 0)
		ARRAY TEXT:C222($atValues; 0)
		
		$tLinkID:=[WebEWires:149]LinkID:25  //[Links]LinkID  <----- this is the parent link ID
		
		Begin SQL
			SELECT [Links].[CustomerName], [Links].[CustomerID]
			FROM [Links]
			WHERE [Links].[sameAsLinkID] = :$tLinkID OR [Links].[LinkID] = :$tLinkID
			INTO :$atOptions, :$atValues;
		End SQL
		
		For ($i; Size of array:C274($atOptions); 1; -1)
			Case of 
				: ($atOptions{$i}="")
					DELETE FROM ARRAY:C228($atOptions; $i)
					DELETE FROM ARRAY:C228($atValues; $i)
					
				: ($atValues{$i}="") & ($atOptions{$i}#"")
					$atValues{$i}:="|"+$atOptions{$i}+"- UNESTABLISHED"
			End case 
		End for 
		
		INSERT IN ARRAY:C227($atOptions; 1)
		$atOptions{1}:="-Select a Beneficiary-"
		INSERT IN ARRAY:C227($atValues; 1)
		$atValues{1}:=""  //blank
		
		APPEND TO ARRAY:C911($atOptions; "-Search For Beneficiary-")
		APPEND TO ARRAY:C911($atValues; "SEARCH")
		
		APPEND TO ARRAY:C911($atOptions; "-Add New Beneficiary-")
		APPEND TO ARRAY:C911($atValues; "NEW")
		
		
		
		COPY ARRAY:C226($atOptions; $1->)
		COPY ARRAY:C226($atValues; $2->)
		
		
		
	: ($tContext="customers")
		webSelectCustomerRecord
		
		
		If (True:C214)
			C_OBJECT:C1216($entity; $link)
			
			Case of 
				: (Is new record:C668([WebEWires:149])) & ([WebEWires:149]toCountryCode:12#"")
					$entity:=ds:C1482.Links.query("CustomerID == :1 AND countryCode == :2"; [Customers:3]CustomerID:1; [WebEWires:149]toCountryCode:12)
					//: (WAPI_getParameter ("table")=Table name(->[WebEWires]))
				: (WAPI_getParameter("request")="@/webewires-create.shtml")  // ewires - currently lotus restriction
					$countries:=getKeyValue("web.customers.webewires.links.countries"; "NZ;AU;FJ")
					$entity:=ds:C1482.Links.query("CustomerID == :1 AND countryCode IN :2"; [Customers:3]CustomerID:1; Split string:C1554($countries; ";"))  //"NZ";"AU";"FJ"))
				Else 
					$entity:=ds:C1482.Links.query("CustomerID == :1"; [Customers:3]CustomerID:1)
			End case 
			
			If ($entity.length>0)
				For each ($link; $entity)
					APPEND TO ARRAY:C911($1->; $link.FullName)
					APPEND TO ARRAY:C911($2->; $link.LinkID)
				End for each 
			End if 
			
		Else 
			QUERY:C277([Links:17]; [Links:17]CustomerID:14=[Customers:3]CustomerID:1; *)
			If (Is new record:C668([WebEWires:149])) & ([WebEWires:149]toCountryCode:12#"")
				QUERY:C277([Links:17];  & ; [Links:17]countryCode:50=[WebEWires:149]toCountryCode:12)
			Else 
				QUERY:C277([Links:17])
			End if 
			
			
			For ($i; 1; Records in selection:C76([Links:17]))
				APPEND TO ARRAY:C911($1->; [Links:17]FullName:4)
				APPEND TO ARRAY:C911($2->; [Links:17]LinkID:1)
				NEXT RECORD:C51([Links:17])
			End for 
			
		End if 
		
		INSERT IN ARRAY:C227($1->; 1)
		$1->{1}:=""  //blank
		INSERT IN ARRAY:C227($2->; 1)
		$2->{1}:=""  //blank
		
		
		
	Else 
		
End case 

