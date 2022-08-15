//%attributes = {}
// isStringEqualTo ( s1: text ; s2 : text ; { ck diacritical } ) : boolean
// returns true if the strings are equal
// #UTIL ; #STRING 
// @tiran 
// since there is no string comparison operation if 4D that can do strict string comparison then we have to use some tricks
// https://github.com/vdelachaux/tip-and-tricks/blob/master/docs/Diacritical%20comparison.md#benchmarking

//@Zoya : I didn't write any unit test as there is no caller for thid method
C_TEXT:C284($1; $2)  // 
C_LONGINT:C283($3)  // method of comparison of two collections using 'equal'  (e.g. ck diacritical)
C_BOOLEAN:C305($0)

Case of 
	: (Count parameters:C259=2)
		$0:=Match regex:C1019("(?m-si)^"+$1+"$"; $2; 1)
	: (Count parameters:C259=3)
		$0:=New collection:C1472($1).equal(New collection:C1472($2); $3)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

