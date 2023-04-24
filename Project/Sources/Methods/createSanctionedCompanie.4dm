//%attributes = {}
// createSanctionedCompanies
//@Zoya 09 Feb 2021

// this method creates sanctioned individual customers in the Customers table
// use this method inside a 'START TRANSACTION' and 'Cancel Transaction' 
// POST: There will be new records added to the Customers table; 
// PRE:

/*AMROGGANG DEVELOPMENT BANKING CORPORATION KPi.023 UN list
TARIQ GIDAR GROUP (TGG)Ta QDe.160 UN list
Rabita Trust QDe.021 UN list
IFD KAPITAL OFAC List April 22, 2020
STEP ISTANBUL OFAC List April 22, 2020
FEODOSIYA ENTERPRISE ON PROVIDING OIL PRODUCTS OFAC List April 22, 2020

*/

createCustomer("_SancCom1"; ""; ""; "AMROGGANG DEVELOPMENT BANKING CORPORATION"; 1)
//createCustomer("_SancCom1"; ""; ""; "zzzzzzz"; 1)
createCustomer("_SancCom2"; ""; ""; "TARIQ GIDAR GROUP (TGG)Ta"; 1)
createCustomer("_SancCom3"; ""; ""; "Rabita Trust"; 1)
createCustomer("_SancCom4"; ""; ""; "IFD KAPITAL"; 1)
createCustomer("_SancCom5"; ""; ""; "STEP ISTANBUL"; 1)
createCustomer("_SancCom5"; ""; ""; "FEODOSIYA ENTERPRISE ON PROVIDING OIL PRODUCTS"; 1)

