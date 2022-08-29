//%attributes = {}
/* Get sanction list source by [SanctionCheckLog] or [SanctionList]

#param $entityParam
       Entity to check
       #pre must be of type [SanctionCheckLog] or [SanctionList]
#param $displayParam
       Should JSON CXRBlackList be shown as `CXRBlackList` instead of `v2`
#return the sanction source 
#author @wai-kin
*/
#DECLARE($entityParam : 4D:C1709.Entity; $displayParm : Boolean)->$result : Text

// MARK:- Parameter Setup
var $entity : 4D:C1709.Entity
var $display : Boolean

Case of 
	: (Count parameters:C259=0)
		$entity:=Create entity selection:C1512([SanctionCheckLog:111]).first()
		
	: (Count parameters:C259=1)
		$entity:=$entityParam
		$display:=False:C215
	: (Count parameters:C259=2)
		$entity:=$entityParam
		$display:=$displayParm
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $entityTable : Real
$entityTable:=$entity.getDataClass().getInfo().tableNumber
Case of 
	: ($entity=Null:C1517)
		$result:=""
		
	: ($entityTable=Table:C252(->[SanctionCheckLog:111]))
		// MARK:- [SanctionCheckLog] Record
		
		If ($entity.UseServer="")
			If ($entity.Details=Null:C1517)
				// MARK: Record is created in CXR6 or earlier
				If ($entity.ResponseJSON=Null:C1517)
					$result:="v1"
				Else 
					$result:="v2"
				End if 
			Else 
				// MARK: Record is created in 4Dv18
				$result:=$entity.Details.checkType
			End if 
		Else 
			// MARK: CXR7 and later
			$result:=$entity.UseServer
		End if 
		
	: ($entityTable=Table:C252(->[SanctionLists:113]))
		// MARK:- For [SanctionLists]
		If ($entity.UseServer="")
			$result:="v2"
		Else 
			$result:=$entity.UseServer
		End if 
		
	Else 
		// MARK:- Assert fails
		ASSERT:C1129(False:C215; "$entity is not a SanctionCheckLog or SanctionLits table")
		
End case 

//MARK:- Display (Readable) vs Version (Specific)
If ($display)
	If (($result="v1") | ($result="v2"))
		$result:="CXBlacklist"
	End if 
Else 
	If ($result="CXBlacklist")
		$result:="v2"
	End if 
End if 