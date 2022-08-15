
If (Form event code:C388=On Data Change:K2:15)
	pickCountryCode(Self:C308)
	If (OK=1)
		[eWires:13]toCountry:10:=[Countries:62]CountryName:2
		READ ONLY:C145([Agents:22])
		QUERY:C277([Agents:22]; [Agents:22]Country:5=[eWires:13]toCountry:10; *)
		QUERY:C277([Agents:22];  & ; [Agents:22]isSuperAgent:16=True:C214)
		
		If (Records in selection:C76([Agents:22])>0)
			FIRST RECORD:C50([Agents:22])
			[eWires:13]AgentID:26:=[Agents:22]AgentID:1
			OBJECT SET ENTERABLE:C238([eWires:13]AgentID:26; True:C214)
			selectLinksByCustIDnCountry
		Else 
			[eWires:13]AgentID:26:=""
			OBJECT SET ENTERABLE:C238([eWires:13]AgentID:26; False:C215)
		End if 
	End if 
	
End if 

