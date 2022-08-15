//%attributes = {}
// checkNameAgainstAllLists ($fullName, ->match; $isEntity; $tableNum; $internalRecordID; $force) : text
// match is 0: no match
// match is 1: exact match
// match is 2: possible match (similar name found)

//
// Searches a person or an entity name in all enabled sanction lists. 

// Return Value:(type: string) Examples:
// Search result: if the name or similar name is found.
//                Invalid Client!": if user’s credentials are not correct.
//                Not Authorized!": if user has no/expired license
//                Empty string(""): if the search fails (not in the list)

// newer JSON version: checkInputToSanctionLists

//Unit test not complete

C_TEXT:C284($1; $fullName)
C_POINTER:C301($matchPtr; $2)
C_BOOLEAN:C305($3; $isEntity; $isExactMath)
C_LONGINT:C283($4; $tableNum)
C_TEXT:C284($5; $internalRecordID)
C_BOOLEAN:C305($6; $isForced)  // to force checking of the sanction list
C_TEXT:C284($0; $sanctionCheckTextResult; $list; $listSep2; $listSep; $result)

C_DATE:C307($dateRef)
C_TIME:C306($timeRef)

ARRAY TEXT:C222($arrShortName; 0)
ARRAY TEXT:C222($arrDescription; 0)
C_LONGINT:C283($checkResult; $countFailed; $i; $n)
C_BOOLEAN:C305($matchFailed)

$isExactMath:=False:C215
$matchFailed:=False:C215
$countFailed:=0

$sanctionCheckTextResult:=""
$isEntity:=False:C215
$tableNum:=0
$internalRecordID:=""


READ ONLY:C145([ServerPrefs:27])
ALL RECORDS:C47([ServerPrefs:27])
<>doCheckSanctionLists:=[ServerPrefs:27]doCheckSanctionLists:63
UNLOAD RECORD:C212([ServerPrefs:27])
REDUCE SELECTION:C351([ServerPrefs:27]; 0)

$isForced:=<>doCheckSanctionLists

Case of 
		
	: (Count parameters:C259=2)
		
		$fullName:=$1
		$matchPtr:=$2
		
	: (Count parameters:C259=3)
		
		$fullName:=$1
		$matchPtr:=$2
		$isEntity:=$3
		
	: (Count parameters:C259=5)
		
		$fullName:=$1
		$matchPtr:=$2
		$isEntity:=$3
		$tableNum:=$4
		$internalRecordID:=$5
		
	: (Count parameters:C259=6)
		
		$fullName:=$1
		$matchPtr:=$2
		$isEntity:=$3
		$tableNum:=$4
		$internalRecordID:=$5
		$isForced:=$6
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
$0:=""
$matchPtr->:=-2


C_TEXT:C284($searchType)
C_LONGINT:C283($ProgressID)
C_BOOLEAN:C305($checkSuccessful)


If ($isForced)
	
	If ($isEntity)
		$searchType:="ENTITY"
	Else 
		$searchType:="PERSON"
	End if 
	
	// Verify if the name was searched previously using the number of hours defined in preferences
	$dateRef:=Current date:C33(*)
	$timeRef:=Current time:C178(*)
	
	goBackNHours(<>limitToRecheckSanctionList; ->$dateRef; ->$timeRef)
	
	READ ONLY:C145([SanctionCheckLog:111])
	QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]CheckDate:3>=$dateRef; *)
	QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]ResponseJSON:17=Null:C1517)  // skip version 2
	QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]FullName:9=$fullName)
	QUERY SELECTION:C341([SanctionCheckLog:111]; [SanctionCheckLog:111]CheckTime:4<=$timeRef)
	ORDER BY:C49([SanctionCheckLog:111]; [SanctionCheckLog:111]CheckResult:10; <)
	
	If (Records in selection:C76([SanctionCheckLog:111])>0)
		// There is a record into the log in the last 24 hours (preference)
		FIRST RECORD:C50([SanctionCheckLog:111])
		
		If ([SanctionCheckLog:111]CheckResult:10#0)
			$0:=[SanctionCheckLog:111]ResponseText:6
		End if 
		$matchPtr->:=[SanctionCheckLog:111]CheckResult:10
		
	Else 
		
		
		READ ONLY:C145([SanctionLists:113])
		QUERY:C277([SanctionLists:113]; [SanctionLists:113]IsEnabled:4=True:C214)
		SELECTION TO ARRAY:C260([SanctionLists:113]ShortName:2; $arrShortName; [SanctionLists:113]Description:3; $arrDescription)
		
		$listSep:=""
		$listSep:=$listSep+"------------------------------------------------------------------"+CRLF
		$listSep:=$listSep+"<List>: <Description>"+CRLF
		$listSep:=$listSep+"------------------------------------------------------------------"
		$result:=""
		
		
		$n:=Size of array:C274($arrShortName)
		
		$ProgressID:=Progress New
		Progress SET BUTTON ENABLED($ProgressID; True:C214)
		
		For ($i; 1; $n)
			$list:=$arrShortName{$i}
			
			Progress SET TITLE($ProgressID; "Checking on sanction list: "+$list)
			Progress SET PROGRESS($ProgressID; $i/$n)
			Progress SET MESSAGE($ProgressID; "Percent: "+String:C10(100*$i/100)+" %")
			
			$listSep2:=Replace string:C233($listSep; "<List>"; $list)
			$listSep2:=Replace string:C233($listSep2; "<Description>"; $arrDescription{$i})
			
			If (Not:C34(Progress Stopped($ProgressID)))
				
				$sanctionCheckTextResult:=checkNameAgainstList($fullName; ->$checkResult; $isEntity; $list; $isForced)
				$checkSuccessful:=Not:C34((Position:C15("Error"; $sanctionCheckTextResult)>0))
				If (Position:C15("Limit"; $sanctionCheckTextResult)>0)
					$checkResult:=-1
					$checkSuccessful:=False:C215
				End if 
				createSanctionCheckLogRecord($fullName; $tableNum; $internalRecordID; getApplicationUser; $list; $sanctionCheckTextResult; $checkSuccessful; $checkResult; $isEntity; Current date:C33(*); Current time:C178(*))
				
				If (Not:C34($isExactMath))
					$isExactMath:=($checkResult=2)
				End if 
				
				If ($checkResult=-1)
					$countFailed:=$countFailed+1
				End if 
				
				If ($sanctionCheckTextResult#"")
					$result:=$result+$listSep2+CRLF+$sanctionCheckTextResult+CRLF
				End if 
				
				If (Position:C15("Limit"; $sanctionCheckTextResult)>0)
					myAlert($sanctionCheckTextResult)
				End if 
				
				If ($checkSuccessful=False:C215)  // Error after calling Sanction List?
					$i:=$n+1  // Exit loop
				End if 
				
				
			Else 
				$i:=$n+1
			End if 
			
		End for 
		Progress SET WINDOW VISIBLE(False:C215)
		Progress QUIT($ProgressID)
		
		
		If ($isExactMath)
			$matchPtr->:=2
		Else 
			$matchPtr->:=getMatchType($result)
		End if 
		
		If ($countFailed=Size of array:C274($arrDescription))
			$matchPtr->:=-1
		End if 
		
		If ($internalRecordID#"")
			getAllCheckLogByID($tableNum; $internalRecordID)
		End if 
		
		$0:=$result
	End if 
	
End if 
