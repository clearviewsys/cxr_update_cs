//%attributes = {}
// setApplicationUser(username)

C_TEXT:C284(<>applicationUser; $1)
<>applicationUser:=$1  // keep for legacy code

SET USER ALIAS:C1666($1)  // this become current user and we can use in triggers @ibb






//thoughts.... we can't access this in a trigger but sets are accessible
//what if we create a applicationUserSet that contains the [Users] record
//then we could use set in a trigger and have the name ??? -- IBB

//Sets and Named selections: If you use a set or a named selection from within a trigger, 
//you work on the machine where the trigger executes. In client/server mode, 
//"process" sets and named selections (whose names do not begin with a $ nor with <>) 
//that are created on the client machine are visible in a trigger.

