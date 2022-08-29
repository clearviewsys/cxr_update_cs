//%attributes = {}
//BisN_getCustomerInfoUsingPID (PID(personal identification number; such as legal id in Sweden); 
//->resultObject;a pointer to an object to be filled with properties
//)
//returns boolean as success status
C_TEXT:C284($pid; $1)
C_POINTER:C301($resultObjPtr; $2)
C_BOOLEAN:C305($success; $0)
ASSERT:C1129(Type:C295($pid)=Is text:K8:3; "Expected text for PID")
Case of 
	: (Count parameters:C259=2)
		$pid:=$1
		$resultObjPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY OBJECT:C1221($arrResponseObject; 0)
C_BOOLEAN:C305($isSuccess)
$isSuccess:=False:C215
If (Not:C34($pid=""))
	$isSuccess:=BisN_searchPersonByLegalId(->$arrResponseObject; $pid)
End if 
If (($isSuccess=True:C214) & (Size of array:C274($arrResponseObject)=1))
	$resultObjPtr->:=New object:C1471
	$resultObjPtr->firstName:=$arrResponseObject{1}.preferredFirstName
	$resultObjPtr->familyName:=$arrResponseObject{1}.familyName
	
	//setting date of birth
	ARRAY TEXT:C222($yearMonthDay; 0)
	COLLECTION TO ARRAY:C1562(Split string:C1554($arrResponseObject{1}.dateOfBirth; "-"); $yearMonthDay)
	C_TEXT:C284($year; $month; $day)
	$year:=$yearMonthDay{1}
	$month:=$yearMonthDay{2}
	$day:=$yearMonthDay{3}
	$resultObjPtr->dateOfBirth:=newDate(Num:C11($day); Num:C11($month); Num:C11($year))
	
	//setting phone numbers
	ARRAY OBJECT:C1221($arrPhoneNumbers; 0)
	OB GET ARRAY:C1229($arrResponseObject{1}; "phoneList"; $arrPhoneNumbers)
	If (Not:C34(Size of array:C274($arrPhoneNumbers)=0))
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($arrPhoneNumbers))
			Case of 
				: ($arrPhoneNumbers{$i}.type="Landline")
					$resultObjPtr->homePhone:=$arrPhoneNumbers{$i}.number
				: ($arrPhoneNumbers{$i}.type="Mobile")
					$resultObjPtr->cellPhone:=$arrPhoneNumbers{$i}.number
			End case 
		End for 
	Else 
		$resultObjPtr->homePhone:=""
		$resultObjPtr->cellPhone:=""
	End if 
	
	//setting address
	ARRAY OBJECT:C1221($arrAddresses; 0)
	OB GET ARRAY:C1229($arrResponseObject{1}; "addressList"; $arrAddresses)
	If (Not:C34(Size of array:C274($arrAddresses)=0))
		//only using the first entry of address; cause we currently have only one [Customers]Address
		ARRAY TEXT:C222($arrAddress; 0)
		OB GET ARRAY:C1229($arrAddresses{1}; "formattedAddress"; $arrAddress)
		C_COLLECTION:C1488($c)
		$c:=New collection:C1472
		ARRAY TO COLLECTION:C1563($c; $arrAddress)
		$resultObjPtr->formattedAddress:=$c.join(", ")
		$resultObjPtr->country:=$arrAddresses{1}.country
		$resultObjPtr->city:=$arrAddresses{1}.city
		$resultObjPtr->postalCode:=$arrAddresses{1}.postalCode
	Else 
		$resultObjPtr->formattedAddress:=""
	End if 
	$0:=True:C214
Else 
	$0:=False:C215
End if 



