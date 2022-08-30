//%attributes = {}
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		READ ONLY:C145([Countries:62])
		READ ONLY:C145([PictureIDTypes:92])
		
		QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[Links:17]PictureIDIssuedIn:37)
		QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Links:17]PictureIDType:34)
		
		OBJECT SET TITLE:C194(*; "pictureIDCountryName"; [Countries:62]CountryName:2)
		OBJECT SET TITLE:C194(*; "PictureIDDescription"; [PictureIDTypes:92]Description:14)
		
		
End case 
