

# Following https://bladefirelight.wordpress.com/2015/05/19/creating-a-small-footprint-base-image-part-1-vhdx-from-iso/ 

# ------------
# Pre req
# ------------
# Download server 2012r2 iso
    $Server2012r2ISO = 'C:\iso\Server2012R29600.17050.WINBLUE_REFRESH.140317-1640.ISO'
# Download https://gallery.technet.microsoft.com/scriptcenter/Convert-WindowsImageps1-0fe23a8f place in
    $TempDir = 'C:\Temp'
    Unblock-File "$TempDir\Convert-WindowsImage.ps1"
    Set-Location $TempDir



$Mount = Mount-DiskImage -ImagePath $Server2012r2ISO -PassThru
$DriveLetter = $Mount | Get-Volume | Select-Object -ExpandProperty DriveLetter

Convert-WindowsImage.ps1 -SourcePath $DriveLetter+':\sources\install.wim' -VHDPath $TempDir+'\CoreFromIso.vhdx' -SizeBytes 40gb -VHDType Dynamic -VHDFormat VHDX -VHDPartitionStyle GPT -Edition 3 -Verbose
Convert-WindowsImage.ps1 -SourcePath $DriveLetter+':\sources\install.wim' -VHDPath $TempDir+'\GUIFromIso.vhdx' -SizeBytes 40gb -VHDType Dynamic -VHDFormat VHDX -VHDPartitionStyle GPT -Edition 4 -Verbose