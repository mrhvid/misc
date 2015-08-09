

# Following https://bladefirelight.wordpress.com/2015/05/19/creating-a-small-footprint-base-image-part-1-vhdx-from-iso/ 

# ------
# Pre req
# Download server 2012r2 iso
# Download https://gallery.technet.microsoft.com/scriptcenter/Convert-WindowsImageps1-0fe23a8f place in c:\temp
Unblock-File C:\temp\Convert-WindowsImage.ps1




$Server2012r2ISO = 'C:\iso\Server2012R29600.17050.WINBLUE_REFRESH.140317-1640.ISO'

$Mount = Mount-DiskImage -ImagePath $Server2012r2ISO -PassThru
$DriveLetter = $Mount | Get-Volume | Select-Object -ExpandProperty DriveLetter



G:\temp\Convert-WindowsImage.ps1 -SourcePath h:\sources\install.wim -VHDPath G:\temp\CoreFromIso.vhdx -SizeBytes 20gb -VHDType Dynamic -VHDFormat VHDX -VHDPartitionStyle GPT -Edition 3 -Verbose