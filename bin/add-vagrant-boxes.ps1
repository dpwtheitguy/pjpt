# Add multiple Vagrant Windows boxes for AD lab
# Author: PJPT Lab Bootstrapping
# Purpose: Ensure all required Windows boxes are added cleanly for VMware

$boxes = @(
    @{ name = "gusztavvargadr/windows-server";                label = "Win Server (Generic)" },
    @{ name = "gusztavvargadr/windows-server-2022-standard";  label = "Win Server 2022" },
    @{ name = "gusztavvargadr/windows-10";                    label = "Win10 (Generic)" },
    @{ name = "gusztavvargadr/windows-10-22h2-enterprise";    label = "Win10 22H2 Enterprise" }
)

$provider = "vmware_desktop"

foreach ($box in $boxes) {
    $exists = vagrant box list | Select-String -Pattern $box.name

    if (-not $exists) {
        Write-Host "`n[+] Adding $($box.label): $($box.name)" -ForegroundColor Cyan
        vagrant box add $box.name --provider $provider --force
    } else {
        Write-Host "`n[-] Already installed: $($box.label)" -ForegroundColor Yellow
    }
}
