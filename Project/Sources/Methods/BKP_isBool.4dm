//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:25:43

// ----------------------------------------------------

// Method: BKP_isBool

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_TEXT:C284($1)
C_BOOLEAN:C305($0)

ARRAY TEXT:C222($aBoolValues; 19)
$aBoolValues{1}:="WaitForEndOfTransaction"
$aBoolValues{2}:="TryBackupAtTheNextScheduledDate"
$aBoolValues{3}:="AutomaticRestore"
$aBoolValues{4}:="AutomaticLogIntegration"
$aBoolValues{5}:="AutomaticRestart"
$aBoolValues{6}:="BackupIfDataChange"
$aBoolValues{7}:="SetNumber_Enable"
$aBoolValues{8}:="EraseOldBackupBefore"
$aBoolValues{9}:="IncludeStructureFile"
$aBoolValues{10}:="IncludeDataFile"
$aBoolValues{11}:="IncludeAltStructFile"
$aBoolValues{12}:="IncludeDataFile"
$aBoolValues{13}:="Monday_Save"
$aBoolValues{14}:="Tuesday_Save"
$aBoolValues{15}:="Wednesday_Save"
$aBoolValues{16}:="Thursday_Save"
$aBoolValues{17}:="Friday_Save"
$aBoolValues{18}:="Saturday_Save"
$aBoolValues{19}:="Sunday_Save"

If (Find in array:C230($aBoolValues; $1)#-1)
	$0:=True:C214
Else 
	$0:=False:C215
End if 