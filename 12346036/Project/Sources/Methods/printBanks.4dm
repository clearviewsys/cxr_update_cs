//%attributes = {}
//If (Records in selection([Banks])>0)

//  `ORDER BY([Banks];[Banks]BankShortName)

//RELATE MANY SELECTION([Branches]InstitutionCode)  ` select all the branches connected to the selection of banks

//ORDER BY([Branches];[Branches]InstitutionCode;>;[Branches]BranchName;>)

//

//BREAK LEVEL(2)  ` BREAK LEVEL AND ACCUMULATE MUST BE TOGETHER FOR BREAK PROCESSING

//ACCUMULATE([Branches]temp)

//

//OUTPUT FORM([Branches];"printBanks")

//If (◊DisplayPageSetup=True)

//PRINT SELECTION([Branches])

//Else 

//PRINT SELECTION([Branches];*)

//End if 

//Else 

//ALERT("No Records is Selected.")

//End if 


//print2LevelBreakTable (->;->[Wires];->[Wires]CXR_AccountID;->[Wires]BeneficiaryBankName;->[Wires]Currency)