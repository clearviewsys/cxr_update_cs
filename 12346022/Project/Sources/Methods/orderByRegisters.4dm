//%attributes = {}
//  DO NOT MODIFY THIS
// CHANGING THE ORDER OF THIS SORT MAY DAMAGE THE CALCULATIONS
// the order of the registers would change the value of running average calculations
// therefore all purchases must be made before the sellings

//ORDER BY([Registers];[Registers]Date;>;[Registers]InvoiceNumber;>;[Registers]CreationDate;>;[Registers]CreationTime;>)
ORDER BY:C49([Registers:10]; [Registers:10]RegisterDate:2; >; [Registers:10]RegisterID:1)