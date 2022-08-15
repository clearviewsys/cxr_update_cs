//%attributes = {}
C_LONGINT:C283($iProcess; $i; $length)
C_TEXT:C284($sProcessName; $sSessionUser; $sUser)
C_OBJECT:C1216($oStatus; $info)
$oStatus:=New object:C1471()

READ WRITE:C146([CompanyInfo:7])

ALL RECORDS:C47([CompanyInfo:7])
FIRST RECORD:C50([CompanyInfo:7])

READ WRITE:C146([Licenses:160])


If (Locked:C147([CompanyInfo:7]))
	LOCKED BY:C353([CompanyInfo:7]; $iProcess; $sUser; $sSessionUser; $sProcessName)
	myAlert(Table name:C256(->[CompanyInfo:7])+" is LOCKED by User: "+$sUser+" Session User: "+$sSessionUser+" Process Name: "+$sProcessName)
	
Else 
	$oStatus:=RAL2_getStatus([CompanyInfo:7]ClientCode2:25)
	$info:=$oStatus.info
	$i:=0
	$length:=$info.licenses.length
	While ($i<$length)
		QUERY:C277([Licenses:160]; [Licenses:160]LicenseID:2=$info.licenses[$i].serviceId)
		If (Records in selection:C76([Licenses:160])=0)
			CREATE RECORD:C68([Licenses:160])
			[Licenses:160]LicenseID:2:=$info.licenses[$i].serviceId
		Else 
			LOAD RECORD:C52([Licenses:160])
		End if 
		If ($info.licenses[$i].serviceName#Null:C1517)
			[Licenses:160]Value:3:=$info.licenses[$i].serviceName
		Else 
			[Licenses:160]Value:3:=""
		End if 
		If ($info.licenses[$i].serviceExpiryDate#Null:C1517)
			[Licenses:160]ExpiryDate:4:=Date:C102($info.licenses[$i].serviceExpiryDate)
		Else 
			[Licenses:160]ExpiryDate:4:=Date:C102("0000/00/00")
		End if 
		If (String:C10($info.licenses[$i].monthlyHit)#Null:C1517)
			[Licenses:160]MonthlyHit:5:=$info.licenses[$i].monthlyHit
		Else 
			[Licenses:160]MonthlyHit:5:=0
		End if 
		If ($info.licenses[$i].totalHit#Null:C1517)
			[Licenses:160]TotalHit:7:=$info.licenses[$i].totalHit
		Else 
			[Licenses:160]TotalHit:7:=0
		End if 
		If ($info.licenses[$i].monthlyHitLimit#Null:C1517)
			[Licenses:160]MaxMonthlyHit:6:=$info.licenses[$i].monthlyHitLimit
		Else 
			[Licenses:160]MaxMonthlyHit:6:=0
		End if 
		If ($info.licenses[$i].totalHitLimit#Null:C1517)
			[Licenses:160]MaxTotalHit:8:=$info.licenses[$i].totalHitLimit
		Else 
			[Licenses:160]MaxTotalHit:8:=0
		End if 
		
		SAVE RECORD:C53([Licenses:160])
		UNLOAD RECORD:C212([Licenses:160])
		$i:=$i+1
	End while 
End if 

UNLOAD RECORD:C212([CompanyInfo:7])
READ ONLY:C145([CompanyInfo:7])
READ ONLY:C145([Licenses:160])