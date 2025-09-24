Param([string]$Path)
$driveletter = Split-Path -Qualifier $Path
$free = Get-PSDrive $driveletter.Substring(0, $driveletter.Length - 1) | ForEach-Object {$_.Free}

If($free -ge 6500000000) {
  exit 0
} Else {
  exit 1
}
