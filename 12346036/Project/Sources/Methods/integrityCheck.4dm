//%attributes = {}
// integrityCheck(->[TABLE]; "integritycheckname";description;->dateField; allRecords; ->branch; BranchID)
// e.g.: integrityCheck(->[invoices];"IC_invoiceBalance")

C_POINTER:C301($tablePtr; $1; $4; $dateFieldPtr)
C_TEXT:C284($integrityCheckString; $2; $description; $3)
C_BOOLEAN:C305($allRecords; $5)
C_POINTER:C301($branchPtr; $6)
C_TEXT:C284($branchID; $7)

C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(cbApplyDateRange)
C_BOOLEAN:C305($hasDate)
$hasDate:=False:C215
$tablePtr:=$1
$integrityCheckString:=$2
$description:=$3
$branchID:=""
Case of 
	: (Count parameters:C259=3)
		$hasDate:=False:C215
		$allRecords:=True:C214
	: (Count parameters:C259=4)
		$hasDate:=(cbApplyDateRange=1)
		$dateFieldPtr:=$4
		$allRecords:=True:C214
	: (Count parameters:C259=5)
		$hasDate:=(cbApplyDateRange=1)
		$dateFieldPtr:=$4
		$allRecords:=$5
	: (Count parameters:C259=7)
		$hasDate:=(cbApplyDateRange=1)
		$dateFieldPtr:=$4
		$allRecords:=$5
		$branchPtr:=$6
		$branchID:=$7
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Semaphore:C143(getSemaphoreName($tablePtr)))
	notifyAlert("Concurrent Update Error!"; Table name:C256($tablePtr)+" is being updated by another process at this time. Please try again later."; 10)
Else 
	//ALERT("This integrity check verifies that "+$description+".")
	If ($allRecords)
		ALL RECORDS:C47($tablePtr->)
	End if 
	
	If ($hasDate)
		selectDateRangeTable($tablePtr; $dateFieldPtr; vFromDate; vToDate; True:C214)
	End if 
	
	If (($branchID#"") & (Count parameters:C259>=7))  // if the branch ID is not null, then search on branch ID
		QUERY SELECTION:C341($tablePtr->; $branchPtr->=$branchID)
	End if 
	
	
	
	READ ONLY:C145($tablePtr->)
	FIRST RECORD:C50($tablePtr->)
	
	CREATE EMPTY SET:C140($tablePtr->; "IntegrityLackingRecords")
	C_LONGINT:C283($n)
	$n:=Records in selection:C76($tablePtr->)
	
	//setProgressBarIterations ($progress;$n)
	
	C_LONGINT:C283($i)
	$i:=1
	
	If ($n>0)
		
		C_LONGINT:C283($progress)
		$progress:=launchProgressBar("Integrity Checking...")
		
		Repeat 
			LOAD RECORD:C52($tablePtr->)
			If (Not:C34(IntegrityCheckRow($integrityCheckString)))  // integrity check FAILED
				ADD TO SET:C119($tablePtr->; "IntegrityLackingRecords")
				createIC_FailedRecord($tablePtr; $integrityCheckString)
				CREATE RELATED ONE:C65([IC_FailedRecords:49]IntegrityCheckID:1)
				[IntegrityChecks:48]IntegrityCheckID:1:=$integrityCheckString
				[IntegrityChecks:48]Description:2:=$description
				SAVE RELATED ONE:C43([IC_FailedRecords:49]IntegrityCheckID:1)
			End if 
			NEXT RECORD:C51($tablePtr->)
			
			If (Mod:C98($i; 100)=0)
				refreshProgressBar($progress; $i; $n)
				setProgressBarTitle($progress; "Check ID: "+$integrityCheckString+". Rec # "+String:C10($i)+"/"+String:C10($n))
			End if 
			
			$i:=$i+1
		Until (($i>$n) | (isProgressBarStopped($progress)))
		HIDE PROCESS:C324($progress)
		USE SET:C118("IntegrityLackingRecords")
		FIRST RECORD:C50($tablePtr->)
		
		CLEAR SET:C117("IntegrityLackingRecords")
		CLEAR SEMAPHORE:C144(getSemaphoreName($tablePtr))
	End if 
End if 
