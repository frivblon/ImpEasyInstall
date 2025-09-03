# --- FUNCIONES DE ESTILO Y ANIMACIÓN ---

# Animación para mostrar el proceso de conexión exitoso
function Show-ConnectingAnimation {
    $frames = @(
    @"
 
       (^-^)                          (^_^)
    .-----------.                  .------------.
    |           |                  |            |
    |  Enviando |__________________| Recibiendo |
    '-----------'                  '------------'
      _|     |_                     [  o o o   ]

"@,
    @"
 
       (^-^)                          (^_^)
    .-----------.                  .------------.
    |           |  . .             |            |
    |  Enviando |__________________| Recibiendo |
    '-----------'                  '------------'
      _|     |_                     [  o o o   ]

"@,
    @"
 
       (^-^)                          (^_^)
    .-----------.                  .------------.
    |           |      . .         |            |
    |  Enviando |__________________| Recibiendo |
    '-----------'                  '------------'
      _|     |_                     [  o o o   ]

"@,
    @"
                       ________________
                      |                |
       (^-^)          |   ¡CONECTADO!  |          (^o^)
    .-----------.     |________________|       .------------.
    |           |       '------------'         |            |
    |  Enviando |______________________________| Recibiendo |
    '-----------'                              '------------'
      _|     |_                                 [  o o o   ]

"@
    )
    foreach ($frame in $frames) {
        Clear-Host; Write-Host $frame -ForegroundColor Green; Start-Sleep -Milliseconds 400
    }
    Start-Sleep -Seconds 1
}

# Animación para mostrar un error en la conexión
function Show-FailureAnimation {
    $frames = @(
    @"
 
       (o_O;)                         (o_o?)
    .-----------.                  .------------.
    |           |                  |            |
    | Intentando|__________________| Esperando  |
    '-----------'                  '------------'
      _|     |_                     [  o o o   ]

"@,
    @"
 
       (o_O;)                         (o_o?)
    .-----------.                  .------------.
    |           |  X X             |            |
    | Intentando|__________________| Esperando  |
    '-----------'                  '------------'
      _|     |_                     [  o o o   ]

"@,
    @"
                       ________________
                      |                |
       (T_T)          |      ERROR     |          (;-;)
    .-----------.     |________________|       .------------.
    |           |       '------------'         |            |
    | Intentando|____ X X X X _________________| Esperando  |
    '-----------'                              '------------'
      _|     |_                                 [  o o o   ]

"@
    )
    foreach ($frame in $frames) {
        Clear-Host; Write-Host $frame -ForegroundColor Red; Start-Sleep -Milliseconds 600
    }
    Start-Sleep -Seconds 1
}

# Imagen de despedida estática
function Show-GoodbyeAnimation {
    $goodbyeFrame = @"

                 ¡Hasta luego!
                    (^_^)/
                 .-----------. 
                 |           |
                 |           |
                 '-----------'
                   _|     |_  

"@
    Clear-Host
    Write-Host $goodbyeFrame -ForegroundColor Cyan
    Start-Sleep -Seconds 2 # Pausa para ver la imagen
}


