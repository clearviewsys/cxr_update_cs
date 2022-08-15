//%attributes = {}
// method: pickTABLE 
// method: handleAutoFillTABLE
// form: pickTABLE  (form method: handlepickformMethod)
//

// How to create a full pick form

// 1) Copy and paste a ready made form such as pickCustomers
// 2) Replace the fields with relevant fields

// 3) rename form to pickTABLENAME (ex: pickCustomers) : must be exact name of table

//4) add form method
handlepickFormMethod

If (Form event code:C388=On Activate:K2:9)
	handleAutoFillSearch(->vSearchText; Current form table:C627; ->[Customers:3]CustomerID:1; ->[Customers:3]FullName:40; ->[Customers:3]CustomerID:1; ->arrKey; ->arrValue)
End if 

