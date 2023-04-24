//%attributes = {}
//takes the current customer and finds webUser based on email address
//assigns the 
// [WebUsers]RecordID and [WebUsers]isCustomer

C_BOOLEAN:C305($1; $bLink)
C_LONGINT:C283($0; $iError)

C_OBJECT:C1216($status; $entity; $webuser)

If (Count parameters:C259>=1)
	$bLink:=$1
Else 
	$bLink:=True:C214
End if 

//$entity:=ds.WebUsers.query(Field name(->[WebUsers]Email)+" IS :1 AND "+field name(->[WebUsers]isCustomer)+" IS True AND "+Field name(->[WebUsers]RecordID)+" IS ''";[Customers]Email)

$entity:=ds:C1482.WebUsers.query(Field name:C257(->[WebUsers:14]Email:3)+" IS :1 AND "+Field name:C257(->[WebUsers:14]relatedTable:8)+" IS :2"; [Customers:3]Email:17; Table:C252(->[Customers:3]))


If ($entity.length=1)
	
	$webuser:=$entity.first()
	
	//READ WRITE([WebUsers])
	//USE ENTITY SELECTION($entity)
	//LOAD RECORD([WebUsers])
	
	If ($bLink)
		$webuser.recordID:=[Customers:3]CustomerID:1
		//[WebUsers]RecordID:=[Customers]CustomerID
	Else 
		$webuser.recordID:=""
		//[WebUsers]RecordID:=""
	End if 
	
	$status:=$webuser.save()
	
	If ($status.success)
		$iError:=0
	Else 
		$iError:=-1
	End if 
	
	//SAVE RECORD([WebUsers])
	//UNLOAD RECORD([WebUsers])
	//REDUCE SELECTION([WebUsers];0)
	
Else 
	myAlert("Unable to link Customer to WebUser.")
	$iError:=-2
End if 

$0:=$iError