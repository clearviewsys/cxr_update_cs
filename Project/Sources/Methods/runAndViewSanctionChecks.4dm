//%attributes = {}
// runAndViewSanctionChecks
// To be run in a worker process
// Author: Wai-Kin

C_TEXT:C284($1; $name)
C_REAL:C285($2; $nameType)
C_COLLECTION:C1488($3; $useLists)
C_LONGINT:C283($4; $tableNum)
C_TEXT:C284($5; $recordId)
C_POINTER:C301($6; $indicatorPtr)
C_POINTER:C301($7; $resultsPtr)
C_POINTER:C301($8; $resultWithoutPEP)
C_BOOLEAN:C305($9; $showInterface)
C_LONGINT:C283($0; $finalStatus)

$indicatorPtr:=Null:C1517
$resultsPtr:=Null:C1517

Case of 
	: (Count parameters:C259=3)
		$name:=$1
		$nameType:=$2
		$useLists:=$3
		
	: (Count parameters:C259=5)
		$name:=$1
		$nameType:=$2
		$useLists:=$3
		$tableNum:=$4
		$recordId:=$5
		
	: (Count parameters:C259=6)
		$name:=$1
		$nameType:=$2
		$useLists:=$3
		$tableNum:=$4
		$recordId:=$5
		$indicatorPtr:=$6
		
	: (Count parameters:C259=7)
		$name:=$1
		$nameType:=$2
		$useLists:=$3
		$tableNum:=$4
		$recordId:=$5
		$indicatorPtr:=$6
		$resultsPtr:=$7
		
	: (Count parameters:C259=8)
		$name:=$1
		$nameType:=$2
		$useLists:=$3
		$tableNum:=$4
		$recordId:=$5
		$indicatorPtr:=$6
		$resultsPtr:=$7
		$resultWithoutPEP:=$8
		
	: (Count parameters:C259=9)
		$name:=$1
		$nameType:=$2
		$useLists:=$3
		$tableNum:=$4
		$recordId:=$5
		$indicatorPtr:=$6
		$resultsPtr:=$7
		$resultWithoutPEP:=$8
		$showInterface:=$9
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BOOLEAN:C305($progressBar)
$progressBar:=True:C214

C_OBJECT:C1216($searchLists)  // #ORDA
$searchLists:=ds:C1482.SanctionLists.query("ShortName in :1"; $useLists)

C_OBJECT:C1216($form)
C_COLLECTION:C1488($results)
$finalStatus:=0
C_REAL:C285($listStatus)
$results:=New collection:C1472

C_BOOLEAN:C305($requestListContinue)
$requestListContinue:=True:C214
If ($progressBar)
	C_REAL:C285($requestListCount; $requestListTotal)
	$requestListCount:=0
	$requestListTotal:=$searchLists.length
	C_LONGINT:C283($requestListProgress)
	$requestListProgress:=Progress New
	Progress SET WINDOW VISIBLE(True:C214)
	Progress SET PROGRESS($requestListProgress; 0)
	Progress SET MESSAGE($requestListProgress; "Completed 0 of "+String:C10($requestListTotal))
	Progress SET BUTTON ENABLED($requestListProgress; True:C214)
End if 

C_OBJECT:C1216($searchList)
For each ($searchList; $searchLists) While ($requestListContinue)
	If ($progressBar)
		C_REAL:C285($requestListPrecent)
		$requestListPrecent:=$requestListCount/$requestListTotal
		Progress SET TITLE($requestListProgress; "Checking on sanction list: "+$searchList.ShortName)
		Progress SET PROGRESS($requestListProgress; $requestListPrecent)
		Progress SET MESSAGE($requestListProgress; "Completed "+String:C10($requestListCount)+" of "+String:C10($requestListTotal))
		$requestListCount:=$requestListCount+1
		//DELAY PROCESS(Current process;40)
		$requestListContinue:=Not:C34(Progress Stopped($requestListProgress))
	End if 
	
	C_OBJECT:C1216($checkOutput)
	C_TEXT:C284($result)
	$checkOutput:=requestAndLogSanctionListCheck($name; $nameType; $searchList; $tableNum; $recordId; ->$result)
	If ($resultsPtr#Null:C1517)
		If (Length:C16($resultsPtr->)#0)
			$resultsPtr->:=$resultsPtr->+CRLF
		End if 
		If (Length:C16($result)#0)
			$resultsPtr->:=$resultsPtr->+$searchList.ShortName+": "+$result
		End if 
		
	End if 
	If ($resultWithoutPEP#Null:C1517)
		If (($result#"") & (Not:C34($searchList.isPEP)))
			If (Length:C16($resultWithoutPEP->)#0)
				$resultWithoutPEP->:=$resultWithoutPEP->+CRLF
			End if 
			$resultWithoutPEP->:=$resultWithoutPEP->+$searchList.ShortName+": "+$result
		End if 
	End if 
	$results.push($checkOutput)
	C_REAL:C285($listStatus)
	$listStatus:=$checkOutput.CheckResult
	Case of 
		: ($finalStatus=0)
			If ($listStatus#0)
				$finalStatus:=$listStatus
			End if 
		: ($finalStatus=1)
			If ($listStatus=-1)
				$finalStatus:=$listStatus
			End if 
	End case   // $finalStatus
End for each   //  $searchList;$searchLists)

If ($progressBar)
	Progress SET WINDOW VISIBLE(False:C215)
	Progress QUIT($requestListProgress)
End if   // $progressBar

If ($indicatorPtr#Null:C1517)
	sl_setSanctionListCheckIcon($finalStatus; $indicatorPtr)
End if 
C_TEXT:C284($message)
If ($finalStatus#0)
	If ($showInterface)
		displaySanctionListResults($name; $nameType; New object:C1471("results"; $results))
	End if 
End if 
//End if
$0:=$finalStatus