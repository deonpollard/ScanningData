# +-------------------------------------------------------------------------------------------+
# | Author...........: Deon Pollard.  Deon Pollard & Associates                               |
# | Date.............: 27 Nov 2018                                                            |
# | Description......: Script to enrich Office type files from sample.csv                     |
# | Parameters.......: $SPath Path and filename to DSOFILE Macro                              |
# | Parameters.......: $IPath Path and filename to output CSV file containing scanned content |
# | Notes............:                                                                        |
# |      ............: Please install DSOFile for 64bit environment see                       |
# |      .... https://www.codeproject.com/Tips/1118708/Bit-Application-Cannot-Use-DSOfile     |
# |      also see https://pcast01.github.io/Start-Excel-Macro-From-PowerShell/                |
# +-------------------------------------------------------------------------------------------+
Function RunExcelMacro()
 {
    # Open Excel file

    $SPath = "C:\Users\deonp\dsofile.xlsm"

    $IPath = "sample.csv"

    $excel = new-object -comobject excel.application

    $workbook = $excel.Workbooks.Open($SPath)
    $excel.Visible = $true

    $worksheet = $workbook.worksheets.item(1)

    Write-Host "Running macro in excel to scrub data."

    $files = Import-Csv $IPath
    $i = 1 # start with row 2 to leave header

    foreach ($file in $files) {

      if (($file.Extension -eq ".docx") -or ($file.Extension -eq ".pptx") -or ($file.Extension -eq ".xlsx") -or ($file.Extension -eq ".xls"))
 
        {
         
          $i = $i + 1

          Write-Host ("Calling " + $i + " " + $file.FullName)

          $excel.Run("mysub", $file.FullName, $i)
        
         }

    }
 
    $workbook.save()

    $workbook.close()

    $excel.quit()
    Write-Host "Closed Excel"

  }

RunExcelMacro