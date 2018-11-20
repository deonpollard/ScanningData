# +-------------------------------------------------------------------------------------------+
# | Author...........: Deon Pollard.  Deon Pollard & Associates                               |
# | Date.............: 19 Nov 2018                                                            |
# | Description......: Script to is list all files from a given root folder. All sub-folders  |
# |                    will be included.                                                      |
# | Parameters.......: $IPath Path to input folder to be scanned                              |
# | Parameters.......: $OPath Path and filename to output CSV file containing scanned content |
# +-------------------------------------------------------------------------------------------+
$IPath = "C:\Projects\clients\sanlam\aml"
$OPath = "Files.csv"
Get-ChildItem -Path $IPath -Force -File -Recurse | Export-Csv $OPath
