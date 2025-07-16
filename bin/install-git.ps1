if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Git with winget..." -ForegroundColor Cyan
    winget install --id Git.Git -e --source winget
} else {
    Write-Host "Git already installed: $(git --version)" -ForegroundColor Green
}
