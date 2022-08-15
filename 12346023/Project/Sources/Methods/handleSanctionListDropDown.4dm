//%attributes = {}
// handleSanctionListMenu($listObjectName;$statusDisplayName;$internalTableID;$internalRecordID;$firstName;$lastName;{$details;{$forced}})
// Should be call by prepCustomerSanctionChecks
// Uses Events: OnLoad and OnClick
// Author: Wai-Kin


// handle sanction list for combobox named $listObjectName that display a status picture name $statusDisplayName

C_TEXT:C284($0)
C_TEXT:C284($1; $listObjectName)
C_TEXT:C284($2; $statusDisplayName)
C_REAL:C285($3; $internalTableID)
C_TEXT:C284($4; $internalRecordID)
C_TEXT:C284($5; $firstName)
C_TEXT:C284($6; $lastName)
C_OBJECT:C1216($7; $details)
C_BOOLEAN:C305($8; $forced)

C_TEXT:C284($newPrefix; $MCHK; $listName; $result)

Case of 
	: (Count parameters:C259=6)
		$listObjectName:=$1
		$statusDisplayName:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$firstName:=$5
		$lastName:=$6
		$details:=New object:C1471
		$forced:=<>doCheckSanctionLists
	: (Count parameters:C259=7)
		$listObjectName:=$1
		$statusDisplayName:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$firstName:=$5
		$lastName:=$6
		$details:=$7
		$forced:=<>doCheckSanctionLists
	: (Count parameters:C259=8)
		$listObjectName:=$1
		$statusDisplayName:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$firstName:=$5
		$lastName:=$6
		$details:=$7
		$forced:=$8
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$newPrefix:=""
ARRAY TEXT:C222($display; 0)

C_TEXT:C284($line; $noneEnabled)
$line:="═════════════════"
$noneEnabled:="No Sanction List Enabled"

C_BOOLEAN:C305($filled)
$filled:=False:C215

$MCHK:=getKeyValue("MemberCheck.Status")
If (($MCHK="demo") | ($MCHK="app"))
	APPEND TO ARRAY:C911($display; "Member Check")
	$filled:=True:C214
End if 

If (Size of array:C274($display)>0)
	APPEND TO ARRAY:C911($display; $line)
End if 


// #ORDA (1 of 2)
C_COLLECTION:C1488($listNames)
$listNames:=ds:C1482.SanctionLists.query("IsEnabled = True and ShortName # 'PEP'").ShortName
For each ($list; $listNames)
	APPEND TO ARRAY:C911($display; $list)
End for each 

If ($listNames.length#0)
	APPEND TO ARRAY:C911($display; $line)
	APPEND TO ARRAY:C911($display; "Sanction List")
	$filled:=True:C214
End if 

// #ORDA (2 of 2)
If (ds:C1482.SanctionLists.query("IsEnabled = True and ShortName = 'PEP'").length#0)
	APPEND TO ARRAY:C911($display; "PEP")
	$filled:=True:C214
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Not:C34($filled))
			APPEND TO ARRAY:C911($display; $line)
			APPEND TO ARRAY:C911($display; $noneEnabled)
			APPEND TO ARRAY:C911($display; $line)
		End if 
		
		C_LONGINT:C283($list)
		$list:=New list:C375
		ARRAY TO LIST:C287($display; $list)
		OBJECT SET LIST BY REFERENCE:C1266(*; $listObjectName; $list)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($continue)
		$continue:=$forced
		
		If ($continue)
			If (OB Is defined:C1231($details; "AML_isWhitelisted") & OB Is defined:C1231($details; "AML_WhitelistExpiryDate"))
				C_DATE:C307($expiryDate)
				$expiryDate:=Date:C102($details.AML_WhitelistExpiryDate)
				If ($details.AML_isWhitelisted & ($expiryDate#!00-00-00!))
					$continue:=$details.AML_WhitelistExpiryDate>Current date:C33(*)
				End if 
			End if 
		End if 
		
		If ($continue)
			$continue:=(Length:C16($firstName)+Length:C16($lastName)+1)>=3
		End if 
		
		If ($continue)
			C_REAL:C285($value)
			$value:=OBJECT Get pointer:C1124(Object named:K67:5; $listObjectName)->
			C_TEXT:C284($version)
			$version:=$display{$value}
			
			C_REAL:C285($match)
			C_POINTER:C301($statusPicturePtr)
			$statusPicturePtr:=OBJECT Get pointer:C1124(Object named:K67:5; $statusDisplayName)
			clearPictureField($statusPicturePtr)
			Case of 
					
				: ($version="Sanction List")  //Sanction List
					C_TEXT:C284($name)
					$name:=makeFullName($firstName; $lastName)
					
					slold_screenPerson(True:C214)
					
					
				: ($version="Member Check")  // MemberCheck
					$match:=mchk_checkCustomerEntity($firstName; $lastName; $internalTableID; $internalRecordID; $details)
					sl_setSanctionListCheckIcon($match; $statusPicturePtr)
				: ($version=$line)
					
				Else 
					If (($version#$line) & ($version#$noneEnabled))
						
						C_TEXT:C284($name)
						$listName:=$version
						$name:=makeFullName($firstName; $lastName)
						slold_screenCompany(True:C214; $name; ->[Customers:3]CustomerID:1; New object:C1471(\
							"options"; New object:C1471("list"; $listName)\
							))
					End if 
			End case 
		End if 
End case 