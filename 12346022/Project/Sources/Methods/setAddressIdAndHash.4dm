//%attributes = {}
//setAddressIdAndHash()
//for current record of [Addresses], sets [Addresses]AddressID if not set, and [Addresses]Hashes
If ([Addresses:147]AddressID:18="")
	[Addresses:147]AddressID:18:=makeAddressID
End if 

C_OBJECT:C1216($hashObject)
$hashObject:=getAddressHash(newAddress([Addresses:147]CountryCode:7; [Addresses:147]State:5; [Addresses:147]City:4; [Addresses:147]ZipCode:6; [Addresses:147]Address:3; [Addresses:147]UnitNo:15))

[Addresses:147]HashWithoutStreetAddress:17:=$hashObject.hashForProximity
[Addresses:147]HashWithStreetAddress:16:=$hashObject.hashForExactMatch