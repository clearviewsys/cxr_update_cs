//%attributes = {}
C_POINTER:C301($self; $1)
C_BOOLEAN:C305($forceDialog; $2)
C_TEXT:C284($0)

Case of 
	: (Count parameters:C259=0)
		$self:=->[Occupations:2]Category:5
		$forceDialog:=True:C214
		
	: (Count parameters:C259=1)
		$self:=$1
		$forceDialog:=False:C215
	: (Count parameters:C259=2)
		$self:=$1
		$forceDialog:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


pickRecordForTable(->[Industries:114]; ->[Industries:114]Code:6; $self; False:C215; $forceDialog)
If (OK=1)
	$0:=[Industries:114]Code:6
End if 