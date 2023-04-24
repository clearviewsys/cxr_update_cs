Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		var $index : Integer
		$index:=OBJECT Get pointer:C1124(Object current:K67:2)->
		var $name : Text
		$name:=Form:C1466.facets[$index-1]
		Form:C1466.facet:=Form:C1466.details.facets[$name]
End case 