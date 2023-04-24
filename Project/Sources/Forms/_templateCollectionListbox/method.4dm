Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		C_OBJECT:C1216($entity)
		C_DATE:C307($from)
		C_COLLECTION:C1488($col)
		
		$from:=Add to date:C393(!00-00-00!; 1994; 1; 1)
		
		Form:C1466.mainlist:=New collection:C1472
		
		// $col:=ds.Customers.all().toCollection()
		$col:=ds:C1482.Customers.query("DOB > :1"; $from).toCollection()
		
		For each ($entity; $col)
			
			OB REMOVE:C1226($entity; "ID")
			
			Form:C1466.mainlist.push($entity)
			
		End for each 
		
End case 
