//%attributes = {}
//Amir 15th July 2020
//regenerates the address records for customers
//PRE: there is no address records in [Addresses] table

//#SLOW: this method is slow.
ALL RECORDS:C47([Addresses:147])
If (Records in selection:C76([Addresses:147])=0)
	updateTableUsingMethod(->[Customers:3]; "updateCustomerAddressIDSimple"; True:C214)
	
	
	//#ORDA
	//C_TEXT($progressLabel)
	//$progressLabel:="Updating Record..."
	//C_LONGINT($progress)
	//C_LONGINT($i;$n)
	//$progress:=launchProgressBar ("Update in progress...")
	
	//C_OBJECT($customerObj;$customerEs)
	//C_TEXT($addressId)
	//$customerEs:=ds.Customers.all()
	//$n:=$customerEs.count("CustomerID")
	//$i:=1
	//For each ($customerObj;$customerEs)
	//If (Not(isProgressBarStopped ($progress)))
	//  //If ($customerObj.AddressUnitNo="")
	//  //splitAddressToUnitStreetFields ([Customers]Address;->[Customers]Address;->[Customers]AddressUnitNo)
	//  //End if 
	
	//  //create an address record
	
	//$addressId:=createRecordCustomerAddress ($customerObj.CustomerID;"Main";$customerObj.AddressUnitNo;$customerObj.Address;$customerObj.PostalCode;$customerObj.City;$customerObj.Province;$customerObj.CountryCode)
	//$customerObj.MainAddressID:=$addressId
	//$customerObj.save()
	//refreshProgressBar ($progress;$i;$n)
	//setProgressBarTitle ($progress;$progressLabel+String($i))
	//$i:=$i+1
	//End if 
	
	//End for each 
	
Else 
	myAlert("Error: There are already Address records in Addresses module. Please delete all Addresses from that module before running this operation.")
End if 







