//%attributes = {}
// checkInputToSanctionLists($inputs;$searchLists;{$statusPtr;{$forced;{$allowHold}}}))
// see also checkNameAgainstSanctionList 
//
// Check name against sanction lists and format it and show it in a form as neccessary
//
// Parameters:
// $input (C_OBJECT)
//     List of inputs to check against in the format {"field"="value","field"="value",...} (all in string format)
//     Required fields:
//        name     = Name to match, such as [Customers]FullName
//        isEntity = is the individual is a individual (false) or a organization (true)
//     Required for logging:
//        internalTableId = the id of the table (for [SanctionCheckLog]internalTableID)
//        internalRecordId = the record id of the table (for [SanctionCheckLog]InternalRecordID)
// $searchLists (C_COLLECTION)
//     List of Sanction list to check
// $statusPtr (C_POINTER)
//     The status of the result, use with SetSanctionListCheckIcon and sl_getSanctionListResultMsg
// $forced (B_BOOLEAN)
//     Is doing the test or not, defualt to options
// $allowHolde (C_BOOLEAN)
//     Check if the user is able to set hold or not
// 
// This is what being send to display:
//     Format:
//     {
//       "name"      = C_TEXT (name to check)
//       "isEntity"  = C_TEXT (is this a company or an person)
//       "matched:   = C_REAL (number of check and matching rows),
//       "check"     = C_REAL (number of checked and not matching rows),
//       "unckecked" = C_REAL (number of unchecked rows),
//       "result"    = C_TEXT (result of the sanction check, editable by user)
//       "lists"     = 
//       [
//          "type"    = C_TEXT (list status in text: ERROR, MATCHED, GOOD),
//          "emoji"   = C_TEXT (emoji version of "type"),
//          "message" = C_TEXT (details of the status),
//          "items"   = 
//          [
//            "fullname"   = C_TEXT (full name of the item),
//            "type"       = C_TEXT (type of name match: "Extact", "Similar"),
//            "properties" =
//            [
//               "key"   = C_TEXT (the property key name),
//               "value" = C_TEXT (the property data value),
//               "match" = C_TEXT (type of matches: "Matched", "Unmatched", "Unchecked", "Ignored"),
//               "style" = C_REAL (font type of the match, use in handleSanctionListMatches and handleListMovement),
//               "color" = C_REAL (font color of the match, use in handleSanctionListMatches and handleListMovement)
//            ]
//          ]
//       ]
//       $showHold = C_BOOLEAN (show hold related panel)
//     }
//
// Returns: (C_TEXT)
//     The reason to hold the Customer
// Author: Wai-Kin

C_TEXT:C284($0; $holdMessage)
C_OBJECT:C1216($1; $inputs)
C_COLLECTION:C1488($2; $searchLists)
C_POINTER:C301($3; $statusPtr)
C_BOOLEAN:C305($4; $forced)
C_POINTER:C301($5; $onHold)
C_BOOLEAN:C305($6; $allowHold)
C_POINTER:C301($detailsPtr)
C_REAL:C285($status)
Case of 
	: (Count parameters:C259=2)
		$inputs:=$1
		$searchLists:=$2
		$statusPtr:=->$status
		$forced:=<>doCheckSanctionLists
		$onHold:=Null:C1517
		$detailsPtr:=Null:C1517
		$allowHold:=True:C214
	: (Count parameters:C259=3)
		$inputs:=$1
		$searchLists:=$2
		$statusPtr:=$3
		$forced:=<>doCheckSanctionLists
		$onHold:=Null:C1517
		$allowHold:=True:C214
	: (Count parameters:C259=4)
		$inputs:=$1
		$searchLists:=$2
		$statusPtr:=$3
		$forced:=$4
		$onHold:=Null:C1517
		$allowHold:=True:C214
	: (Count parameters:C259=5)
		$inputs:=$1
		$searchLists:=$2
		$statusPtr:=$3
		$forced:=$4
		$onHold:=$5
		$allowHold:=True:C214
	: (Count parameters:C259=6)
		$inputs:=$1
		$searchLists:=$2
		$statusPtr:=$3
		$forced:=$4
		$onHold:=$5
		$allowHold:=$6
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BOOLEAN:C305($canLog)
$canLog:=OB Is defined:C1231($inputs; "internalTableId") & OB Is defined:C1231($inputs; "internalRecordId")

