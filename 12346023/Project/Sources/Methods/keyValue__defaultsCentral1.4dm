//%attributes = {}
//init KeyValues for MoneyWay
C_TEXT:C284($tCurrency; $tValue)
If (True:C214)
	$tCurrency:="CAD-CR"
	$tValue:=keyValue_getValue("aft.OriginatorShortName."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorShortName."+$tCurrency; "MONEYWAY")
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorLongName."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorLongName."+$tCurrency; "MONEYWAY-CDN CR")
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorAccount."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorAccount."+$tCurrency; "100010980532")  //$tOrigAcct:="100010980532"
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorInstitutionalID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorInstitutionalID."+$tCurrency; "080903630")  //$tOrigInstitutionalID:="080903630"
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorID."+$tCurrency; "8090003632")  //$tOriginatorID:="8090003632"
	End if 
	
	$tValue:=keyValue_getValue("aft.Central1ID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.Central1ID."+$tCurrency; "86900")
	End if 
	
	
	$tCurrency:="CAD-DR"  // ------------- CAD DR -------------------
	$tValue:=keyValue_getValue("aft.OriginatorShortName."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorShortName."+$tCurrency; "MONEYWAY")
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorLongName."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorLongName."+$tCurrency; "MONEYWAY-CDN DR")
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorAccount."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorAccount."+$tCurrency; "100009892324")  //$tOrigAcct:="100009892324"
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorInstitutionalID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorInstitutionalID."+$tCurrency; "080903630")  //$tOrigInstitutionalID:="080903630"  
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorID."+$tCurrency; "8090003631")  //$tOriginatorID:="8090003631"
	End if 
	
	$tValue:=keyValue_getValue("aft.Central1ID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.Central1ID."+$tCurrency; "86900")
	End if 
	
	$tCurrency:="USD-CR"  // ------------- USD CR -------------------
	$tValue:=keyValue_getValue("aft.OriginatorShortName."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorShortName."+$tCurrency; "MONEYWAY")
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorLongName."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorLongName."+$tCurrency; "MONEYWAY-USD CR")  //$tOrigLongName:="MONEYWAY-USD CR"
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorAccount."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorAccount."+$tCurrency; "100009894460")  //$tOrigAcct:="100009894460" 
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorInstitutionalID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorInstitutionalID."+$tCurrency; "080903630")  //$tOrigInstitutionalID:="080903630" 
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorID."+$tCurrency; "8090003633")  //$tOriginatorID:="8090003633"
	End if 
	
	$tValue:=keyValue_getValue("aft.Central1ID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.Central1ID."+$tCurrency; "86900")  //$tCentral1ID:="86900"
	End if 
	
	
	$tCurrency:="USD-DR"  // ------------- USD DR -------------------
	$tValue:=keyValue_getValue("aft.OriginatorShortName."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorShortName."+$tCurrency; "MONEYWAY")
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorLongName."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorLongName."+$tCurrency; "MONEYWAY-USD DR")  //$tOrigLongName:="MONEYWAY-USD DR"
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorAccount."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorAccount."+$tCurrency; "100009894460")  //$tOrigAcct:="100009894460"
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorInstitutionalID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorInstitutionalID."+$tCurrency; "080903630")  //$tOrigInstitutionalID:="080903630" 
	End if 
	
	$tValue:=keyValue_getValue("aft.OriginatorID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.OriginatorID."+$tCurrency; "8090003633")  //$tOriginatorID:="8090003634"
	End if 
	
	$tValue:=keyValue_getValue("aft.Central1ID."+$tCurrency; "")
	If ($tValue="")
		keyValue_setValue("aft.Central1ID."+$tCurrency; "86900")  //$tCentral1ID:="86900"
	End if 
	
	
End if 