//%attributes = {}

// sanctionListResultPic

C_PICTURE:C286($0; $pic)
loadPictureResource("AlertOk"; ->$pic)
//GET PICTURE FROM LIBRARY("AlertOk"; $pic)

Case of 
		
	: ([SanctionCheckLog:111]CheckResult:10=-1)  // It was not possible to check (webservice down)
		
		loadPictureResource("AlertFail"; ->$pic)
		//GET PICTURE FROM LIBRARY("AlertFail"; $pic)
		
	: ([SanctionCheckLog:111]CheckResult:10=0)
		loadPictureResource("AlertOk"; ->$pic)
		GET PICTURE FROM LIBRARY:C565("AlertOk"; $pic)
		
	: ([SanctionCheckLog:111]CheckResult:10=2)  // Exact Match
		loadPictureResource("AlertRed"; ->$pic)
		//GET PICTURE FROM LIBRARY("AlertRed"; $pic)
		
	: ([SanctionCheckLog:111]CheckResult:10=1)  // No Exact Match
		loadPictureResource("AlertOrange"; ->$pic)
		//GET PICTURE FROM LIBRARY("AlertOrange"; $pic)
		
End case 

TRANSFORM PICTURE:C988($pic; Scale:K61:2; 0.4; 0.4)
$0:=$pic
