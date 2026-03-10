# Start Redis service - requires Administrator
Start-Service -Name "Redis" -ErrorAction Stop
$svc = Get-Service -Name "Redis"
if ($svc.Status -eq "Running") {
    Write-Host "Redis started successfully!" -ForegroundColor Green
} else {
    Write-Host "Redis failed to start. Status: $($svc.Status)" -ForegroundColor Red
}
