//%attributes = {}
// Converts two checkbox into a single number for KYC2020 recordType
Case of 
	: (Form:C1466.KYC2020.forPersons)
		If (Form:C1466.forEntities)
			[SanctionLists:113]Details:13.KYC2020.recordType:=1
		Else 
			[SanctionLists:113]Details:13.KYC2020.recordType:=3
		End if 
	: (Form:C1466.KYC2020.forEntities)
		[SanctionLists:113]Details:13.KYC2020.recordType:=2
	Else 
		[SanctionLists:113]Details:13.KYC2020.recordType:=1
End case 