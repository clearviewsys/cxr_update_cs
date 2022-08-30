//%attributes = {}
// CheckSanctionCheckListSetIcon ($isForced; $name; $isEntity; $internalTableId; $internalRecordId; $iconPtr)
// Check name agains all sanction check lists and set the icon with the result
// Newer JSON Sanction List version: checkNameAgainstSanctionList


C_BOOLEAN:C305($1; $isForced)
C_TEXT:C284($2; $name)
C_BOOLEAN:C305($3; $isEntity)
C_LONGINT:C283($4; $internalTableId)
C_TEXT:C284($5; $internalRecordId)
C_POINTER:C301($6; $iconPtr)
C_TEXT:C284($7; $query)
C_POINTER:C301($8; $resultPtr)
C_POINTER:C301($9; $resultWithoutPEPPtr)
C_TEXT:C284($10; $autoList)
C_BOOLEAN:C305($11; $showInterface)
C_POINTER:C301($12; $fieldPtr)
C_LONGINT:C283($0)

$showInterface:=True:C214
$iconPtr:=Null:C1517

C_TEXT:C284($sanctionCheckResult; $tip)
C_LONGINT:C283($match)

Case of 
		
	: (Count parameters:C259=6)
		
		$isForced:=$1
		$name:=$2
		$isEntity:=$3
		$internalTableId:=$4
		$internalRecordId:=$5
		$iconPtr:=$6
	: (Count parameters:C259=7)
		
		$isForced:=$1
		$name:=$2
		$isEntity:=$3
		$internalTableId:=$4
		$internalRecordId:=$5
		$iconPtr:=$6
		$query:=$7
		
	: (Count parameters:C259=8)
		$isForced:=$1
		$name:=$2
		$isEntity:=$3
		$internalTableId:=$4
		$internalRecordId:=$5
		$iconPtr:=$6
		$query:=$7
		$resultPtr:=$8
		
	: (Count parameters:C259=9)
		$isForced:=$1
		$name:=$2
		$isEntity:=$3
		$internalTableId:=$4
		$internalRecordId:=$5
		$iconPtr:=$6
		$query:=$7
		$resultPtr:=$8
		$resultWithoutPEPPtr:=$9
		
	: (Count parameters:C259=10)
		$isForced:=$1
		$name:=$2
		$isEntity:=$3
		$internalTableId:=$4
		$internalRecordId:=$5
		$iconPtr:=$6
		$query:=$7
		$resultPtr:=$8
		$resultWithoutPEPPtr:=$9
		$autoList:=$10
		
		
	: (Count parameters:C259=11)
		$isForced:=$1
		$name:=$2
		$isEntity:=$3
		$internalTableId:=$4
		$internalRecordId:=$5
		$iconPtr:=$6
		$query:=$7
		$resultPtr:=$8
		$resultWithoutPEPPtr:=$9
		$autoList:=$10
		$showInterface:=$11
		
		
	: (Count parameters:C259=12)
		$isForced:=$1
		$name:=$2
		$isEntity:=$3
		$internalTableId:=$4
		$internalRecordId:=$5
		$iconPtr:=$6
		$query:=$7
		$resultPtr:=$8
		$resultWithoutPEPPtr:=$9
		$autoList:=$10
		$showInterface:=$11
		$fieldPtr:=$12
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tip:=""
clearPictureField($iconPtr)
OBJECT SET HELP TIP:C1181($iconPtr; $tip)

If (stringHasMinimumLength($name; 3))
	Case of 
		: (getKeyValue("sanctionlist.version"; "v2")="KYC2020")
			If ($autoList="PEP")
				K20_handleCustomerCompliance("All PEP"; $fieldPtr; $name)
			Else 
				K20_handleCustomerCompliance("All Sanction"; $fieldPtr; $name)
			End if 
		: (getKeyValue("sanctionlist.version"; "v2")="v1")
			If ($isForced)
				$sanctionCheckResult:=checkNameAgainstAllLists($name; ->$match; $isEntity; $internalTableId; $internalRecordId; $isForced)  //  Force checking in sanction lists
			Else 
				$sanctionCheckResult:=checkNameAgainstAllLists($name; ->$match; $isEntity; $internalTableId; $internalRecordId)  // Use the server preference for checking in sanction lists
			End if 
			
			showSanctionCheckAlert($match; $sanctionCheckResult)
			sl_setSanctionListCheckIcon($match; $iconPtr)
			$0:=$match
			If ($resultPtr#Null:C1517)
				$resultPtr->:=$sanctionCheckResult
			End if 
		Else 
			If ($isForced | <>doCheckSanctionLists)
				
				// runAndViewSanctionChecks Arguments:
				C_TEXT:C284($_1; $_5; $_7)
				C_LONGINT:C283($_2; $_4)
				C_COLLECTION:C1488($_3)
				C_POINTER:C301($_6; $_8)
				C_BOOLEAN:C305($_9)
				$_1:=$name
				If ($isEntity)
					$_2:=2
				Else 
					$_2:=1
				End if 
				C_OBJECT:C1216($collection)
				// #ORDA
				If ($query="")
					//$collection:=ds.SanctionLists.query("IsEnabled = true")
					$collection:=ds:C1482.SanctionLists.query("IsEnabled = true AND isPEP = false")
					//7/15/22 ibb added to force PEP to be handled independently
				Else 
					$collection:=ds:C1482.SanctionLists.query("ShortName = :1 and IsEnabled = true"; $query)
				End if 
				If (Not:C34($isForced))
					If ($autoList="")
						$collection:=$collection.query("isManual = false")
					Else 
						C_LONGINT:C283($value)
						C_OBJECT:C1216($remove)
						$remove:=ds:C1482.SanctionLists.newSelection()
						C_OBJECT:C1216($entity)
						For each ($entity; $collection)
							If ($entity.isManual)
								
								$value:=$entity.automaticFlags
								//If (Not(sl_isAutoScreeningForTable(->$value; $autoList)))
								//$remove.add($entity)
								//End if 
							End if 
						End for each 
						$collection.minus($remove)
					End if 
				End if 
				
				$_3:=$collection.ShortName
				$_4:=$internalTableId
				$_5:=$internalRecordId
				$_6:=$iconPtr
				$_8:=$resultWithoutPEPPtr
				$_9:=$showInterface
				If ($collection.length>0)
					$0:=runAndViewSanctionChecks($_1; $_2; $_3; $_4; $_5; $_6; ->$_7; $_8; $_9)
					If ($resultPtr#Null:C1517)
						$resultPtr->:=$_7
					End if 
				End if 
			End if 
	End case 
End if 
