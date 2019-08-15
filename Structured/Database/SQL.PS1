# +-------------------------------------------------------------------------------------------+
# | Author...........: Deon Pollard.  Deon Pollard & Associates                               |
# | Date.............: 15 Aug 2019                                                            |
# | Description......: Script to list schema from SQL DB and get into seeWaybeyond format     |
# |                    will be included.                                                      |
# | Parameters.......: $OPath Path and filename to output CSV file containing scanned content |
# | Parameters.......: $DBName Name of Database to scan                                       |
# | Parameters.......: $DBInstance NServerInstance of SQL Server                              |
# +-------------------------------------------------------------------------------------------+
param(
  [string]$Drop
)
# Check if external name was supplied 
if ($Drop.length -lt 2) {
    # Write-Output "Please enter Path and filename of attachment"
    $Drop = "C:\Users\deonp\DB.csv"
	}
$OPath = $Drop
#== Name of the Endeavor within seeWaybeyond where this data must reside
$DMOName = "Raw" 
#== Name of the Project within seeWaybeyond where this data must reside
$ProjectName = "SQLDB" 
#== your seeWaybeyond login
$UserName = "deon.pollard@senya.co.uk"
#== Name of the Path and FileName which will contain ready-made imported data for seeWaybeyond
$OOPath = "C:\Projects\Endeavors\DataButler\DBSQL.csv"
$DBName = "AdventureWorks2016CTP3"
$DBInstance = "DESKTOP-62EACQT\SQLEXPRESS"
Invoke-Sqlcmd -Query "Use $DBName; SELECT * FROM INFORMATION_SCHEMA.COLUMNS;" -ServerInstance $DBInstance | Export-Csv $OPath -NoTypeInformation
#=====End P==A==R==A==M==E==T==E==R==S=========================================================
#Get-ChildItem -Path $IPath -Force -File -Recurse | Export-Csv -Path $OPath -NoTypeInformation
$New = Import-Csv -Path "C:\Users\deonp\DB.csv"
$holdarr = @()
$Counter=0
$Increment=0
 foreach($i in $New) 
      {
      $Counter++
      $Increment++
      $obj = new-object PSObject
        $obj | add-member -membertype NoteProperty -name "DMOName" -value $DMOName
	    $obj | add-member -membertype NoteProperty -name "ProjectName" -value $ProjectName
	    $obj | add-member -membertype NoteProperty -name "UserName" -value $UserName
        $obj | add-member -membertype NoteProperty -name "SrcObjID" -value "Database"
        $obj | add-member -membertype NoteProperty -name "SrcName" -value $i.COLUMN_Name
        $obj | add-member -membertype NoteProperty -name "SrcObjLevel1" -value $i.TABLE_CATALOG
        $obj | add-member -membertype NoteProperty -name "SrcObjLevel2" -value $i.TABLE_NAME
        $obj | add-member -membertype NoteProperty -name "SrcObjLevel3" -value $i.COLUMN_Name
        $obj | add-member -membertype NoteProperty -name "Name" -value $i.COLUMN_Name
        $obj | add-member -membertype NoteProperty -name "SrcObjDataType" -value $i.DATA_TYPE
        $obj | add-member -membertype NoteProperty -name "SrcObjDataTypeLen" -value $i.CHARACTER_MAXIMUM_LENGTH
        $obj | add-member -membertype NoteProperty -name "About" -value "Database"
        $obj | add-member -membertype NoteProperty -name "PIIType" -value $i.TABLE_NAME
        $obj | add-member -membertype NoteProperty -name "Counter" -value $Counter
      $holdarr+=$obj
      $obj=$null
       }
If ($Increment -gt 100) {
    Write-host "Extracting " $Counter
    }
$holdarr | Export-Csv -Path $OOPath -NoTypeInformation
Write-Host $Counter  " Database Elements harvested"