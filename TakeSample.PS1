# +-------------------------------------------------------------------------------------------+
# | Author...........: Deon Pollard.  Deon Pollard & Associates                               |
# | Date.............: 19 Nov 2018                                                            |
# | Description......: Script to sample list of Files created by GetList script               |
# | Parameters.......: $IPath Path and filename of input CSV that was created by Getlist.PS1  |
# | Parameters.......: $OPath Path and filename of output CSV that contains sample            |
# | Parameters.......: $Percent Percentage of original input that is considered representative|
# +-------------------------------------------------------------------------------------------+
$IPath = "Files1.csv"
$OPath = "Sample.csv"
$Percent = .3
# =============================================================================================
#
$Output = @()
$P = Import-Csv $IPath
$NumSamples = $P.Count*$Percent
$Num = [math]::Round($NumSamples)
For ($i=0; $i -le $Num; $i++) {
    $R = Get-Random -Maximum $P.Count
    # "$R = " + $R + $P[$R]
    # Create a new object to store this information
      $Props = @{
		"BaseName" = $P.Basename[$R]
		"Name" = $P.Name[$R]
		"FullName" = $P.FullName[$R]
		"CreationTime" = $P.CreationTime[$R]
 		"LastAccessTime" = $P.LastAccessTime[$R]
		"Extension" = $P.Extension[$R]
                "SampleTot" = $P.Count
		"SampleNum" = $R
		"SampleTime" = Get-Date -Format g
		}
	# Add the object to our array of output objects
	$Output += New-Object PSObject -Property $Props
    }
$Output | Export-CSV $OPath -NoTypeInformation