# PostgreSQL Database Export Script
$ErrorActionPreference = "Stop"

# Database Configuration
$DB_HOST = "localhost"
$DB_PORT = "5432"
$DB_NAME = "ry_vue"
$DB_USER = "postgres"
$DB_PASSWORD = "mm5621528"

# Output Configuration
$TIMESTAMP = Get-Date -Format "yyyyMMdd_HHmmss"
$OUTPUT_DIR = "sql"
$OUTPUT_FILE = "$OUTPUT_DIR/ry_vue_full_backup_$TIMESTAMP.sql"

Write-Host "========================================"
Write-Host "PostgreSQL Database Export Tool"
Write-Host "========================================"
Write-Host ""
Write-Host "Database: $DB_NAME"
Write-Host "Output: $OUTPUT_FILE"
Write-Host ""

# Check if pg_dump exists
$pgDumpPath = Get-Command pg_dump -ErrorAction SilentlyContinue
if (-not $pgDumpPath) {
    Write-Host "ERROR: pg_dump not found in PATH"
    Write-Host "Please install PostgreSQL and add to PATH"
    exit 1
}

Write-Host "Found pg_dump: $($pgDumpPath.Source)"
Write-Host ""

# Ensure output directory exists
if (-not (Test-Path $OUTPUT_DIR)) {
    New-Item -ItemType Directory -Path $OUTPUT_DIR | Out-Null
}

# Set password environment variable
$env:PGPASSWORD = $DB_PASSWORD

Write-Host "Starting export..."
Write-Host ""

try {
    # Execute pg_dump
    $arguments = @(
        "-h", $DB_HOST,
        "-p", $DB_PORT,
        "-U", $DB_USER,
        "-d", $DB_NAME,
        "-F", "p",
        "-b",
        "-v",
        "-f", $OUTPUT_FILE,
        "--inserts",
        "--column-inserts"
    )
    
    $process = Start-Process -FilePath "pg_dump" -ArgumentList $arguments -NoNewWindow -Wait -PassThru
    
    if ($process.ExitCode -eq 0) {
        Write-Host ""
        Write-Host "========================================"
        Write-Host "Export Successful!"
        Write-Host "========================================"
        Write-Host ""
        
        $fileInfo = Get-Item $OUTPUT_FILE
        Write-Host "File: $($fileInfo.FullName)"
        Write-Host "Size: $([math]::Round($fileInfo.Length / 1MB, 2)) MB"
        Write-Host ""
        
    } else {
        Write-Host "Export failed! Exit code: $($process.ExitCode)"
        exit 1
    }
    
} catch {
    Write-Host "Error during export:"
    Write-Host $_.Exception.Message
    exit 1
} finally {
    Remove-Item Env:\PGPASSWORD -ErrorAction SilentlyContinue
}

Write-Host "Done!"
