<?php

// Checks if the email is valid
function checkEmail($email) {
	
	if (!filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
		return true;
	} else {
		return false;
	}
}

function lineIsCommented($input_str) {
	// Detect if the pattern is a comment (starting with //)
	$pattern='/\s*\/\/\s*(.*)/i';
	preg_match_all ($pattern, $input_str, $matches_out);
	if (count($matches_out[0])>0) {
		return true;	
	} else {
		return false;	
	}
}

function captureByRegExp($input_str, $type) {
	
	
	switch ($type) {
		// json_plugin functions
		
		case "json_newObject ":  
			$pattern='/((.*)):=\s*json_newObject/i';
			break;
				
		
		// FYI Messages:
		
		case "myAlert ":  // Leave space before closing quote
			$pattern='/myAlert\s\((.*)\)/i';
			break;
		case "myConfirm ": // Leave space before closing quote
			$pattern='/myConfirm\s\((.*)\)/i';
			break;
		case "CONFIRM": // No space before closing quote
			$pattern='/CONFIRM\((.*)\)/i';
			break;
		case "ALERT": // No space before closing quote
			$pattern='/ALERT\((.*)\)/i';
			break;		
		case "Select folder": // No space before closing quote
			$pattern='/Select folder\((.*)\)/i';
			break;		
		
		// Fixed Strings:
		
		case "setErrorTrap ": // Leave Space before closing quote
			$pattern='/setErrorTrap\s\((.*)\)/i';
			break;		
		case "appendLabelString ": // Leave Space before closing quote
			$pattern='/appendLabelString\s\((.*)\)/i';
			break;		
		case "setRequestString ": // Leave Space before closing quote
			$pattern='/setRequestString\s\((.*)\)/i';
			break;
		case "setProgressBarTitle ": // Leave Space before closing quote
			$pattern='/setProgressBarTitle\s\((.*)\)/i';
			break;
		case "Progress SET PROGRESS ": // Leave Space before closing quote
			$pattern='/Progress SET PROGRESS\s\((.*)\)/i';
			break;			
		case "Progress SET TITLE ": // Leave Space before closing quote
			$pattern='/Progress SET TITLE\s\((.*)\)/i';
			break;			
		case "Request ": // Leave Space before closing quote
			$pattern='/Request\s\((.*)\)/i';
			break;
		case "checkUniqueKey ": // Leave Space before closing quote
			$pattern='/checkUniqueKey\s\((.*)\)/i';
			break;
		case "checkGreaterThan ": // Leave Space before closing quote
			$pattern='/checkGreaterThan\s\((.*)\)/i';
			break;
		default:
			$pattern='/'.$type.'\s\((.*)\)/i';

	}
	// see https://www.phpliveregex.com/#tab-preg-match-all
	preg_match_all ($pattern, $input_str, $matches_out);
	return ($matches_out[1]);
	
}

function CVS_urlsWithTags($str) {
	
	preg_match_all('/<a href="(.*?)"/', $str, $matches);
	$matches=$matches[0];
	$max=count($matches);
	
	for($i = 0; $i < $max; $i++){
		$matches[$i] = str_replace ("\"", "", $matches[$i]);
		$matches[$i] = str_replace ("<a href=", "", $matches[$i]);
		
	}
	return ($matches);


}

function CVS_allURLs($str) {

	// Get all URLs
	preg_match_all("/(?i)\b((?:[a-z][\w-]+:(?:\/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'\".,<>?]))/", $str, $matches);

	$matches = array_unique($matches[0]);
	$matches = array_values($matches); // reindex array starting to 0

	$toDelete=array();
	$max=count($matches);
	
	for ($i = 0; $i < $max; $i++){
			$find   = 'https://';
		$protocol = strstr($matches[$i], $find);
	    // Delete element from array if The string 'http://' is not found in the URL"
		if ( $protocol === false){
			$find   = 'http://';
			$protocol = strstr($matches[$i], $find);
			
			if ( $protocol === false){
				
				$find   = 'www.';
				$protocol = strstr($matches[$i], $find);
				if ( $protocol === false){
					echo "<br>{$i}: https, http, www no found - {$matches[$i]} - DELETE";
					array_push($toDelete, $i);
				} else {
					echo "<br>{$i}: www found - {$matches[$i]} ";	
				} 

			} else {
					echo "<br>{$i}: http found - {$matches[$i]} ";	
			}
		} else {
			echo "<br>{$i}: https found - {$matches[$i]} ";
		} 	
		
	} // ($i = 0; $i < $max; $i++){
		
	// Delete URLs without protocol
	$max=count($toDelete);
	for ($i = 0; $i < $max; $i++){
		unset ($matches[$toDelete[$i]]);
	}	
	
	$output = array_values($matches); // reindex array starting to 0
	return ($output);
	
}

function unzip($src,$dest) { 
  $zip = new ZipArchive;
  if ($zip->open($src) === TRUE) { 
    $zip->extractTo($dest); 
    $zip->close(); 
    return TRUE; 
  } else { 
    return FALSE; 
  }
} 


?>

