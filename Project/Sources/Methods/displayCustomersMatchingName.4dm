//%attributes = {}
// displayCustomersInEntitySelection ($entitySelection: ds.Customers; form heading: text)
// this method will display a listbox showing matching records from the Customers 
// PRE: Customer Record should be loaded  ; call this method from withing the Customers.Entry form ; on data change
// e.g. displayCustomersMatching ( ds.Customers.query("Email = 'tiran@mac.com' )
// e.g. displayCustomersInListBox ("FullName = :1 and Email = :2";"John Doe";"john@doe.co")


C_OBJECT:C1216($1; $customers; $customer)
C_TEXT:C284($2; $lookupValue; $ordaQuery)
C_TEXT:C284($fullName; $cell; $email; $pictureID; $customerID; $sin; $address; $city)
C_DATE:C307($dob)

// searchTable
// [customers];"ListBox_ES"

$customerID:=[Customers:3]CustomerID:1
makeCustomerFullName
$fullName:=[Customers:3]FullName:40
$dob:=[Customers:3]DOB:5  // maybe unique when full name is matching (possible)
$email:=[Customers:3]Email:17  // unique
$pictureID:=[Customers:3]PictureID_Number:69  // unique
$sin:=[Customers:3]SIN_No:14  // unique
$address:=[Customers:3]Address:7
$city:=[Customers:3]City:8

$customers:=New object:C1471  // entity selection of Customers

Case of 
	: (Count parameters:C259=0)
		Case of 
			: (($fullName#"") & ($dob=!00-00-00!))  // search by full name only if the dob was empty
				$customers.list:=ds:C1482.Customers.query("FullName = :1 and CustomerID # :2"; $fullName; $customerID)  // same full name but not the same customerID
				$customers.formTitle:="Customers matching the same Full Name!"
			: (($fullName#"") & ($dob#!00-00-00!))  // dob has been entered as well as a full name
				$customers.list:=ds:C1482.Customers.query("FullName = :1 and CustomerID # :2 and DOB = :3"; $fullName; $customerID; $dob)  // same full name but not the same customerID
				$customers.formTitle:="Customers matching the same FullName and DOB! Duplicate Entry!"
			Else 
				$customers.list:=New collection:C1472  // empty; this is to make sure $customers.list.length # 0 
		End case 
		
	: (Count parameters:C259=1)
		$customers.list:=$1
		$customers.formTitle:="Duplicate Entry matching following records in Customers table"
		
	: (Count parameters:C259=2)
		$customers.list:=$1
		$customers.formTitle:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($customers#Null:C1517)
	
	$customers.current:=New object:C1471  // keep information about the current record
	$customers.current.customerID:=$customerID
	$customers.current.fullName:=$fullName
	$customers.current.dob:=$dob
	$customers.current.email:=$email  // unique
	$customers.current.pictureID:=$pictureID  // unique in the same country
	$customers.current.sin:=$sin
	$customers.current.address:=$address
	$customers.current.city:=$city
	
	If ($customers.list.length>0)
		C_LONGINT:C283($win)
		$win:=Open form window:C675([Customers:3]; "ListBox_Match")
		DIALOG:C40([Customers:3]; "ListBox_Match"; $customers)
		//"ListBox_ES"
	End if 
End if 
