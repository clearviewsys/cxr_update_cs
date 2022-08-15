//%attributes = {"shared":true}

C_TEXT:C284($tAuth; $tID; $tMode; $tPage; $tToken)
C_LONGINT:C283($iElem)

If (WAPI_isLicensed)
	$tMode:=WAPI_getParameter("mode")
	$tID:=WAPI_getParameter("id")
	$tToken:=WAPI_getParameter("token")
	$tAuth:=WAPI_getParameter("auth")
Else 
	$iElem:=Find in array:C230(WEB_aNames; "mode")
	If ($iElem>0)
		$tMode:=WEB_aValues{$iElem}
	End if 
	
	$iElem:=Find in array:C230(WEB_aNames; "id")
	If ($iElem>0)
		$tID:=WEB_aValues{$iElem}
	End if 
	
	$iElem:=Find in array:C230(WEB_aNames; "token")
	If ($iElem>0)
		$tToken:=WEB_aValues{$iElem}
	End if 
	
	$iElem:=Find in array:C230(WEB_aNames; "auth")
	If ($iElem>0)
		$tAuth:=WEB_aValues{$iElem}
	End if 
End if 

$tPage:=""

READ ONLY:C145([Confirmations:153])
QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)

If ([Confirmations:153]UUID:1=$tToken)
	
	If ([Confirmations:153]status:12=confirmationUnknown)  //hasn't been set yet
		Case of 
			: ($tMode="Approve") | ($tMode="Accept")
				confirmationSetStatus($tID; confirmationApprove; $tAuth; "")
				
			: ($tMode="Deny")
				confirmationSetStatus($tID; confirmationDeny; $tAuth; "")
				
			Else 
				iH_Notify(String:C10([Confirmations:153]confirmationType:5); [Confirmations:153]confirmationMessage:6+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"STATUS: "+$tMode+" by "+$tAuth)
				
		End case 
		
		$tPage:=Get 4D folder:C485(HTML Root folder:K5:20)+"confirmations"+Folder separator:K24:12+"confirm-ack.shtml"
	Else 
		$tPage:=Get 4D folder:C485(HTML Root folder:K5:20)+"confirmations"+Folder separator:K24:12+"confirm-complete.shtml"
	End if 
	
End if 

If (Test path name:C476($tPage)=Is a document:K24:1)
Else 
	$tPage:=Replace string:C233($tPage; "WebDecoy"; "WebFolder")
End if 

If (Test path name:C476($tPage)=Is a document:K24:1)
	WEB SEND FILE:C619($tPage)
	//WAPI_sendFile ($tPage)
Else 
	WEB SEND TEXT:C677(Char:C90(1)+"Thank You - You have "+confirmationGetStatusText([Confirmations:153]status:12)+" this request.")
End if 

UNLOAD RECORD:C212([Confirmations:153])