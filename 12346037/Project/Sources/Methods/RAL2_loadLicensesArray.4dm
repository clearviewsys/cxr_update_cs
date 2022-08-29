//%attributes = {}
//RAL2_loadLicensesArray
//Method to load the license data from the RAL2_get status endpoint into the 
//Licences lisbox on the user company info form
//Parameters: oStatus (Object): Object returned from the getStatus endpoint. 
//Must have format: {info:{licenses:[{serviceId,serviceName,serviceExpiryDate,
//                     monthlyHitLimit,monthlyHit,totalHit},...]}}

C_OBJECT:C1216($1; $oStatus)
C_OBJECT:C1216($info)
C_LONGINT:C283($i)

ARRAY TEXT:C222(LicenseId; 0)
ARRAY TEXT:C222(Name; 0)
ARRAY TEXT:C222(ExpiryDate; 0)
ARRAY TEXT:C222(MonthlyHits; 0)
ARRAY TEXT:C222(TotalHits; 0)
ARRAY TEXT:C222(MaxMonthlyHits; 0)
ARRAY TEXT:C222(MaxTotalHits; 0)


Case of 
	: (Count parameters:C259=1)
		$oStatus:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$info:=$oStatus.info
$i:=0
While ($i<$info.licenses.length)
	If ($info.licenses[$i].serviceId=Null:C1517)
		APPEND TO ARRAY:C911(LicenseId; "N/A")
	Else 
		APPEND TO ARRAY:C911(LicenseId; $info.licenses[$i].serviceId)
	End if 
	
	If ($info.licenses[$i].serviceName=Null:C1517)
		APPEND TO ARRAY:C911(Name; "N/A")
	Else 
		APPEND TO ARRAY:C911(Name; $info.licenses[$i].serviceName)
	End if 
	
	If ($info.licenses[$i].serviceExpiryDate=Null:C1517)
		APPEND TO ARRAY:C911(ExpiryDate; "N/A")
	Else 
		APPEND TO ARRAY:C911(ExpiryDate; $info.licenses[$i].serviceExpiryDate)
	End if 
	If (String:C10($info.licenses[$i].monthlyHit)=Null:C1517)
		APPEND TO ARRAY:C911(MonthlyHits; "N/A")
	Else 
		APPEND TO ARRAY:C911(MonthlyHits; String:C10($info.licenses[$i].monthlyHit))
	End if 
	
	If ($info.licenses[$i].totalHit=Null:C1517)
		APPEND TO ARRAY:C911(TotalHits; "N/A")
	Else 
		APPEND TO ARRAY:C911(TotalHits; String:C10($info.licenses[$i].totalHit))
	End if 
	
	If ($info.licenses[$i].monthlyHitLimit=Null:C1517)
		APPEND TO ARRAY:C911(MaxMonthlyHits; "N/A")
	Else 
		APPEND TO ARRAY:C911(MaxMonthlyHits; String:C10($info.licenses[$i].monthlyHitLimit))
	End if 
	If ($info.licenses[$i].totalHitLimit=Null:C1517)
		APPEND TO ARRAY:C911(MaxTotalHits; "N/A")
	Else 
		APPEND TO ARRAY:C911(MaxTotalHits; String:C10($info.licenses[$i].totalHitLimit))
	End if 
	$i:=$i+1
End while 

//$aLicences:=$oStatus.info.licenses



