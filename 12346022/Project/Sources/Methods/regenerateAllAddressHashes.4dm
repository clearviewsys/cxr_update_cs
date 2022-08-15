//%attributes = {}
//Amir 26th April 2020
//regenerates the address hash for all address records in database
//#ORDA
C_OBJECT:C1216($addressEntitySelection; $hashObj)
$addressEntitySelection:=ds:C1482.Addresses.query("CountryCode #\"\" and City#\"\" and ZipCode#\"\" and Address#\"\"")

C_LONGINT:C283($iProgress; $counter)
C_REAL:C285($percent)
$iProgress:=Progress New
Progress SET TITLE($iProgress; "Operation")
Progress SET MESSAGE($iProgress; "Updating address hashes")
Progress SET BUTTON ENABLED($iProgress; True:C214)
For ($counter; 0; $addressEntitySelection.length-1)
	If (Not:C34(Progress Stopped($iProgress)))
		$hashObj:=getAddressHash(newAddress($addressEntitySelection[$counter].CountryCode; $addressEntitySelection[$counter].State; $addressEntitySelection[$counter].City; $addressEntitySelection[$counter].ZipCode; $addressEntitySelection[$counter].Address; $addressEntitySelection[$counter].UnitNo))
		$addressEntitySelection[$counter].HashWithoutStreetAddress:=$hashObj.hashForProximity
		$addressEntitySelection[$counter].HashWithStreetAddress:=$hashObj.hashForExactMatch
		$addressEntitySelection[$counter].save()
		$percent:=($counter+1)/$addressEntitySelection.length
		Progress SET PROGRESS($iProgress; $percent; "Updating address hash..."+String:C10($counter+1))
	Else 
		Progress SET PROGRESS($iProgress; $percent; "Operation canceled. Updated "+String:C10($counter+1))
		$counter:=$addressEntitySelection.length  //break
	End if 
	
End for 
Progress QUIT($iProgress)