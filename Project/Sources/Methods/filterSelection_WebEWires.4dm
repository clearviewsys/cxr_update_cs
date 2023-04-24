//%attributes = {}
C_TEXT:C284($tContext)
C_LONGINT:C283($i)


$tContext:=webContext



Case of 
	: ($tContext="agent@")
		If (pq_table="webewires")  //a grid
			//confirmed should drop off after the current date
			QUERY SELECTION:C341([WebEWires:149]; [WebEWires:149]status:16<20; *)
			QUERY SELECTION:C341([WebEWires:149];  | ; [WebEWires:149]confirmedDate:30=Current date:C33)
		End if 
		
	: ($tContext="customer@")
		//problay need to verify we have the correct customer
		webSelectCustomerRecord
		
		////it waiting on payment -- check to see if it has happened b/c poli we have to pull that info
		//CREATE SET([WebEWires]; "$origSet")
		//QUERY SELECTION([WebEWires]; [WebEWires]status<10; *)
		//QUERY SELECTION([WebEWires];  & ; [WebEWires]status>=0; *)
		//QUERY SELECTION([WebEWires];  & ; [WebEWires]WebEwireID#"MGS@")
		
		//For ($i; 1; Records in selection([WebEWires]))
		//setWebEwirePaymentStatus
		//NEXT RECORD([WebEWires])
		//End for 
		
		//USE SET("$origSet")
		//CLEAR SET("$origSet")
		
	Else 
		REDUCE SELECTION:C351([WebEWires:149]; 0)
		
End case 