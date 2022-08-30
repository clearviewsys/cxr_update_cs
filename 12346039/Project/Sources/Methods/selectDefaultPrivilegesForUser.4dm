//%attributes = {}
// selectDefaultPrivilegesForUser ( $UserID)

// returns a selection in privileges table for the default permissions of the currenct User


QUERY:C277([Privileges:24]; [Privileges:24]UserID:1=$1; *)  // then lookup for the default privilege

QUERY:C277([Privileges:24];  & ; [Privileges:24]TableNo:2=0)