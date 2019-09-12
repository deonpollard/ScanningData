# +-------------------------------------------------------------------------------------------+
# | Author...........: Deon Pollard.  Deon Pollard & Associates                               |
# | Date.............: 06 Jul 2019.  Updated 20190813                                         |
# | Description......: Script to is list all files from a given root folder. All sub-folders  |
# |                    will be included. Convert Output ot CSV file for Import by seeWaybeyond|
# | Parameters.......: See 7 parameters below                                                 |
# +-------------------------------------------------------------------------------------------+
#
#=====Begin P==A==R==A==M==E==T==E==R==S=======================================================
#
#== Arbitrary name you want the Source known by
$SourceName = $Env:Computername + " Senya" 
#== Name of the Endeavor within seeWaybeyond where this data must reside
$DMOName = "Test1" 
#== Name of the Project within seeWaybeyond where this data must reside
$ProjectName = "Senya" 
#== your seeWaybeyond login
$UserName = "deon.pollard@acme.com"
#== Name of the Path to scan
$IPath = "C:\Projects\SENYA" 
#== Name of the Path and FileName which will contain Raw scanned data e.g. list of all files with attributes
$OPath = "C:\Projects\Endeavors\DataButler\RawFiles.csv"
#== Name of the Path and FileName which will contain ready-made imported data for seeWaybeyond
$OOPath = "C:\Projects\Endeavors\DataButler\3SixtyFiles.csv"
#
#=====End P==A==R==A==M==E==T==E==R==S=========================================================
Get-ChildItem -Path $IPath -Force -File -Recurse | Export-Csv -Path $OPath -NoTypeInformation
$New = Import-Csv -Path $OPath
$holdarr = @()
$Counter=0
$Increment=0
 foreach($i in $New) 
      {
      $Counter++
      $Increment++
      $obj = new-object PSObject
        $obj | add-member -membertype NoteProperty -name "SrcObjID" -value "FileSystem"
        $obj | add-member -membertype NoteProperty -name "DMOName" -value $DMOName
	$obj | add-member -membertype NoteProperty -name "ProjectName" -value $ProjectName
	$obj | add-member -membertype NoteProperty -name "UserName" -value $UserName
        $obj | add-member -membertype NoteProperty -name "SrcName" -value $SourceName
        $obj | add-member -membertype NoteProperty -name "SrcObjLevel1" -value $SourceName
	$obj | add-member -membertype NoteProperty -name "SrcObjLevel2" -value $i.Directory
        $obj | add-member -membertype NoteProperty -name "SrcObjLevel3" -value $i.Name
        $obj | add-member -membertype NoteProperty -name "Name" -value $i.BaseName
        $obj | add-member -membertype NoteProperty -name "Description" -value $i.FullName
        $obj | add-member -membertype NoteProperty -name "SrcObjDataType" -value $i.Extension
        $obj | add-member -membertype NoteProperty -name "SrcObjDataTypeLen" -value $i.Length
        $obj | add-member -membertype NoteProperty -name "About" -value "File"
        $obj | add-member -membertype NoteProperty -name "PIIType" -value $i.Extension
        $obj | add-member -membertype NoteProperty -name "Counter" -value $Counter
      $holdarr+=$obj
      $obj=$null
       }
If ($Increment -gt 100) {
    Write-host "Extracting " $Counter
    }
$holdarr | Export-Csv -Path $OOPath -NoTypeInformation
Write-Host $Counter  " Files harvested"