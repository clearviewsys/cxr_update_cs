//%attributes = {}

//QUERY([Customers];[Customers]FirstName="tiran";*) // continue the query in the next line
//QUERY([Customers];[Customers]LastName="behrouz")

C_OBJECT:C1216($customers; $customer)
$customers:=ds:C1482.Customers.all()
USE ENTITY SELECTION:C1513($customers)  // entity seection converts to classic selection



displaySelectedRecords(->[Customers:3])  // displays all the selection of records
