C_POINTER:C301($url_ptr; $pic_ptr)

$url_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "url")

If ($url_ptr->#"")
	
	$pic_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "image")
	
	$pic_ptr->:=getImageFromURL($url_ptr->)
	
End if 
