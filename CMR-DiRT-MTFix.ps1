$pingCount = 4
$ntcorepatch = "https://ntcore.com/files/4gb_patch.zip"
$DirtMTFix = "https://github.com/xatornet/CMCR-DiRT-MTFix/archive/refs/heads/Windows.zip"

# Function to simulate a delay
function Delay {
    param($seconds)
    Start-Sleep -Seconds $seconds
}
Clear-Host
# Check if grid.bak exists
    Write-Host "Checking if Exe file has been patched..."
	Write-Host ""
	Delay 3
if (Test-Path -Path "DiRT.bak") {
    Write-Host "Exe file has been already patched. No further work needed."
	Write-Host "Loading script..."
    Delay 4
}


else {
	Clear-Host
    Write-Host "Exe file has NOT been patched. Making a backup and patching."
	Delay 3
	Write-Host ""
	Write-Host "Patching 4GB Ram Access..."
	Delay 3
	Write-Host ""
	Write-Host "Downloading Required Files"
	New-Item -ItemType Directory -Path ".\PatchingD" | Out-Null
	Invoke-WebRequest -Uri $ntcorepatch -OutFile ".\PatchingD\NTCore4GB.zip"
	Expand-Archive ".\PatchingD\NTCore4GB.zip" ".\PatchingD\" | Out-Null
	Delay 3
	Start-Process -Wait ".\PatchingD\4gb_patch.exe" "DiRT.exe" | Out-Null
	Rename-Item -Path "DiRT.exe .Backup" "DiRT.bak"
	Write-Host ""
	Write-Host "Exe Patched"
	Remove-Item -Path ".\PatchingD" -Force -Recurse -ErrorAction SilentlyContinue
	Delay 3
	Clear-Host
	Write-Host ""
	Write-Host "Loading script..."
    Delay 4
}

			Clear-Host
			Write-Host "Downloading Required Files"
			New-Item -ItemType Directory -Path ".\PatchingD" | Out-Null
			Invoke-WebRequest -Uri $DirtMTFix -OutFile ".\PatchingD\Windows.zip"
			Expand-Archive ".\PatchingD\Windows.zip" ".\PatchingD\" | Out-Null
			Write-Host ""
			Write-Host "Applying NEW MULTITHREAD FIX AND UPDATING INGAME OPTIONS"
			Write-Host ""
			Write-Host "WARNING - YOUR INGAME SETTINGS WILL RESET"
			Write-Host ""
            Delay 3
            Copy-Item -Path ".\PatchingD\CMCR-DiRT-MTFix-main\Files\*" -Destination ".\" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "$env:userprofile\Documents\Codemasters\DiRT\hardwaresettings\*.xml" -Force -ErrorAction SilentlyContinue
			
			# Obtener el número de cores lógicos del CPU
			$cores = (Get-WmiObject -Class Win32_ComputerSystem).NumberOfLogicalProcessors

			# Testeo del Script
			#$cores = 64

			# Definir los valores válidos de cores
			$valid_cores = 8, 12

			# Definir el valor de grid_cores basado en el número de cores
			if ($cores -gt 12) {
			$dirt_cores = 12
			Write-Host "Your CPU has $cores cores, but the game is limited to 12 cores, so that will be the max core count used."
			Delay 4
			}
			elseif ($cores -lt 8) {
			$dirt_cores = 8
			Write-Host "Colin MRae DiRT already supports your CPU core count."
			Delay 4
			}
			else {
			# Verificar si el número de cores está en la lista de valid_cores
			if ($valid_cores -contains $cores) {
				$dirt_cores = $cores
			}
			else {
			# Obtener el valor de valid_cores inmediatamente inferior a $cores
			$dirt_cores = $valid_cores | Where-Object { $_ -lt $cores } | Select-Object -Last 1
			}
			}

			# Ruta del archivo de plantilla y archivo de salida
			$template_file = "Template.xml"
			$output_file = "system\hardware_settings_restrictions.xml"

			# Leer el contenido de la plantilla
			$template_content = Get-Content $template_file -Raw

			# Reemplazar el valor "_Y_" por el valor de grid_cores en la plantilla
			$updated_content = $template_content -replace "_Y_", $dirt_cores

			# Guardar el contenido actualizado en el archivo de salida
			$updated_content | Set-Content $output_file
			
			Remove-Item -Path "Template.xml" -Force -ErrorAction SilentlyContinue
			Remove-Item -Path ".\PatchingD" -Force -Recurse -ErrorAction SilentlyContinue
			Remove-Item -Path "Windows.zip" -Force -ErrorAction SilentlyContinue
			
			Write-Host "The Game has been patched. Colin MCRae DiRT will use $dirt_cores cores."
			Delay 3
			Write-Host ""
			Write-Host "HAPPY GAMING!! GOODBYE :-)"
			Delay 3
