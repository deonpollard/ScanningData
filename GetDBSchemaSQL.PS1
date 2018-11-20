# +-------------------------------------------------------------------------------------------+
# | Author...........: Deon Pollard.  Deon Pollard & Associates                               |
# | Date.............: 20 Nov 2018                                                            |
# | Description......: Script to list schema from SQL DB                                      |
# |                    will be included.                                                      |
# | Parameters.......: $OPath Path and filename to output CSV file containing scanned content |
# | Parameters.......: $DBName Name of Database to scan                                       |
# | Parameters.......: $DBInstance NServerInstance of SQL Server                              |
# +-------------------------------------------------------------------------------------------+
$OPath = "DB.csv"
$DBName = "AdventureWorks2016CTP3"
$DBInstance = "DESKTOP-62EACQT\SQLEXPRESS"
Invoke-Sqlcmd -Query "Use $DBName; SELECT * FROM INFORMATION_SCHEMA.COLUMNS;" -ServerInstance $DBInstance | Export-Csv $OPath -NoTypeInformation