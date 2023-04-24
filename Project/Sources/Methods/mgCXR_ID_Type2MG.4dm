//%attributes = {}
// returns one of ALN|DRV|GOV|PAS|STA based on CXR type id passed
// #ORDA
//  //MGCodes: DRV=Driver's License Number, PAS=Passport, GOV=Government ID, ALN=Alien ID

C_TEXT:C284($0)
C_TEXT:C284($1; $cxrIDType)
C_OBJECT:C1216($es; $entity)

$cxrIDType:=$1

$es:=ds:C1482.PictureIDTypes.query("PictureIDType = :1"; $cxrIDType)

If ($es#Null:C1517)
	
	If ($es.length>0)
		
		$entity:=$es.first()
		
		If ($entity#Null:C1517)
			
			Case of 
				: ($entity.PictureIDType="")  //blank
					$0:=""
					
				: ($entity.PictureIDType="@Passport@")
					$0:="PAS"
					
				: ($entity.PictureIDType="@Driver's License@") | ($entity.PictureIDType="@Drivers License@")\
					 | ($entity.PictureIDType="@Driver License@")
					$0:="DRV"
					
				: ($entity.PictureIDType="@Government@")
					$0:="GOV"
					
				: ($entity.PictureIDType="@Alien@")
					$0:="ALN"
					
				: ($entity.PictureIDType="@Proof of Address@")  //nothing corresponds
					$0:=""
					
				: ($entity.PictureIDType="@Bank@") | ($entity.PictureIDType="@Credit@")\
					 | ($entity.PictureIDType="@Debit@")  //nothing corresponds
					$0:=""
					
				Else 
					$0:="GOV"
			End case 
			
		End if 
		
	End if 
	
End if 
