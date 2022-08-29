//%attributes = {}
// assertField_KnownKey (  ->tablePtr; ->fieldPtr ; ->oneTablePtr; -> oneFieldPtr)
// this assert should be used on fields that are common such as InvoiceID. 

// e.g. assertFieldKnownKey ( ->[registers];-[registers]invoiceID; ->[invoices];->[invoices]invoiceId)
// the last two parameters are used as the point of reference for the one table 
// the foreign keys will be compared to the  


C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)
C_POINTER:C301($oneTablePtr; $3; $primaryKeyPtr; $4)

$oneTablePtr:=->[Invoices:5]
$primaryKeyPtr:=->[Invoices:5]InvoiceID:1

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[Registers:10]
		$fieldPtr:=->[Registers:10]InvoiceNumber:10
		
		$oneTablePtr:=->[Invoices:5]
		$primaryKeyPtr:=->[Invoices:5]InvoiceID:1
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldPtr:=$2
		$oneTablePtr:=$tablePtr
		$primaryKeyPtr:=$fieldPtr
		
	: (Count parameters:C259=4)
		$tablePtr:=$1
		$fieldPtr:=$2
		$oneTablePtr:=$3
		$primaryKeyPtr:=$4
	Else 
		
End case 


//ASSERT(Field name($fieldPtr)="InvoiceID";"Field name must be invoiceID")

If ($tablePtr=$oneTablePtr)  // if the table is the one table then the primary key must be unique, or else it is a foreign key and should not be unique
	assertFieldType_Alpha($tablePtr; $fieldPtr; getStandardFieldLength($primaryKeyPtr); True:C214; True:C214)
	
Else   // this a connection from a foreignkey
	
	assertFieldType_Alpha($tablePtr; $fieldPtr; getStandardFieldLength($primaryKeyPtr); True:C214; False:C215)
	
	C_LONGINT:C283($oneRelation; $manyRelation)
	GET FIELD RELATION:C920($fieldPtr->; $oneRelation; $manyRelation; *)
	
	ASSERT:C1129($oneRelation=2; "Automatic Relation (One) for"+Table name:C256($tablePtr)+"."+Field name:C257($fieldPtr)+" must be off")
	ASSERT:C1129($manyRelation=2; "Automatic Relation (Many) for "+Table name:C256($tablePtr)+"."+Field name:C257($fieldPtr)+" must be off")
	
End if 

