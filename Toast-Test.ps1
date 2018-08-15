 param (
    [Parameter(Mandatory=$True)]
    [string]$Title = '',
    [Parameter(Mandatory=$True)]
    [string]$Message = ''
)
Invoke-Command -ScriptBlock {
& (Join-Path $env:windir "CCM\SCToastNotification.exe") "$Title" "$Message"
Add-Type -AssemblyName System.Speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.Speak("$Message")
$speak.Dispose()
}