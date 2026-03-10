# PostgreSQL Database Restore Script
$ErrorActionPreference = "Stop"

# Database Configuration
$DB_HOST = "localhost"
$DB_PORT = "5432"
$DB_USER = "postgres"
$DB_PASSWORD = "mm5621528"

Write-Host "========================================"
Write-Host "PostgreSQL Database Restore Tool"
Write-Host "========================================"
Write-Host ""

# List available backup files
$backupFiles = Get-ChildItem -Path "sql" -Filter "*.sql" | Sort-Object LastWriteTime -Descending

if ($backupFiles.Count -eq 0) {
    Write-Host "No backup files found in sql folder"
    exit 1
}

Write-Host "Available backup files:"
Write-Host ""
for ($i = 0; $i -lt $backupFiles.Count; $i++) {
    $file = $backupFiles[$i]
    Write-Host "[$($i+1)] $($file.Name)"
    Write-Host "    Size: $([math]::Round($file.Length / 1MB, 2)) MB"
    Write-Host "    Date: $($file.LastWriteTime)"
    Write-Host ""
}

# Ask user to select a file
$selection = Read-Host "Select backup file number (1-$($backupFiles.Count))"
$selectedIndex = [int]$selection - 1

if ($selectedIndex -lt 0 -or $selectedIndex -ge $backupFiles.Count) {
    Write-Host "Invalid selection"
    exit 1
}

$backupFile = $backupFiles[$selectedIndex]
Write-Host ""
Write-Host "Selected: $($backupFile.Name)"
Write-Host ""

# Ask for target database name
$targetDb = Read-Host "Enter target database name (press Enter for 'ry_vue')"
if ([string]::IsNullOrWhiteSpace($targetDb)) {
    $targetDb = "ry_vue"
}

Write-Host ""
Write-Host "WARNING: This will overwrite all data in database '$targetDb'"
$confirm = Read-Host "Are you sure? (yes/no)"

if ($confirm -ne "yes") {
    Write-Host "Restore cancelled"
    exit 0
}

# Check if psql exists
$psqlPath = Get-Command psql -ErrorAction SilentlyContinue
if (-not $psqlPath) {
    Write-Host "ERROR: psql not found in PATH"
    Write-Host "Please install PostgreSQL and add to PATH"
    exit 1
}

Write-Host ""
Write-Host "Found psql: $($psqlPath.Source)"
Write-Host ""

# Set password environment variable
$env:PGPASSWORD = $DB_PASSWORD

Write-Host "Starting restore..."
Write-Host ""

try {
    # Execute psql restore
    $arguments = @(
        "-h", $DB_HOST,
        "-p", $DB_PORT,
        "-U", $DB_USER,
        "-d", $targetDb,
        "-f", "sql/$($backupFile.Name)"
    )
    
    $process = Start-Process -FilePath "psql" -ArgumentList $arguments -NoNewWindow -Wait -PassThru
    
    if ($process.ExitCode -eq 0) {
        Write-Host ""
        Write-Host "========================================"
        Write-Host "Restore Successful!"
        Write-Host "========================================"
        Write-Host ""
        Write-Host "Database '$targetDb' has been restored from:"
        Write-Host "  $($backupFile.Name)"
        Write-Host ""
        
    } else {
        Write-Host "Restore failed! Exit code: $($process.ExitCode)"
        exit 1
    }
    
} catch {
    Write-Host "Error during restore:"
    Write-Host $_.Exception.Message
    exit 1
} finally {
    Remove-Item Env:\PGPASSWORD -ErrorAction SilentlyContinue
}

Write-Host "Done!"
