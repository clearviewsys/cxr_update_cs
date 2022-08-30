//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/11/18, 22:21:13
// ----------------------------------------------------
// Method: WAPI_getCurrencyArray
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1)
C_POINTER:C301($2)  //option value
C_POINTER:C301($3)  //option label

READ ONLY:C145([Currencies:6])
QUERY:C277([Currencies:6]; [Currencies:6]ISO4217:31#""; *)
QUERY:C277([Currencies:6];  & ; [Currencies:6]isDisplayOnly:33=False:C215; *)
QUERY:C277([Currencies:6];  & ; [Currencies:6]isHiddenOnWeb:29=False:C215)

DISTINCT VALUES:C339([Currencies:6]ISO4217:31; $1->)
