//%attributes = {}

C_TEXT:C284($1; $table)
C_TEXT:C284($2; $recordID)
C_POINTER:C301($3; $ptrNameArray)
C_POINTER:C301($4; $ptrValueArray)

C_TEXT:C284($0)

C_OBJECT:C1216($entity; $status; $record)
C_TEXT:C284($result; $context; $grid)

$table:=$1
$recordID:=$2
$ptrNameArray:=$3
$ptrValueArray:=$4

$result:=""

If ($table=Table name:C256(->[WebEWires:149]))
	
	$context:=WAPI_getSession("context")
	
	Case of 
		: ($context="customers")
			webSelectCustomerRecord
			
			$entity:=ds:C1482.WebEWires.query("WebEwireID == :1 AND CustomerID == :2"; $recordID; [Customers:3]CustomerID:1)
			
			If ($entity.length=1)
				$record:=$entity.first()
				
				If ($record.status>=0) & ($record.status<=10)  //ONLY DRAFT OR PENDING CAN BE CANCELLED - changed to 10 2/14/22
					$record.status:=-10
					$record.isCancelled:=True:C214
					$status:=$record.save()
					
					If ($status.success=True:C214)
						
						$grid:=WAPI_getParameter("grid")
						$result:=WAPI_displayMessage("Cancelled"; "The eWire Request has been cancelled.")
						
						If ($grid="")
							$result:=$result+"pq.grid('#grid-webewires').refreshDataAndView();"
						Else 
							$result:=$result+"pq.grid('#"+$grid+"').refreshDataAndView();"
						End if 
						
					Else 
						$result:=WAPI_displayMessage("ERROR"; "The eWire Request  could NOT be cancelled.")
					End if 
					
				Else 
					$result:=WAPI_displayMessage("ERROR"; "The eWire Request  has already been processed. Can NOT be cancelled.")
				End if 
				
			Else 
				$result:=WAPI_displayMessage("ERROR"; "The eWire Request  could NOT be cancelled.")
			End if 
			
		: ($context="agents")
			webSelectAgentRecord
			
			If (False:C215)
				READ WRITE:C146([WebEWires:149])
				QUERY:C277([WebEWires:149]; [WebEWires:149]WebEwireID:1=$recordID)
				
				If (Records in selection:C76([WebEWires:149])=1)
					If ([WebEWires:149]status:16=0)
						[WebEWires:149]status:16:=-10
						[WebEWires:149]isCancelled:20:=True:C214
						SAVE RECORD:C53([WebEWires:149])
						
						$grid:=WAPI_getParameter("grid")
						//$result:=WAPI_displayMessage ("Cancelled";"The eWire Request has been cancelled.")
						
						If ($grid="")
							$result:=$result+"pq.grid('#grid-webewires-approve').refreshDataAndView();"
						Else 
							//$result:=$result+"pq.grid('#"+$grid+"').refreshDataAndView();"
							$result:=$result+"pq.grid('#"+$grid+"').filter()"
						End if 
					Else 
						$result:=WAPI_displayMessage("ERROR"; "The eWire Request  has already been processed. Can NOT be cancelled.")
					End if 
					
				Else 
					$result:=WAPI_displayMessage("ERROR"; "The eWire Request  could NOT be cancelled.")
				End if 
				
			Else 
				$entity:=ds:C1482.WebEWires.query("WebEwireID == :1 "; $recordID)
				
				If ($entity.length=1)
					$record:=$entity.first()
					
					If ($record.status>=0) & ($record.status<=5)  //ONLY DRAFT OR PENDING CAN BE CANCELLED
						$record.status:=-10
						$record.isCancelled:=True:C214
						$status:=$record.save()
						
						If ($status.success=True:C214)
							$grid:=WAPI_getParameter("grid")
							$result:=WAPI_displayMessage("Cancelled"; "The Send Money Request has been cancelled.")
							
							If ($grid="")
								$result:=$result+"pq.grid('#grid-webewires-approve').refreshDataAndView();"
							Else 
								//$result:=$result+"pq.grid('#"+$grid+"').refreshDataAndView();"
								$result:=$result+"pq.grid('#"+$grid+"').filter()"
							End if 
							
						Else 
							$result:=WAPI_displayMessage("ERROR"; "The Send Money Request  could NOT be cancelled.")
						End if 
						
					Else 
						$result:=WAPI_displayMessage("ERROR"; "The Send Money Request  has already been processed. Can NOT be cancelled.")
					End if 
					
				Else 
					$result:=WAPI_displayMessage("ERROR"; "The Send Money Request  could NOT be cancelled.")
				End if 
			End if 
			
		Else 
			
			
	End case 
	
Else 
	$result:=WAPI_displayMessage("ERROR"; "The TABLE is Unknown.")
End if 

$0:=$result