# --- SCRIPT PRINCIPAL DE GESTIÓN DE IMPRESORAS ---
do {
    Clear-Host
    # --- DIBUJO ESTÁTICO PARA EL MENÚ ---
    Write-Host @"
 ╔═════════════════════════════════════════════════╗
 ║ .---------------------------------------------. ║
 ║ |            🖨️ImpEasyInstall v1.0🖨️          | ║
 ║ |            _______________________          | ║
 ║ |           || ------------------- ||         | ║
 ║ |           || |                 | ||         | ║
 ║ |           || |   BIENVENIDO!   | ||         | ║
 ║ |           || |                 | ||         | ║
 ║ |           || ------------------- ||         | ║
 ║ |          .'-----------------------'.        | ║
 ║ |         /  (o) (o) (o) (o) (o) (o)  \       | ║
 ║ |        /___________________________  \      | ║
 ║ |       /_____________________________  \     | ║       
 ║ |            😎 ISC Iván Blanco 😎            | ║
 ║ '---------------------------------------------' ║
 ╚═════════════════════════════════════════════════╝
"@ -ForegroundColor DarkCyan

    # --- MENÚ PRINCIPAL (CON ÍCONOS) ---
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host "    MENÚ PRINCIPAL" -ForegroundColor White
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. 🗑️   Desinstalar impresora"
    Write-Host "2. ✨  Instalar impresora por IP"
    Write-Host "3. 🔄  Reinstalar impresora"
    Write-Host "4. 📶  Verificar conexión"
    Write-Host "5. 📄  Imprimir página de prueba"
    Write-Host "6. 🔍  Ver información detallada"
    Write-Host "7. 🛠️   Mantenimiento de Impresora"
    Write-Host "8. 🌐  Buscar controladores en línea"
    Write-Host "9. 🎛️   Configuración Rápida"
    Write-Host "10. 📋  Gestión Avanzada de Cola de Impresión"
    Write-Host "11. 👋  Salir del script"
    Write-Host ""
    
    $opcion = Read-Host "Por favor, selecciona una opción"

    switch ($opcion) {
        '1' { # --- DESINSTALAR ---
            Clear-Host; Write-Host "--- (1) 🗑️  Desinstalar Impresora ---" -ForegroundColor Yellow; Write-Host ""
            $impresoras = Get-Printer | Select-Object Name
            if (-not $impresoras) { Write-Host "No se encontraron impresoras instaladas." -ForegroundColor Red }
            else {
                Write-Host "Impresoras locales encontradas:" -ForegroundColor Green
                $i = 1; $mapaImpresoras = @{}
                foreach ($impresora in $impresoras) { Write-Host "$i. $($impresora.Name)"; $mapaImpresoras[$i] = $impresora.Name; $i++ }
                try {
                    $seleccion = Read-Host "`nIntroduce el NÚMERO de la impresora (o 'M' para volver)"
                    if ($seleccion.ToUpper() -eq 'M') { continue }
                    $nombreImpresora = $mapaImpresoras[[int]$seleccion]
                    if ($nombreImpresora) {
                        $confirmacion = Read-Host "¿Seguro que quieres desinstalar '$nombreImpresora'? (S/N) (o 'M' para volver)"
                        if ($confirmacion.ToUpper() -eq 'M') { continue }
                        if ($confirmacion -eq 'S' -or $confirmacion -eq 's') { Remove-Printer -Name $nombreImpresora; Write-Host "La impresora '$nombreImpresora' ha sido desinstalada." -ForegroundColor Green }
                        else { Write-Host "Desinstalación cancelada." -ForegroundColor Yellow }
                    } else { Write-Host "Selección no válida." -ForegroundColor Red }
                } catch { Write-Host "Error: Introduce un número válido." -ForegroundColor Red }
            }
            Read-Host "`nPresiona Enter para volver al menú principal."
        }
        
        '2' { # --- INSTALAR ---
            Clear-Host; Write-Host "--- (2) ✨ Instalar Impresora por IP ---" -ForegroundColor Yellow; Write-Host "En cualquier paso, escribe 'M' para volver al menú principal." -ForegroundColor Cyan
            $ipAddress = Read-Host "1. Introduce la dirección IP de la impresora"
            if ($ipAddress.ToUpper() -eq 'M') { continue }
            if ([string]::IsNullOrWhiteSpace($ipAddress)) { Write-Host "La IP es obligatoria." -ForegroundColor Red; Read-Host; continue }

            Write-Host "`nVerificando conexión con '$ipAddress'..." -ForegroundColor Cyan
            if (Test-Connection -ComputerName $ipAddress -Count 2 -Quiet -ErrorAction SilentlyContinue) {
                Write-Host "✅ Dispositivo encontrado. Continuando con la instalación." -ForegroundColor Green
                
                $portName = "IP_" + $ipAddress
                $printerName = Read-Host "2. Dale un nombre a la impresora (ej: Impresora_Ventas)"
                if ($printerName.ToUpper() -eq 'M') { continue }
                $fabricante = Read-Host "3. Escribe el FABRICANTE para filtrar drivers (ej: HP)"
                if ($fabricante.ToUpper() -eq 'M') { continue }
                
                $driversDisponibles = Get-PrinterDriver | Where-Object Name -like "*$fabricante*"
                if (-not $driversDisponibles) { Write-Host "`nNo se encontraron drivers para '$fabricante'." -ForegroundColor Red }
                else {
                    Write-Host "`nDrivers encontrados. Selecciona uno:" -ForegroundColor Green
                    $i = 1; $mapaDrivers = @{}
                    foreach ($driver in $driversDisponibles) { Write-Host "$i. $($driver.Name)"; $mapaDrivers[$i] = $driver.Name; $i++ }
                    $seleccionDriver = Read-Host "`nIntroduce el NÚMERO del driver a utilizar"
                    if ($seleccionDriver.ToUpper() -eq 'M') { continue }
                    $driverName = $mapaDrivers[[int]$seleccionDriver]

                    if ($driverName) {
                        try {
                            Show-ConnectingAnimation
                            if (-not (Get-PrinterPort -Name $portName -ErrorAction SilentlyContinue)) {
                                Add-PrinterPort -Name $portName -PrinterHostAddress $ipAddress
                            }
                            Add-Printer -Name $printerName -DriverName $driverName -PortName $portName -ErrorAction Stop
                            Clear-Host
                            Write-Host "¡Impresora '$printerName' instalada correctamente!" -ForegroundColor Green
                        } catch {
                            Show-FailureAnimation
                            Write-Host "`nError durante la instalación." -ForegroundColor Red
                            Write-Host "DETALLE: $($_.Exception.Message)" -ForegroundColor Red
                        }
                    } else { Write-Host "Número de driver no válido." -ForegroundColor Red }
                }
            } else {
                Write-Host "❌ No se pudo establecer conexión con la IP '$ipAddress'." -ForegroundColor Red
                Write-Host "   Por favor, verifica la dirección y que la impresora esté encendida y en la red."
            }
            Read-Host "`nPresiona Enter para volver al menú principal."
        }

        '3' { # --- REINSTALAR ---
            Clear-Host; Write-Host "--- (3) 🔄 Reinstalar una Impresora ---" -ForegroundColor Yellow; Write-Host ""
            $impresoras = Get-Printer | Select-Object Name
            if (-not $impresoras) { Write-Host "No se encontraron impresoras para reinstalar." -ForegroundColor Red }
            else {
                Write-Host "Selecciona la impresora que quieres reinstalar:" -ForegroundColor Green
                $i = 1; $mapaImpresoras = @{}
                foreach ($impresora in $impresoras) { Write-Host "$i. $($impresora.Name)"; $mapaImpresoras[$i] = $impresora.Name; $i++ }
                
                try {
                    $seleccion = Read-Host "`nIntroduce el NÚMERO de la impresora (o 'M' para volver)"
                    if ($seleccion.ToUpper() -eq 'M') { continue }
                    
                    $nombreImpresora = $mapaImpresoras[[int]$seleccion]
                    if ($nombreImpresora) {
                        Write-Host "Se reinstalará la impresora '$nombreImpresora'." -ForegroundColor Cyan
                        $impresoraObjeto = Get-Printer -Name $nombreImpresora
                        $driverActual = $impresoraObjeto.DriverName
                        $puertoActual = $impresoraObjeto.PortName
                        Write-Host "Guardando configuración... Driver:'$driverActual', Puerto:'$puertoActual'"
                        Start-Sleep -Seconds 1
                        Write-Host "Desinstalando impresora..."
                        Remove-Printer -Name $nombreImpresora
                        Start-Sleep -Seconds 2
                        Write-Host "Reinstalando impresora..."
                        Add-Printer -Name $nombreImpresora -DriverName $driverActual -PortName $puertoActual -ErrorAction Stop
                        Write-Host "¡Impresora '$nombreImpresora' reinstalada con éxito!" -ForegroundColor Green
                        $imprimirPrueba = Read-Host "¿Deseas imprimir una página de prueba? (S/N)"
                        if ($imprimirPrueba.ToUpper() -eq 'S') {
                            Write-Host "Enviando página de prueba..."
                            $printerWMI = Get-WmiObject -Class Win32_Printer -Filter "Name='$nombreImpresora'"
                            $printerWMI.PrintTestPage()
                        }
                    } else { Write-Host "Selección no válida." -ForegroundColor Red }
                } catch {
                    Show-FailureAnimation
                    Write-Host "`nOcurrió un error durante la reinstalación." -ForegroundColor Red
                    Write-Host "DETALLE: $($_.Exception.Message)" -ForegroundColor Red
                }
            }
            Read-Host "`nPresiona Enter para volver al menú principal."
        }

        '4' { # --- VERIFICAR CONEXIÓN ---
            while ($true) {
                Clear-Host
                Write-Host "--- (4) 📶 Verificar Conexión de Impresora ---" -ForegroundColor Yellow; Write-Host ""
                $impresoras = Get-Printer
                if (-not $impresoras) { Write-Host "No se encontraron impresoras instaladas." -ForegroundColor Red; Start-Sleep -Seconds 2; break }
                
                Write-Host "Selecciona la impresora que quieres verificar:" -ForegroundColor Green
                $i = 1; $mapaImpresoras = @{}
                foreach ($impresora in $impresoras) { Write-Host "$i. $($impresora.Name) (Puerto: $($impresora.PortName))"; $mapaImpresoras[$i] = $impresora; $i++ }
                
                try {
                    $seleccion = Read-Host "`nIntroduce el NÚMERO de la impresora (o 'M' para volver al menú)"
                    if ($seleccion.ToUpper() -eq 'M') { break }
                    
                    $impresoraSeleccionada = $mapaImpresoras[[int]$seleccion]
                    if ($impresoraSeleccionada) {
                        $puerto = $impresoraSeleccionada.PortName
                        $nombre = $impresoraSeleccionada.Name
                        $ipRegex = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'
                        if ($puerto -match $ipRegex) { $destino = $matches[0] }
                        elseif ($puerto.StartsWith("IP_")) { $destino = $puerto.Substring(3) }
                        else { $destino = $null }

                        if ($destino) {
                            Write-Host "`nHaciendo ping a '$nombre' en la dirección '$destino'..." -ForegroundColor Cyan
                            if (Test-Connection -ComputerName $destino -Count 2 -Quiet) { Write-Host "✅ La impresora '$nombre' está EN LÍNEA." -ForegroundColor Green }
                            else { Write-Host "❌ La impresora '$nombre' está DESCONECTADA o no responde." -ForegroundColor Red }
                        } else {
                            Write-Host "ℹ️ La impresora '$nombre' no usa un puerto IP estándar (Puerto: '$puerto')." -ForegroundColor Yellow
                            Write-Host "   No se puede verificar la conexión de red para puertos USB, LPT o WSD."
                        }
                    } else { Write-Host "Selección no válida." -ForegroundColor Red }
                } catch { Write-Host "Error: Introduce un número válido." -ForegroundColor Red }
                
                Read-Host "`nPresiona Enter para probar otra impresora..."
            }
        }
        
        '5' { # --- IMPRIMIR PÁGINA DE PRUEBA ---
            while ($true) {
                Clear-Host
                Write-Host "--- (5) 📄 Imprimir Página de Prueba ---" -ForegroundColor Yellow; Write-Host ""
                $impresoras = Get-Printer | Select-Object Name
                if (-not $impresoras) { Write-Host "No se encontraron impresoras instaladas." -ForegroundColor Red; Start-Sleep -Seconds 2; break }
                
                Write-Host "Selecciona la impresora para la página de prueba:" -ForegroundColor Green
                $i = 1; $mapaImpresoras = @{}
                foreach ($impresora in $impresoras) { Write-Host "$i. $($impresora.Name)"; $mapaImpresoras[$i] = $impresora.Name; $i++ }
                
                try {
                    $seleccion = Read-Host "`nIntroduce el NÚMERO de la impresora (o 'M' para volver al menú)"
                    if ($seleccion.ToUpper() -eq 'M') { break }
                    
                    $nombreImpresora = $mapaImpresoras[[int]$seleccion]
                    if ($nombreImpresora) {
                        Write-Host "Enviando página de prueba a '$nombreImpresora'..." -ForegroundColor Cyan
                        $printerWMI = Get-WmiObject -Class Win32_Printer -Filter "Name='$nombreImpresora'"
                        $resultado = $printerWMI.PrintTestPage()
                        if ($resultado.ReturnValue -eq 0) { Write-Host "✅ ¡Página de prueba enviada correctamente!" -ForegroundColor Green }
                        else { Write-Host "❌ Hubo un error al enviar la página de prueba. Código: $($resultado.ReturnValue)" -ForegroundColor Red }
                    } else { Write-Host "Selección no válida." -ForegroundColor Red }
                } catch { Write-Host "Error: Introduce un número válido." -ForegroundColor Red }

                Read-Host "`nPresiona Enter para imprimir otra página de prueba..."
            }
        }

        '6' { # --- VER INFORMACIÓN DETALLADA ---
             while ($true) {
                Clear-Host
                Write-Host "--- (6) 🔍 Ver Información Detallada ---" -ForegroundColor Yellow; Write-Host ""
                $impresoras = Get-Printer
                if (-not $impresoras) { Write-Host "No se encontraron impresoras instaladas." -ForegroundColor Red; Start-Sleep -Seconds 2; break }
                
                Write-Host "Selecciona la impresora que quieres consultar:" -ForegroundColor Green
                $i = 1; $mapaImpresoras = @{}
                foreach ($impresora in $impresoras) { Write-Host "$i. $($impresora.Name)"; $mapaImpresoras[$i] = $impresora; $i++ }
                
                try {
                    $seleccion = Read-Host "`nIntroduce el NÚMERO de la impresora (o 'M' para volver al menú)"
                    if ($seleccion.ToUpper() -eq 'M') { break }
                    
                    $impresoraSeleccionada = $mapaImpresoras[[int]$seleccion]
                    if ($impresoraSeleccionada) {
                        Write-Host ""; Write-Host "-------------------------------------------" -ForegroundColor Cyan
                        Write-Host "  Información para: $($impresoraSeleccionada.Name)" -ForegroundColor White
                        Write-Host "-------------------------------------------" -ForegroundColor Cyan
                        Write-Host " Estado         : $($impresoraSeleccionada.PrinterStatus)"
                        Write-Host " Driver         : $($impresoraSeleccionada.DriverName)"
                        Write-Host " Puerto         : $($impresoraSeleccionada.PortName)"
                        Write-Host " Compartida     : $($impresoraSeleccionada.Shared)"
                        Write-Host " Ubicación      : $($impresoraSeleccionada.Location)"
                        Write-Host " Procesador     : $($impresoraSeleccionada.PrintProcessor)"
                        Write-Host " Trabajos en cola: $($impresoraSeleccionada.JobCount)"
                        Write-Host "-------------------------------------------" -ForegroundColor Cyan
                    } else { Write-Host "Selección no válida." -ForegroundColor Red }
                } catch { Write-Host "Error: Introduce un número válido." -ForegroundColor Red }

                Read-Host "`nPresiona Enter para consultar otra impresora..."
            }
        }

        '7' { # --- MANTENIMIENTO DE IMPRESORA ---
            while ($true) {
                Clear-Host
                Write-Host "--- (7) 🛠️  Mantenimiento de Impresora ---" -ForegroundColor Yellow
                Write-Host ""
                Write-Host "Opciones de mantenimiento:" -ForegroundColor Green
                Write-Host " 1. Limpiar cola de impresión (Spooler)"
                Write-Host " 2. Abrir utilidades de la impresora (Limpieza de cabezal, etc.)"
                Write-Host ""
                Write-Host " M. Volver al Menú Principal"
                Write-Host ""

                $opcionMantenimiento = Read-Host "Selecciona una opción de mantenimiento"
                if ($opcionMantenimiento.ToUpper() -eq 'M') { break }
                
                switch ($opcionMantenimiento) {
                    '1' {
                        $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
                        $principal = [Security.Principal.WindowsPrincipal]$currentUser
                        if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
                            Write-Host "`nERROR: Esta acción requiere privilegios de Administrador." -ForegroundColor Red
                            Write-Host "Por favor, reinicia el script haciendo clic derecho > 'Ejecutar como administrador'."
                        } else {
                            $confirmacion = Read-Host "`nEsta acción detendrá el servicio y borrará TODOS los trabajos atascados. ¿Estás seguro? (S/N)"
                            if ($confirmacion.ToUpper() -eq 'S') {
                                try {
                                    Write-Host "Deteniendo el servicio de cola de impresión (Spooler)..." -ForegroundColor Cyan
                                    Stop-Service -Name Spooler -Force -ErrorAction Stop
                                    Write-Host "Limpiando archivos de la cola de impresión..." -ForegroundColor Cyan
                                    Remove-Item -Path C:\Windows\System32\spool\PRINTERS\* -Force -ErrorAction Stop
                                    Write-Host "Iniciando el servicio de cola de impresión (Spooler)..." -ForegroundColor Cyan
                                    Start-Service -Name Spooler -ErrorAction Stop
                                    Write-Host "✅ Limpieza de la cola de impresión completada." -ForegroundColor Green
                                } catch {
                                    Write-Host "❌ Ocurrió un error al limpiar la cola de impresión." -ForegroundColor Red
                                    Write-Host "   DETALLE: $($_.Exception.Message)"
                                    if ((Get-Service -Name Spooler).Status -ne "Running") { Start-Service -Name Spooler }
                                }
                            } else { Write-Host "Operación cancelada." -ForegroundColor Yellow }
                        }
                    }
                    '2' {
                        Write-Host "`nEsta opción abrirá el panel de 'Impresoras y escáneres' de Windows." -ForegroundColor Cyan
                        Write-Host "Desde ahí, busca tu impresora y en sus propiedades encontrarás la pestaña de 'Mantenimiento' del fabricante."
                        Read-Host "Presiona Enter para abrir el panel..."
                        Start-Process "ms-settings:printers"
                    }
                    default { Write-Host "Opción no válida." -ForegroundColor Red }
                }
                Read-Host "`nPresiona Enter para volver al menú de mantenimiento..."
            }
        }
        
        '8' { # --- BUSCAR CONTROLADORES EN LÍNEA ---
            while ($true) {
                Clear-Host
                Write-Host "--- (8) 🌐 Buscar Controladores en Línea ---" -ForegroundColor Yellow
                Write-Host ""
                Write-Host "Selecciona una marca para abrir su página oficial de soporte:" -ForegroundColor Green
                Write-Host " 1. HP"
                Write-Host " 2. Epson"
                Write-Host " 3. Canon"
                Write-Host " 4. Brother"
                Write-Host " 5. Búsqueda genérica en Google"
                Write-Host ""
                Write-Host " M. Volver al Menú Principal"
                Write-Host ""

                $opcionMarca = Read-Host "Selecciona una opción"
                if ($opcionMarca.ToUpper() -eq 'M') { break }

                $url = ""
                switch ($opcionMarca) {
                    '1' { $url = "https://support.hp.com/drivers" }
                    '2' { $url = "https://epson.com/support" }
                    '3' { $url = "https://www.canon.com/support" }
                    '4' { $url = "https://support.brother.com/" }
                    '5' { $url = "https://www.google.com/search?q=descargar+drivers+de+impresora" }
                    default { Write-Host "Opción no válida." -ForegroundColor Red }
                }

                if (-not [string]::IsNullOrEmpty($url)) {
                    Write-Host "`nAbriendo el sitio en tu navegador..." -ForegroundColor Cyan
                    Start-Process $url
                }
                Read-Host "`nPresiona Enter para continuar..."
            }
        }

        '9' { # --- CONFIGURACIÓN RÁPIDA ---
            while ($true) {
                Clear-Host
                Write-Host "--- (9)🎛️  Configuración Rápida ---" -ForegroundColor Yellow
                Write-Host ""
                Write-Host "Selecciona una tarea:" -ForegroundColor Green
                Write-Host " 1. Establecer impresora predeterminada"
                Write-Host " 2. Renombrar una impresora"
                Write-Host " 3. Compartir una impresora"
                Write-Host " 4. Dejar de compartir una impresora"
                Write-Host ""
                Write-Host " M. Volver al Menú Principal"
                Write-Host ""

                $opcionConfig = Read-Host "Selecciona una opción"
                if ($opcionConfig.ToUpper() -eq 'M') { break }

                $impresoras = Get-Printer
                if (-not $impresoras) { Write-Host "No se encontraron impresoras." -ForegroundColor Red; Read-Host; continue }
                
                Write-Host "`nSelecciona la impresora a la que aplicar la acción:" -ForegroundColor Cyan
                $i = 1; $mapaImpresoras = @{}
                foreach ($imp in $impresoras) { Write-Host "$i. $($imp.Name)"; $mapaImpresoras[$i] = $imp.Name; $i++ }
                
                try {
                    $seleccion = Read-Host "Introduce el NÚMERO de la impresora"
                    $nombreImpresora = $mapaImpresoras[[int]$seleccion]

                    if (-not $nombreImpresora) {
                        Write-Host "Selección no válida." -ForegroundColor Red
                    } else {
                        switch ($opcionConfig) {
                            '1' {
                                try { (Get-WmiObject -Class Win32_Printer -Filter "Name='$nombreImpresora'").SetDefaultPrinter(); Write-Host "✅ '$nombreImpresora' es ahora la impresora predeterminada." -ForegroundColor Green }
                                catch { Write-Host "❌ Error al establecer la impresora predeterminada." -ForegroundColor Red }
                            }
                            '2' {
                                $nuevoNombre = Read-Host "Introduce el nuevo nombre para '$nombreImpresora'"
                                if ($nuevoNombre) { try { Rename-Printer -Name $nombreImpresora -NewName $nuevoNombre; Write-Host "✅ Impresora renombrada a '$nuevoNombre'." -ForegroundColor Green } catch { Write-Host "❌ Error al renombrar la impresora." -ForegroundColor Red } }
                                else { Write-Host "El nombre no puede estar vacío." -ForegroundColor Yellow }
                            }
                            '3' {
                                $nombreCompartido = $nombreImpresora -replace '\s',''
                                try { Set-Printer -Name $nombreImpresora -Shared $true -ShareName $nombreCompartido; Write-Host "✅ Impresora '$nombreImpresora' compartida como '$nombreCompartido'." -ForegroundColor Green }
                                catch { Write-Host "❌ Error al compartir la impresora." -ForegroundColor Red }
                            }
                            '4' {
                                try { Set-Printer -Name $nombreImpresora -Shared $false; Write-Host "✅ La impresora '$nombreImpresora' ya no está compartida." -ForegroundColor Green }
                                catch { Write-Host "❌ Error al dejar de compartir la impresora." -ForegroundColor Red }
                            }
                            default { Write-Host "Opción no válida." -ForegroundColor Red }
                        }
                    }
                } catch { Write-Host "Error: Introduce un número válido." -ForegroundColor Red }

                Read-Host "`nPresiona Enter para volver al menú de configuración..."
            }
        }

        '10' { # --- GESTIÓN AVANZADA DE COLA DE IMPRESIÓN ---
            while ($true) { # Bucle para la selección de impresoras
                Clear-Host
                Write-Host "--- (10)📋 Gestión Avanzada de Cola de Impresión ---" -ForegroundColor Yellow; Write-Host ""
                $impresoras = Get-Printer | Select-Object Name
                if (-not $impresoras) { Write-Host "No se encontraron impresoras." -ForegroundColor Red; Start-Sleep -Seconds 2; break }
                
                Write-Host "Selecciona la impresora cuya cola quieres gestionar:" -ForegroundColor Green
                $i = 1; $mapaImpresoras = @{}
                foreach ($impresora in $impresoras) { Write-Host "$i. $($impresora.Name)"; $mapaImpresoras[$i] = $impresora.Name; $i++ }
                
                $seleccionImpresora = Read-Host "`nIntroduce el NÚMERO de la impresora (o 'M' para volver al menú principal)"
                if ($seleccionImpresora.ToUpper() -eq 'M') { break } # Sale al menú principal
                
                try {
                    $nombreImpresora = $mapaImpresoras[[int]$seleccionImpresora]
                    if ($nombreImpresora) {
                        # Bucle anidado para gestionar la impresora seleccionada
                        while ($true) {
                            Clear-Host
                            Write-Host "--- Gestionando Cola de: $nombreImpresora ---" -ForegroundColor Cyan
                            Write-Host ""
                            Write-Host "1. Listar trabajos en cola"
                            Write-Host "2. Cancelar un trabajo específico"
                            Write-Host ""
                            Write-Host "M. Volver a la selección de impresoras"
                            Write-Host ""
                            $accionCola = Read-Host "Selecciona una acción"

                            if ($accionCola.ToUpper() -eq 'M') { break } # Sale a la selección de impresoras

                            switch ($accionCola) {
                                '1' {
                                    $trabajos = Get-PrintJob -PrinterName $nombreImpresora
                                    if ($trabajos) {
                                        Write-Host "`nTrabajos en cola para '$nombreImpresora':" -ForegroundColor Green
                                        $trabajos | Format-Table -AutoSize
                                    } else {
                                        Write-Host "`nNo hay trabajos en la cola para '$nombreImpresora'." -ForegroundColor Yellow
                                    }
                                }
                                '2' {
                                    $trabajos = Get-PrintJob -PrinterName $nombreImpresora
                                    if ($trabajos) {
                                        Write-Host "`nTrabajos actuales:" -ForegroundColor Cyan
                                        $trabajos | Format-Table -AutoSize
                                        $trabajoID = Read-Host "Introduce el ID del trabajo que quieres cancelar"
                                        try {
                                            Remove-PrintJob -PrinterName $nombreImpresora -ID $trabajoID -ErrorAction Stop
                                            Write-Host "✅ Trabajo con ID $trabajoID cancelado." -ForegroundColor Green
                                        } catch {
                                            Write-Host "❌ No se pudo cancelar el trabajo. Verifica el ID o si ya fue procesado." -ForegroundColor Red
                                        }
                                    } else {
                                        Write-Host "`nNo hay trabajos en la cola para cancelar." -ForegroundColor Yellow
                                    }
                                }
                                default { Write-Host "Opción no válida." -ForegroundColor Red }
                            }
                            Read-Host "`nPresiona Enter para continuar..."
                        }
                    } else { 
                        Write-Host "Selección no válida." -ForegroundColor Red 
                        Read-Host "`nPresiona Enter para continuar..."
                    }
                } catch { 
                    Write-Host "Error: Introduce un número válido." -ForegroundColor Red
                    Read-Host "`nPresiona Enter para continuar..."
                }
            }
        }

        '11' { # --- SALIR ---
            Show-GoodbyeAnimation
        }

        default { # --- OPCIÓN NO VÁLIDA ---
            Write-Host "Opción no válida." -ForegroundColor Red; Start-Sleep -Seconds 2
        }
    }
} while ($opcion -ne '11')

Clear-Host