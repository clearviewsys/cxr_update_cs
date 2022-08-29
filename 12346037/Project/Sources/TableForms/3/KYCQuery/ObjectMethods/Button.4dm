C_LONGINT:C283(cbMissingPID; cbMissingDOB; cbMissingPIDIssue; cbMissingPIDExpDate; cbMissingSIN; cbMissingHomePhone; cbMissingWorkPhone; cbMissingAdddress; cbMissingCountry; cbMissingOccupation)

If (cbQuerySelection=0)
	ALL RECORDS:C47([Customers:3])
End if 


QUERY SELECTION:C341([Customers:3]; [Customers:3]isCompany:41=False:C215; *)

QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]CustomerID:1#""; *)  // always true but starts the query


If (cbMissingPID=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]PictureID_Number:69=""; *)
End if 

If (cbMissingPIDIssue=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]PictureID_IssueState:72=""; *)
End if 

If (cbMissingPIDExpDate=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]PictureID_ExpiryDate:71=!00-00-00!; *)
End if 

If (cbMissingDOB=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]DOB:5=!00-00-00!; *)
End if 

If (cbMissingSIN=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]SIN_No:14=""; *)
End if 

If (cbMissingHomePhone=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]HomeTel:6=""; *)
End if 

If (cbMissingWorkPhone=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]WorkTel:12=""; *)
End if 

If (cbMissingAddress=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]Address:7=""; *)
End if 

If (cbMissingCity=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]City:8=""; *)
End if 

If (cbMissingCountry=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]Country_obs:11=""; *)
End if 

If (cbMissingOccupation=1)
	QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]Occupation:21=""; *)
End if 


QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]CustomerID:1#"")  // no effect but just closing the query
C_LONGINT:C283($n)
$n:=Records in selection:C76([Customers:3])
If ($n>0)
	ALERT:C41("Found "+String:C10($n)+" with missing info.")
End if 

ACCEPT:C269
