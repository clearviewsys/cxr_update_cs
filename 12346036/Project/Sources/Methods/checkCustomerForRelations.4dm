//%attributes = {}
//Amir 8th August 2020
//finding relations of current customer record to existing ones in terms of Address and family name
//3 types of checks are performed (using 3 different key/values, storing in Relations table)
//it is meant to be used in customer creation form

//#ORDA
C_TEXT:C284($currentCustomerId)
$currentCustomerId:=[Customers:3]CustomerID:1

C_OBJECT:C1216($currentCustomerAddressEs)
$currentCustomerAddressEs:=ds:C1482.Addresses.query("TableNo = :1 and RecordID = :2"; Table:C252(->[Customers:3]); $currentCustomerId)
C_COLLECTION:C1488($exactAddressHashes; $proximityAddressHashes)
$exactAddressHashes:=$currentCustomerAddressEs.HashWithStreetAddress
$proximityAddressHashes:=$currentCustomerAddressEs.HashWithoutStreetAddress

//relation types
C_TEXT:C284($SAME_LOCATION_SAME_LASTNAME; $SAME_LOCATION_DIFF_LASTNAME; $CLOSE_LOCATION_SAME_LASTNAME)
$SAME_LOCATION_SAME_LASTNAME:="same.location.same.lastname"
$SAME_LOCATION_DIFF_LASTNAME:="same.location.diff.lastname"
$CLOSE_LOCATION_SAME_LASTNAME:="close.location.same.lastname"

C_COLLECTION:C1488($potentialRelatedCustomerIds)
C_OBJECT:C1216($relatedCustomersEs; $customerEntity; $newRelation)

If (getKeyValue("check.same.location.same.lastname"; "false")="true")
	$potentialRelatedCustomerIds:=ds:C1482.Addresses.query("TableNo = :1 and RecordID # :2 and HashWithStreetAddress in :3"; Table:C252(->[Customers:3]); $currentCustomerId; $exactAddressHashes).distinct("RecordID")
	$relatedCustomersEs:=ds:C1482.Customers.query("CustomerID in :1 and LastName = :2"; $potentialRelatedCustomerIds; [Customers:3]LastName:4)
	For each ($customerEntity; $relatedCustomersEs)
		newRelation($currentCustomerId; $customerEntity.CustomerID; $SAME_LOCATION_SAME_LASTNAME)
	End for each 
End if 

If (getKeyValue("check.same.location.different.lastname"; "false")="true")
	$potentialRelatedCustomerIds:=ds:C1482.Addresses.query("TableNo = :1 and RecordID # :2 and HashWithStreetAddress in :3"; Table:C252(->[Customers:3]); $currentCustomerId; $exactAddressHashes).distinct("RecordID")
	$relatedCustomersEs:=ds:C1482.Customers.query("CustomerID in :1 and LastName # :2"; $potentialRelatedCustomerIds; [Customers:3]LastName:4)
	For each ($customerEntity; $relatedCustomersEs)
		newRelation($currentCustomerId; $customerEntity.CustomerID; $SAME_LOCATION_DIFF_LASTNAME)
	End for each 
End if 

If (getKeyValue("check.close.location.same.lastname"; "false")="true")
	$potentialRelatedCustomerIds:=ds:C1482.Addresses.query("TableNo = :1 and RecordID # :2 and HashWithoutStreetAddress in :3 and NOT(HashWithStreetAddress in :4)"; Table:C252(->[Customers:3]); $currentCustomerId; $proximityAddressHashes; $exactAddressHashes).distinct("RecordID")
	$relatedCustomersEs:=ds:C1482.Customers.query("CustomerID in :1 and LastName = :2"; $potentialRelatedCustomerIds; [Customers:3]LastName:4)
	For each ($customerEntity; $relatedCustomersEs)
		newRelation($currentCustomerId; $customerEntity.CustomerID; $CLOSE_LOCATION_SAME_LASTNAME)
	End for each 
End if 


