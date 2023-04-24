//%attributes = {}
C_POINTER:C301($1; $rptInfoPtr)
$rptInfoPtr:=$1

READ ONLY:C145([Wires:8])
READ ONLY:C145([WireTemplates:42])

Case of 
		
	: ([Registers:10]InternalTableNumber:17=Table:C252(->[Wires:8]))
		
		QUERY:C277([Wires:8]; [Wires:8]CXR_WireID:1=[Registers:10]InternalRecordID:18)
		QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[Wires:8]WireTemplateID:83)
		
		If ([WireTemplates:42]AccountNo:6#"")
			$rptInfoPtr->:=$rptInfoPtr->+FJ_AddTagToReport(":P14:"; FJ_MaxString([WireTemplates:42]AccountNo:6; 34; 5; False:C215); False:C215)
			$rptInfoPtr->:=$rptInfoPtr->+FJ_AddTagToReport(":P15:"; FJ_MaxString("C"; 1; 5; False:C215); False:C215)
			$rptInfoPtr->:=$rptInfoPtr->+FJ_AddTagToReport(":P16:"; FJ_MaxString([WireTemplates:42]BeneficiaryFullName:9; 70; 2; False:C215); False:C215)
		End if 
		
		
		
		// ----------------------------------------------------------
		
	: ([Registers:10]InternalTableNumber:17=Table:C252(->[eWires:13]))
		
		QUERY:C277([eWires:13]; [eWires:13]eWireID:1=[Registers:10]InternalRecordID:18)
		QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)
		
		If ([Links:17]BankAccountNo:31#"")
			$rptInfoPtr->:=$rptInfoPtr->+FJ_AddTagToReport(":P14:"; FJ_MaxString([Links:17]BankAccountNo:31; 34; 5; False:C215); False:C215)
			$rptInfoPtr->:=$rptInfoPtr->+FJ_AddTagToReport(":P15:"; FJ_MaxString("C"; 1; 5; False:C215); False:C215)
			$rptInfoPtr->:=$rptInfoPtr->+FJ_AddTagToReport(":P16:"; FJ_MaxString([Links:17]FullName:4; 70; 2; False:C215); False:C215)
		End if 
		
		// ----------------------------------------------------------
		
		
	: ([Registers:10]InternalTableNumber:17=Table:C252(->[Cheques:1]))
	: ([Registers:10]InternalTableNumber:17=Table:C252(->[Accounts:9]))
	: ([Registers:10]InternalTableNumber:17=Table:C252(->[CashTransactions:36]))
		
	Else 
		
End case 

