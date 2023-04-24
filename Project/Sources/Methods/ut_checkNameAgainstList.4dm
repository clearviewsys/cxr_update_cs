//%attributes = {"shared":true}
// __UNIT_TEST
//By @Zoya - June 2021
C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("checkNameAgainstList"; Current method name:C684; "AML.Sanction Check")
C_LONGINT:C283($num)
ARRAY TEXT:C222($arr_names1; 22)
ARRAY TEXT:C222($arr_names2; 15)
C_LONGINT:C283($i; $j)
C_TEXT:C284($line)
//$i:=1
//$j:=1
C_TEXT:C284($text1; $text2)
$text1:="Ashley Chester\rDan Curtis \rGuy Ryder\rHugo Hans Siblesz\rJanet Austin\rJens Stoltenberg\rKristalina Georgieva\rLaura Ellen Ryder \rMin "+"Aung Hlaing\rNaela Chohan\rNorbert Walter-Borjans\rPaul Beaudry \rPiotr Hofmański \rRalph Goodale\rRam Nath Kovind \rRichard Wagner\rRoxanne Hardy\rSebastian Kur"+"z\rSergei Nikolaevich Lebedev\rSusanne Thier\rTedros Adhanom\rTiff Macklem\r"
$text2:="Catherine Mandville \rElizabeth Greene\rFahad Al Raqbani\rGraciela Dixon\rGraciela Libertad \rHumberto Cerrud\rMathais Cormann \rNancy Green Raine\rNeheed Neshi\rPablo Rodriquez\rPamela Goodale\rRodolfo Dia Robles\rRosemary Macklem\rShaheen Neshi Nathoo\rSoumya Sw"+"aminathan Yadov\rWilly Raine\r"

For each ($line; Split string:C1554($text1; "\r"))
	If (($i<Size of array:C274($arr_names1)))
		$arr_names1{$i}:=$line
		
		AJ_assert($test; Length:C16(checkNameAgainstList($arr_names1{$i}; ->$num; False:C215; "PEP"; True:C214))>0; True:C214; $arr_names1{$i}; "true as there is a hit")
		$i:=$i+1
	End if 
End for each 
//ALERT(String(Size of array($arr_names1)))
//ALERT(checkNameAgainstList($arr_names1{21}; ->$num; False; "PEP"; True))
//ALERT(checkNameAgainstList($arr_names1{22}; ->$num; False; "PEP"; True))

For each ($line; Split string:C1554($text2; "\r"))
	If (($j<Size of array:C274($arr_names2)))
		$arr_names2{$j}:=$line
		
		AJ_assert($test; Length:C16(checkNameAgainstList($arr_names2{$j}; ->$num; False:C215; "PEP"; False:C215))>0; False:C215; $arr_names2{$j}; "False as there is no hit")
		$j:=$j+1
	End if 
End for each 



