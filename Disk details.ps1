function Get-RemoteComputerDisk
{
    
    Param
    (
        $RemoteComputerName
    )

    Begin
    {
        $output="Drive `t TotalSpace(in GB) `t UsedSpace(in GB) `t FreeSpace(in GB) `t Utilization(%)`n"
    }
    Process
    {
        $drives=Get-WmiObject Win32_Logicaldisk | Where-Object {$_.DriveType -eq 3}

        foreach ($drive in $drives){
            
            $drivename=$drive.DeviceID
            $freespace=[int]($drive.FreeSpace/1GB)
            $totalspace=[int]($drive.Size/1GB)
            $usedspace=$totalspace - $freespace
            $percentageUtilization=((($totalspace - $freespace)/$totalspace)*100)
            $percentage=[math]::Round($percentageUtilization,2)
            $output=$output+$drivename+"`t`t`t`t"+$totalspace+"`t`t`t`t"+$usedspace+"`t`t`t`t`t"+$freespace+"`t`t`t`t`t"+$percentage+"`n"
        }
    }
    End
    {
        return $output
    }
}