C_OBJECT:C1216($root)
$root:=New object:C1471
$root.lists:=New collection:C1472
$root.name:=$inputs.name
$root.isEntity:=$inputs.isEntity
$statusPtr->:=0  //assume passed
$status:=0
$holdMessage:=""

// Progress bar for the lists
C_REAL:C285($listCount; $listTotal)
$listCount:=0
$listTotal:=$searchLists.count()
C_LONGINT:C283($progressId)
$progressId:=Progress New
Progress SET WINDOW VISIBLE(True:C214)
Progress SET PROGRESS($progressId; 0)
Progress SET MESSAGE($progressId; "Completed 0 of "+String:C10($listTotal))
Progress SET BUTTON ENABLED($progressId; True:C214)

C_BOOLEAN:C305($requestLists)
$requestLists:=True:C214
C_OBJECT:C1216($logEntities)
$logEntities:=ds:C1482.SanctionCheckLog.newSelection()

C_TEXT:C284($list)
For each ($list; $searchLists) While ($requestLists)  // For lists
	C_BOOLEAN:C305($isLogging)
	$isLogging:=$canLog
	C_TEXT:C284($sanctionList)
	$sanctionList:=$list
	// Update the progress
	C_REAL:C285($listPrecent)
	$listPrecent:=$listCount/$listTotal
	Progress SET TITLE($progressId; "Checking on sanction list: "+$sanctionList)
	Progress SET PROGRESS($progressId; $listPrecent)
	Progress SET MESSAGE($progressId; "Completed "+String:C10($listCount)+" of "+String:C10($listTotal))
	$listCount:=$listCount+1
	//DELAY PROCESS(Current process;10) // For progress bar checking
	
	$requestLists:=Not:C34(Progress Stopped($progressId))
	
	// Get the result for one list
	C_OBJECT:C1216($rawMatches)
	C_TEXT:C284($rawStatus; $query)
	$rawMatches:=requestSanctionsListsForName($inputs.name; ->$rawStatus; $inputs.isEntity; $sanctionList; $forced)
	
	// check for old checks
	If ($rawMatches=Null:C1517)
		If ($canLog)
			// #ORDA
			C_OBJECT:C1216($logs)
			$query:="internalTableID = :1 and InternalRecordID = :2 and SanctionList = :3"
			$internalTableId:=$inputs.internalTableId
			$internalFieldID:=$inputs.internalRecordId
			$logs:=ds:C1482.SanctionCheckLog.query($query; $internalTableId; $internalFieldID; $list)
			If ($logs.length>0)
				C_OBJECT:C1216($log)
				$log:=$logs.orderBy("CheckDate desc, CheckTime desc")[0]
				$statusPtr->:=$log.CheckResult
				$rawMatches:=$log.ResponseJSON
				$rawStatus:=$log.ResponseText
			End if 
		End if 
		$isLogging:=False:C215
	End if 
	
	// Create a new result list
	C_OBJECT:C1216($result)
	$result:=New object:C1471
	$root.lists.push($result)
	$result.name:=$sanctionList
	
	Case of 
			
			//Error result
		: (Position:C15("ERROR"; $rawStatus)=1)
			$result.type:="ERROR"
			$result.emoji:="⚠"
			$result.message:=$rawStatus
			$result.items:=New collection:C1472
			$holdMessage:="Some sanction lists matching failed to complete."
			$statusPtr->:=1
			$status:=1
			
			// Match result
		: (Position:C15("ALERT"; $rawStatus)=1)
			C_COLLECTION:C1488($items)
			$items:=New collection:C1472
			
			// Progress for items
			C_REAL:C285($itemsCount; $itemsTotal)
			C_LONGINT:C283($itemProgress)
			$itemsCount:=0
			$itemsTotal:=$rawMatches.Blacklist.count()
			$itemProgress:=Progress New
			Progress SET TITLE($itemProgress; "Format and checking list")
			Progress SET BUTTON ENABLED($itemProgress; True:C214)
			
			C_REAL:C285($similarMatches; $exactMatches)
			$similarMatches:=0
			$exactMatches:=0
			
			C_BOOLEAN:C305($addItem)
			$addItem:=True:C214
			C_OBJECT:C1216($rawItem)
			For each ($rawItem; $rawMatches.Blacklist) While ($addItem)  // For lists.items
				// Update the progress bar
				C_REAL:C285($itemsPrecentage)
				$itemsPrecentage:=$itemsCount/$itemsTotal
				Progress SET PROGRESS($itemProgress; $itemsPrecentage)
				$itemsPrecentage:=$itemsPrecentage*100
				Progress SET MESSAGE($itemProgress; "Checking entity: "+String:C10($itemsPrecentage; "##0.00")+"%")
				//DELAY PROCESS(Current process;20) // For progress bar checking
				$itemsCount:=$itemsCount+1
				
				$addItem:=Not:C34(Progress Stopped($itemProgress))
				
				C_OBJECT:C1216($item)
				$item:=refomatSanctionList($rawItem)
				$items.push($item)
				
				If ($status#-1)
					Case of 
						: ($item.type="SIMILAR")
							If ($status#2)
								$statusPtr->:=1
								$status:=1
							End if 
						: ($item.type="EXACT")
							$statusPtr->:=2
							$status:=2
					End case 
				End if 
				Case of 
					: ($item.type="SIMILAR")
						$similarMatches:=$similarMatches+1
					: ($item.type="EXACT")
						$exactMatches:=$exactMatches+1
				End case 
				
			End for each 
			Progress QUIT($itemProgress)
			
			$result.type:="MATCHED"
			$result.emoji:="❌"
			$result.message:="ALERT: "+String:C10($exactMatches)+" exact match(es) and "+String:C10($similarMatches)+" possible match(es)."
			$result.items:=$items
			
			If ($holdMessage="")
				$holdMessage:="One or more matches are found in the sanction lists."
			End if 
		Else 
			$result.type:="GOOD"
			$result.emoji:="✔"
			$result.message:=$rawStatus
			$result.items:=New collection:C1472
	End case 
	
	If ($isLogging)
		
		C_DATE:C307($checkDate)
		C_TIME:C306($checkTime)
		$checkDate:=Current date:C33(*)
		$checkTime:=Current time:C178(*)
		C_TEXT:C284($userID)
		$userID:=getApplicationUser  //<>ApplicationUser
		C_TEXT:C284($internalFieldID)
		$internalFieldID:=$inputs.internalRecordId
		C_BOOLEAN:C305($isSuccessful)
		$isSuccessful:=$result.type#"ERROR"
		C_TEXT:C284($responseText)
		If ($result.type#"GOOD")
			$responseText:=$result.message
		End if 
		C_REAL:C285($checkResult)
		$checkResult:=$status
		Case of 
			: ($result.type="GOOD")
				$checkResult:=0
			: ($result.type="ERROR")
				$checkResult:=-1
			Else 
				$checkResult:=1
		End case 
		C_TEXT:C284($fullName)
		$fullName:=$inputs.name
		C_LONGINT:C283($internalTableId)
		$internalTableId:=$inputs.internalTableId
		C_BOOLEAN:C305($isEntity)
		$isEntity:=$inputs.isEntity
		C_OBJECT:C1216($reportJSON)
		$reportJSON:=$rawMatches
		createSanctionCheckLogRecord($fullName; $internalTableId; $internalFieldID; $userID; $sanctionList; $responseText; $isSuccessful; $checkResult; $isEntity; $checkDate; $checkTime; $reportJSON)
	End if 
	
End for each 
Progress SET WINDOW VISIBLE(False:C215)
Progress QUIT($progressID)

C_POINTER:C301($detailsPtr)
$root.result:=$holdMessage

If ($detailsPtr#Null:C1517)
	$detailsPtr->:=$root
End if 
If ($onHold#Null:C1517)
	$onHold->:=False:C215
End if 
C_LONGINT:C283($winRef)
$0:=""
If ($status#0)
	$winRef:=Open form window:C675("SanctionList")
	DIALOG:C40("SanctionList"; $root)
	CLOSE WINDOW:C154($winRef)
	If ($onHold#Null:C1517)
		$onHold->:=OK=1
	End if 
	If (OK=1)
		$0:=$root.result
	End if 
End if 
