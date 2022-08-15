//%attributes = {"shared":true}
//Method Comments
//*****************************************************
//Method called before each Sync Recored created.
//Return false to suppress syncing to remote site.
//Must set method properties to share with components and host database.


//Declarations
//*****************************************************
C_BOOLEAN:C305($0; $vb_OK_To_Sync)
C_TEXT:C284($1; $vt_Current_Site)
C_TEXT:C284($2; $vt_Origin_Site)
C_TEXT:C284($3; $vt_Destination_Site)
C_LONGINT:C283($4; $vi_Table_Number)
C_POINTER:C301($ptrField)


//Initialization
//*****************************************************
$vt_Current_Site:=$1
$vt_Origin_Site:=$2
$vt_Destination_Site:=$3
$vi_Table_Number:=$4
$vb_OK_To_Sync:=True:C214


//Main Code
//*****************************************************
//Insert code to check if you want to Sync

//If (<>SYNC_Is_Enabled)  //only check if module is active -- PROBABLY REDUNDANT ???
//<>SYNC_is_enabled is not handled by the component so this is irrelevant

//TRACE

// added by: Barclay Berry (7/26/13)-- one last check -- hard coded exceptions for records
//If ($vb_OK_To_Sync)
Case of 
	: ($vi_Table_Number<0)
		$vb_OK_To_Sync:=False:C215
		
	: ($vi_Table_Number=Table:C252(->[Customers:3]))  //9/5/17 removed self-@
		If ([Customers:3]CustomerID:1="000-@")
			$vb_OK_To_Sync:=False:C215
		End if 
		
	: ($vi_Table_Number=Table:C252(->[Registers:10]))
		
	: ($vi_Table_Number=Table:C252(->[Accounts:9]))
		
	: ($vi_Table_Number=Table:C252(->[Invoices:5]))
		
		
	: ($vi_Table_Number=Table:C252(->[Privileges:24]))
		If ([Privileges:24]UserID:1="1") | ([Privileges:24]UserID:1="2")  //designer or administrator
			$vb_OK_To_Sync:=False:C215
		End if 
		
	Else 
		
End case 
//End if 


If ($vb_OK_To_Sync)  //one last check for _sync_exception
	//TRACE
	$ptrField:=UTIL_getFieldPointer("["+Table name:C256($vi_Table_Number)+"]"+"_sync_exception")
	If (Not:C34(Is nil pointer:C315($ptrField)))
		If ($ptrField->)
			$vb_OK_To_Sync:=False:C215
		End if 
	End if 
End if 

//End if 

$0:=$vb_OK_To_Sync


