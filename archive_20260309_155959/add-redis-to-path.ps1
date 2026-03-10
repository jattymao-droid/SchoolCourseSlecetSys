# Add C:\Redis to user PATH
$redisPath = "C:\Redis"
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$redisPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$redisPath", "User")
    Write-Output "Added C:\Redis to PATH"
} else {
    Write-Output "C:\Redis already in PATH"
}
Write-Output "Restart terminal for PATH to take effect"
