//%attributes = {}
// display the Account.grid listbox
// This will be the new optimized Accounts listbox
// the goal is to be more optimized and faster in querying

displayTableForm(->[Accounts:9]; "Grid")
//[Accounts];"Grid"
// see also older form:  [Accounts];"ListBox"

// see also: 
If (False:C215)
	acc_initGridFormVars
	acc_initGridArrays
	acc_refreshGrid  // this method calculates the values and fills the arrays
End if 