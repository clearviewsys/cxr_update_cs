//%attributes = {}
[MACs:18]SettingName:17:="Demo:"+String:C10(Current date:C33)
[MACs:18]ExpirationDate:2:=Current date:C33+30  //expire in four weeks
[MACs:18]LaunchLimit:3:=100  // or after 100 launches of the program
[MACs:18]allowWebServing:21:=False:C215