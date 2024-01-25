##Skript, mis annab tagasisidet, kui Notepad töötab

while(Get-Process Notepad -ErrorAction SilentlyContinue)
{
Write-Host "Notepad is running"
}