//%attributes = {}


C_TEXT:C284($1; $toCountryCode)
C_POINTER:C301($2; $ptrNameArray)
C_POINTER:C301($3; $ptrValueArray)


$toCountryCode:=$1
$ptrNameArray:=$2
$ptrValueArray:=$3


Case of 
	: ($toCountryCode="AU")  // LOTUS config
		APPEND TO ARRAY:C911($ptrNameArray->; "Cash Pickup")
		APPEND TO ARRAY:C911($ptrValueArray->; "D")
		
		APPEND TO ARRAY:C911($ptrNameArray->; "Bank Transfer")
		APPEND TO ARRAY:C911($ptrValueArray->; "N")
		
		//If (Choose(getKeyValue ("web.customers.webewires.tomop.moneygram")="";False;True))  //only use if defined
		//If (webIsMoneyGramAllowed )
		//APPEND TO ARRAY($ptrNameArray->;"MoneyGram")
		//APPEND TO ARRAY($ptrValueArray->;"MG")
		//End if 
		//End if 
		
	: ($toCountryCode="FJ")  //| ($toCountryCode="NZ")  // LOTUS config
		APPEND TO ARRAY:C911($ptrNameArray->; "Cash Pickup")
		APPEND TO ARRAY:C911($ptrValueArray->; "D")
		
		APPEND TO ARRAY:C911($ptrNameArray->; "Mobile Wallet")
		APPEND TO ARRAY:C911($ptrValueArray->; "N-M")
		
		APPEND TO ARRAY:C911($ptrNameArray->; "Bank Transfer")
		APPEND TO ARRAY:C911($ptrValueArray->; "N")
		
	: ($toCountryCode="NZ")  // LOTUS config
		APPEND TO ARRAY:C911($ptrNameArray->; "Cash Pickup")
		APPEND TO ARRAY:C911($ptrValueArray->; "D")
		
		APPEND TO ARRAY:C911($ptrNameArray->; "Bank Transfer")
		APPEND TO ARRAY:C911($ptrValueArray->; "N")
		
	Else   // all other countries
		
		If (Choose:C955(getKeyValue("web.customers.webewires.mop.wire")="true"; True:C214; False:C215))
			
			//C_COLLECTION($col)
			//$col:=New collection
			//$col:=Storage.wiresMap.query("alpha2 == :1";$toCountryCode)
			
			If (Storage:C1525.wiresMap.query("alpha2 == :1"; $toCountryCode).length>0)
				APPEND TO ARRAY:C911($ptrNameArray->; "Wire Transfer")
				APPEND TO ARRAY:C911($ptrValueArray->; "N")
			End if 
		End if 
		
		
		//If (Choose(getKeyValue ("web.customers.webewires.tomop.moneygram")="";False;True))  //only use if defined
		//If (webIsMoneyGramAllowed )
		//APPEND TO ARRAY($ptrNameArray->;"MoneyGram")
		//APPEND TO ARRAY($ptrValueArray->;"MG")
		//End if 
		
		//If (Size of array($ptrNameArray->)=0)
		//APPEND TO ARRAY($ptrNameArray->;"Not Available")
		//APPEND TO ARRAY($ptrValueArray->;"")
		//End if 
		//End if 
		
End case 

If (Choose:C955(getKeyValue("web.customers.webewires.tomop.moneygram")=""; False:C215; True:C214))  //only use if defined
	If (webIsMoneyGramAllowed)
		APPEND TO ARRAY:C911($ptrNameArray->; "MoneyGram")
		APPEND TO ARRAY:C911($ptrValueArray->; "MG")
	End if 
End if 

If (Size of array:C274($ptrNameArray->)=0)
	APPEND TO ARRAY:C911($ptrNameArray->; "Not Available")
	APPEND TO ARRAY:C911($ptrValueArray->; "")
End if 