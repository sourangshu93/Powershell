function Get-RemoteComputerDisk
{
    
    Param
    (
        $RemoteComputerName
    )

    Begin
    {
        $output="Drive `t UsedSpace(in GB) `t FreeSpace(in GB) `t TotalSpace(in GB) `t Utilization(%)`n"
    }
    Process
    {
        $drives=Get-WmiObject Win32_LogicalDisk -ComputerName $RemoteComputerName

        foreach ($drive in $drives){
            
            $drivename=$drive.DeviceID
            $freespace=[int]($drive.FreeSpace/1GB)
            $totalspace=[int]($drive.Size/1GB)
            $usedspace=$totalspace - $freespace
            $percentageUtilization=[int]((($totalspace - $freespace)/$totalspace)*100)
            $output=$output+$drivename+"`t`t`t`t"+$usedspace+"`t`t`t`t"+$freespace+"`t`t`t`t`t"+$totalspace+"`t`t`t`t`t"+$percentageUtilization+"`n"
        }
    }
    End
    {
        return $output
    }
}