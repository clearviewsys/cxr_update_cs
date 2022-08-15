//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/02/13, 19:50:34
// ----------------------------------------------------
// Method: exportGWCustomers (filePath; fromDate;toDate)

// Description
//    Exports Customers for use in GlobalWare
//    based on Galileo International -GlobalWare version 3.50
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tPath)
C_DATE:C307($2; $fromDate)
C_DATE:C307($3; $toDate)

C_TEXT:C284($TB; $CR)
C_TEXT:C284($tAddress; $tPath; $tRecord)
C_TEXT:C284($fileName)

$TB:=Char:C90(Tab:K15:37)
$CR:=Char:C90(Carriage return:K15:38)
$fileName:="IMPACCT.dat"


Case of 
	: (Count parameters:C259=1)
		$tPath:=$1
		$fromDate:=Current date:C33
		$toDate:=Current date:C33
		
	: (Count parameters:C259=3)
		$tPath:=$1
		$fromDate:=$2
		$toDate:=$3
	Else 
		$tPath:=""
		$fromDate:=Current date:C33
		$toDate:=Current date:C33
End case 

If (Test path name:C476($tPath)=Is a folder:K24:2)
	$tPath:=$tPath+$fileName
Else 
	$tPath:=$fileName
End if 

QUERY:C277([Customers:3]; [Customers:3]CreationDate:54>=$fromDate; *)
QUERY:C277([Customers:3];  & ; [Customers:3]CreationDate:54<=$toDate)

C_LONGINT:C283($i; $iPos)
C_TIME:C306($hDocRef)
If (Records in selection:C76([Customers:3])>0)
	
	$hDocRef:=Create document:C266($tPath)
	
	If (OK=1)  //document was created
		
		FIRST RECORD:C50([Customers:3])
		For ($i; 1; Records in selection:C76([Customers:3]))  //loop through all selected customers and export
			
			$tRecord:=Substring:C12([Customers:3]CustomerID:1; 6; Length:C16([Customers:3]CustomerID:1))+$TB  //ImpAccountId -- 10  strip the prefix so we have the right no of chars
			$tRecord:=$tRecord+"C"+$TB  //ImpAccountType -- 1
			$tRecord:=$tRecord+"P"+$TB  //ImpCust/TravelType  -- 1
			$tRecord:=$tRecord+Substring:C12([Customers:3]FullName:40; 1; 30)+$TB  //ImpName  -- 30
			$tRecord:=$tRecord+""+$TB  //ImpShortCode  -- 3
			$tRecord:=$tRecord+Substring:C12([Customers:3]LastName:4; 1; 13)+$TB  //ImpSortName  -- 13
			
			$iPos:=Position:C15(Char:C90(Carriage return:K15:38); [Customers:3]Address:7)
			If ($iPos>0)  //need to handle multi lines
				$tRecord:=$tRecord+Substring:C12(Substring:C12([Customers:3]Address:7; 1; $iPos-1); 1; 30)+$TB  //ImpAddr1  --  30
				$tAddress:=Substring:C12([Customers:3]Address:7; $iPos+1; Length:C16([Customers:3]Address:7))
				$iPos:=Position:C15(Char:C90(Carriage return:K15:38); $tAddress)
				If ($iPos>0)
					$tRecord:=$tRecord+Substring:C12(Substring:C12($tAddress; 1; $iPos-1); 1; 30)+$TB  //ImpAddr2  --  30
					$tRecord:=$tRecord+Replace string:C233(Substring:C12(Substring:C12($tAddress; $iPos+1; Length:C16($tAddress)); 1; 30); Char:C90(Carriage return:K15:38); " ")+$TB  //ImpAddr3  --  30
				Else 
					$tRecord:=$tRecord+Substring:C12($tAddress; 1; 30)+$TB  //ImpAddr2  --  30
					$tRecord:=$tRecord+""+$TB  //ImpAddr3  --  30
				End if 
				
			Else 
				$tRecord:=$tRecord+Substring:C12([Customers:3]Address:7; 1; 30)+$TB  //ImpAddr1  --  30
				$tRecord:=$tRecord+""+$TB  //ImpAddr2  --  30
				$tRecord:=$tRecord+""+$TB  //ImpAddr3  --  30
			End if 
			
			$tRecord:=$tRecord+Substring:C12([Customers:3]City:8; 1; 15)+$TB  //ImpCity  --  15
			$tRecord:=$tRecord+Substring:C12([Customers:3]Province:9; 1; 2)+$TB  //ImpState  --  2
			$tRecord:=$tRecord+Substring:C12([Customers:3]PostalCode:10; 1; 10)+$TB  //ImpZip  --  10
			$tRecord:=$tRecord+Substring:C12([Customers:3]Country_obs:11; 1; 20)+$TB  //ImpCountry  --  20
			$tRecord:=$tRecord+Substring:C12([Customers:3]Email:17; 1; 50)+$TB  //ImpEMail  --  50
			$tRecord:=$tRecord+Substring:C12([Customers:3]BusinessPhone1:63; 1; 15)+$TB  //ImpBusPhone  --  15
			$tRecord:=$tRecord+Substring:C12([Customers:3]WorkFax:46; 1; 15)+$TB  //ImpFaxPhone  --  15
			$tRecord:=$tRecord+Substring:C12([Customers:3]HomeTel:6; 1; 15)+$TB  //ImpHomePhone  --  15
			$tRecord:=$tRecord+""+$TB  //ImpComPct  --  5
			$tRecord:=$tRecord+""+$TB  //ImpReportToId  --  10
			$tRecord:=$tRecord+""+$TB  //ImpLastArBal  --  15
			$tRecord:=$tRecord+""+$TB  //ImpLastArDate  --  10
			
			$tRecord:=$tRecord+$CR
			SEND PACKET:C103($hDocRef; $tRecord)
			NEXT RECORD:C51([Customers:3])
		End for 
		
		CLOSE DOCUMENT:C267($hDocRef)
		
		myAlert($fileName+" exported.")
		
	End if 
	
Else 
	myAlert("No customer records available for exporting.")
End if 