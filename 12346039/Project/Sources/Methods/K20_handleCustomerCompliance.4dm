//%attributes = {}
// K20_recieveSearchSummary($catGroupName;$idFieldPtr;$name;{$address;$identifiction;$date})
// Author: Wai-Kin Chau

C_TEXT:C284($1; $catGroupName)
C_POINTER:C301($2; $idFieldPtr)
C_TEXT:C284($3; $name)
C_TEXT:C284($4; $address)
C_TEXT:C284($5; $identification)
C_DATE:C307($6; $date)

Case of 
	: (Count parameters:C259=3)
		$catGroupName:=$1
		$idFieldPtr:=$2
		$name:=$3
	: (Count parameters:C259=4)
		$catGroupName:=$1
		$idFieldPtr:=$2
		$name:=$3
		$address:=$4
	: (Count parameters:C259=5)
		$catGroupName:=$1
		$idFieldPtr:=$2
		$name:=$3
		$address:=$4
		$identification:=$5
	: (Count parameters:C259=6)
		$catGroupName:=$1
		$idFieldPtr:=$2
		$name:=$3
		$address:=$4
		$identification:=$5
		$date:=$6
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_BOOLEAN:C305($showProgressBar)
$showProgressBar:=True:C214

C_LONGINT:C283($progressID)
C_REAL:C285($complete; $total)
C_TEXT:C284($title; $message)
If ($showProgressBar)
	$progressID:=Progress New
	$total:=Num:C11(getKeyValue("KYC2020.QueryCount"; "100"))+1
	$complete:=0
	$title:="Recieving KYC2020 Data"
	$message:="Saving Summary..."
	Progress SET TITLE($progressID; $title; ($complete/$total); $message)
	Progress SET WINDOW VISIBLE(True:C214)
End if 

K20_recieveSearchSummary($catGroupName; $idFieldPtr; $name; $address; $identification; $date)

If ($showProgressBar)
	$message:="Saving details..."
	$complete:=$complete+1
	Progress SET PROGRESS($progressID; ($complete/$total); $message)
End if 
C_BOOLEAN:C305($pass)
If (OB Is defined:C1231([KYC2020Log:159]Response:14; "status"))
	
	If ([KYC2020Log:159]Response:14.status="OK")
		$pass:=True:C214
		C_OBJECT:C1216($item)
		C_OBJECT:C1216($details)
		$details:=New object:C1471
		For each ($item; [KYC2020Log:159]Response:14["smart-scan-summary"])
			C_TEXT:C284($refID)
			$refID:="Search Reference ID"
			If (OB Is defined:C1231($item; $refID))
				C_TEXT:C284($id)
				$id:=$item[$refID]
				$details[$id]:=K20_recieveRecordDetails($id)
			End if 
			If ($showProgressBar)
				$complete:=$complete+1
				Progress SET PROGRESS($progressID; $complete/$total)
			End if 
		End for each 
		[KYC2020Log:159]RecordDetails:17:=$details
		SAVE RECORD:C53([KYC2020Log:159])
	End if 
End if 

If ($showProgressBar)
	Progress QUIT($progressID)
	Progress SET WINDOW VISIBLE(False:C215)
End if 
If ($pass)
	K20_displaySearchResults
End if 