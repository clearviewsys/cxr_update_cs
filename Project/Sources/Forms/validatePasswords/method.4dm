Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		var $i : Integer
		
		Form:C1466.users:=New object:C1471
		Form:C1466.users.values:=New collection:C1472
		Form:C1466.userlist:=New collection:C1472
		
		ARRAY TEXT:C222($accountNames; 0)
		ARRAY INTEGER:C220($accoutNumbers; 0)
		
		GET USER LIST:C609($accountNames; $accoutNumbers)
		
		For ($i; 1; Size of array:C274($accountNames))
			
			Form:C1466.users.values.push($accountNames{$i})
			Form:C1466.userlist.push(New object:C1471("index"; $accoutNumbers{$i}; "username"; $accountNames{$i}))
			
		End for 
		
		
End case 
