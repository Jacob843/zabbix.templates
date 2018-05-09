# Desenvolvido por Diego Cavalcante - 10/02/2017
# Monitoramento Windows RDP - Terminal Server

Param(
  [string]$select
)

# Nome dos Usuarios Ativos
if ( $select -eq 'ACTIVE' )
{
Import-Module PSTerminalServices
Get-TSSession -State Active -ComputerName localhost | foreach {$_.UserName}
}

# Total de Usuarios Ativos
if ( $select -eq 'ACTIVENUM' )
{
Import-Module PSTerminalServices
Get-TSSession -State Active -ComputerName localhost | foreach {$_.UserName} | Measure-Object -Line | select-object Lines | select-object -ExpandProperty Lines
}

# Nome dos Usuarios Inativos
if ( $select -eq 'INACTIVE' )
{
Import-Module PSTerminalServices
Get-TSSession -State Disconnected -ComputerName localhost | where { $_.SessionID -ne 0 } | foreach {$_.UserName}
}

# Total de Usuarios Inativos
if ( $select -eq 'INACTIVENUM' )
{
Import-Module PSTerminalServices
Get-TSSession -State Disconnected -ComputerName localhost | where { $_.SessionID -ne 0 } | foreach {$_.UserName} | Measure-Object -Line | select-object Lines | select-object -ExpandProperty Lines
}

# Nome do Dispositivo Remoto
if ( $select -eq 'DEVICE' )
{
Import-Module PSTerminalServices
Get-TSSession -State Active -ComputerName localhost | foreach {$_.ClientName}
}

# IP do Dispositivo Remoto
if ( $select -eq 'IP' )
{
Import-Module PSTerminalServices
Get-TSSession -State Active -ComputerName localhost | foreach {(($_.IPAddress).IPAddressToString)}
}
