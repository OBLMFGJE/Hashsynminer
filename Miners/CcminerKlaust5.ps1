﻿$Path = '.\Bin\NVIDIA-KlausT5\ccminer.exe'
$Uri = 'https://github.com/KlausT/ccminer/releases/download/8.21/ccminer-821-cuda91-x64.zip'

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    #Lyra2z = 'lyra2z' #not supported
    #Equihash = 'equihash' #not supported
    #Cryptonight = 'cryptonight' #not supported
    #Ethash = 'ethash' #not supported
    #Sia = 'sia' #use TpruvoT
    #Yescrypt = 'yescrypt' #use TpruvoT
    #BlakeVanilla = 'vanilla'
    Lyra2RE2 = 'lyra2v2' #use TpruvoT
    #Skein = 'skein' #use TpruvoT
    #Qubit = 'qubit' #use TpruvoT
    NeoScrypt = 'neoscrypt'
    #X11 = 'x11' #use TpruvoT
    #MyriadGroestl = 'myr-gr'
    Groestl = 'groestl'
    #Keccak = 'keccak' #use TpruvoT
    #Scrypt = 'scrypt' #use TpruvoT
    #Nist5 = 'nist5'
}

$Optimizations = [PSCustomObject]@{
    Lyra2z = ''
    Equihash = ''
    Cryptonight = ''
    Ethash = ''
    Sia = ''
    Yescrypt = ''
    BlakeVanilla = ''
    Lyra2RE2 = ' -d $SplitSniffCC5'
    Skein = ''
    Qubit = ''
    NeoScrypt = ' -d $SplitSniffCC5'
    X11 = ''
    MyriadGroestl = ''
    Groestl = ' -d $SplitSniffCC5'
    Keccak = ''
    Scrypt = ''
    Nist5 = ' -d $SplitSniffCC5'
}

$Algorithms | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = 'NVIDIA5'
        Path = $Path
        Arguments = -Join ('-a ', $Algorithms.$_, ' -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -b 0.0.0.0:4073 -u $($Pools.', $_, '.User5) -p $($Pools.', $_, '.Pass5)', $Optimizations.$_)
        HashRates = [PSCustomObject]@{$_ = -Join ('$($Stats.', $Name, '_', $_, '_HashRate.Week)')}
        API = 'Ccminer'
        Port = 4073
        Wrap = $false
        URI = $Uri
    }
}
