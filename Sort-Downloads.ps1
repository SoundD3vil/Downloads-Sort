#Dieses Skript definiert zuerst die Ordnerpfade für jede Kategorie und erstellt sie, wenn sie nicht vorhanden sind. 
#Dann wird der Download-Ordner nach Dateien durchsucht und jede Datei basierend auf ihrer Dateierweiterung in den entsprechenden Ordner verschoben. 
#Wenn die Dateierweiterung nicht in eine der Kategorien passt, wird die Datei in den Ordner "Sonstiges" verschoben. 
#Die Ausgabe "Sortierung abgeschlossen!" wird angezeigt, wenn das Skript abgeschlossen ist.

#Created with ChatGPT by SoundDevil

# Definiere die Ordnerpfade für jede Kategorie
$bild_ordner = "$env:userprofile\Downloads\Bilder"
$musik_ordner = "$env:userprofile\Downloads\Musik"
$video_ordner = "$env:userprofile\Downloads\Videos"
$pdf_ordner = "$env:userprofile\Downloads\PDF"
$sonstiges_ordner = "$env:userprofile\Downloads\Sonstiges"

# Erstelle die Ordner, wenn sie nicht bereits vorhanden sind
if (!(Test-Path $bild_ordner)) {New-Item -ItemType Directory -Force -Path $bild_ordner}
if (!(Test-Path $musik_ordner)) {New-Item -ItemType Directory -Force -Path $musik_ordner}
if (!(Test-Path $video_ordner)) {New-Item -ItemType Directory -Force -Path $video_ordner}
if (!(Test-Path $pdf_ordner)) {New-Item -ItemType Directory -Force -Path $pdf_ordner}
if (!(Test-Path $sonstiges_ordner)) {New-Item -ItemType Directory -Force -Path $sonstiges_ordner}

# Durchsuche den Download-Ordner und sortiere die Dateien entsprechend
Get-ChildItem "$env:userprofile\Downloads\*" -File | ForEach-Object {
    $extension = $_.Extension.ToLower()

    if ($extension -in ".jpg", ".jpeg", ".png", ".gif", ".bmp") {
        Move-Item $_.FullName $bild_ordner
    }
    elseif ($extension -in ".mp3", ".wav", ".aac", ".flac", ".ogg") {
        Move-Item $_.FullName $musik_ordner
    }
    elseif ($extension -in ".mp4", ".avi", ".mov", ".mkv", ".wmv") {
        Move-Item $_.FullName $video_ordner
    }
    elseif ($extension -eq ".pdf") {
        Move-Item $_.FullName $pdf_ordner
    }
    else {
        Move-Item $_.FullName $sonstiges_ordner
    }
}

Write-Host "Sortierung abgeschlossen!"
