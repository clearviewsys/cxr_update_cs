//%attributes = {}
//author: Amir
//5th Nov. 2019
//BisN_getEnviroment()
//validates and returns the environment ("test" or "prod"). default is "prod", in case key value pair doesnt exist
C_TEXT:C284($0; $environment)
$environment:=getKeyValue("BisN.environment"; "prod")
ASSERT:C1129(($environment="test") | ($environment="prod"); "Expected 'test' or 'prod' for environment")
$0:=$environment