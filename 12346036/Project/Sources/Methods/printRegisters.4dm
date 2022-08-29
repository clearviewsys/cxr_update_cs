//%attributes = {}
openFormWindow(Current form table:C627; "printPanel")

//CONFIRM("Print with subtotals?";"Subtotals";"Plain")
//If (OK=0)
//printTable (->[Registers];"print";->[Registers]DueDate;->[Registers]RegisterID)
//Else 
//  `print2LevelBreakTable
//ACCUMULATE([Registers]Debit;[Registers]Credit)
//BREAK LEVEL(3)
//
//printTable (->[Registers];"printRegisters";->[Registers]Date;->[Registers]Currency;->[Registers]AccountID;->[Registers]RegisterID)
//End if 