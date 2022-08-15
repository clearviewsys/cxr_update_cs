//Case of 
//: (Form event=On Load)
//  // populate it
//C_TEXT($namedSelection)
//$namedSelection:="$tempCustomerSelection"
//
//PUSH RECORD([Customers])
//COPY NAMED SELECTION([Customers];$namedSelection)
//QUERY([Customers];[Customers]isCompany=True)
//orderbyCustomers 
//DISTINCT VALUES([Customers]CompanyName;Self->)
//USE NAMED SELECTION($namedSelection)
//CLEAR NAMED SELECTION($namedSelection)
//POP RECORD([Customers])
//
//Else 
//[Customers]CompanyName:=Self->{Self->}
//[Customers]isCompany:=False
//
//End case 
