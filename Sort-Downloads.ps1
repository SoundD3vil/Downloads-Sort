#This script first defines the folder paths for each category and creates them if they do not exist. 
#Then it scans the download folder for files and moves each file to the appropriate folder based on its file extension. 
#If the file extension doesn't fit into one of the categories, the file is moved to the "Other" folder. 
#The "Sorting complete!" output is displayed when the script is complete.

#Created with ChatGPT by SoundDevil

# Define the folder paths for each category is closed.
$bild_ordner = "$env:userprofile\Downloads\Bilder"
$musik_ordner = "$env:userprofile\Downloads\Musik"
$video_ordner = "$env:userprofile\Downloads\Videos"
$pdf_ordner = "$env:userprofile\Downloads\PDF"
$sonstiges_ordner = "$env:userprofile\Downloads\Sonstiges"

# Create the folders if they do not already exist
if (!(Test-Path $bild_ordner)) {New-Item -ItemType Directory -Force -Path $bild_ordner}
if (!(Test-Path $musik_ordner)) {New-Item -ItemType Directory -Force -Path $musik_ordner}
if (!(Test-Path $video_ordner)) {New-Item -ItemType Directory -Force -Path $video_ordner}
if (!(Test-Path $pdf_ordner)) {New-Item -ItemType Directory -Force -Path $pdf_ordner}
if (!(Test-Path $sonstiges_ordner)) {New-Item -ItemType Directory -Force -Path $sonstiges_ordner}

# Browse the download folder and sort the files accordingly
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

Write-Host "Sorting completed!"
