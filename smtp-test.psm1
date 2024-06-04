# Default values
$defaultSmtpServer = "smtp.gmail.com"
$defaultMessageSubject = "Test mail"
$defaultMessageBody = "Message from PowerShell."
$defaultSmtpPort = 587
$defaultUseSSLInput = "yes"

# Get login information from the user, use default values
$smtpServer = Read-Host "Enter the SMTP server address(default: $defaultSmtpServer)" 
$smtpServer = if ($smtpServer) { $smtpServer } else { $defaultSmtpServer }

$smtpFrom = Read-Host "Enter the sender email address" 

$smtpTo = Read-Host "Enter the recipient email address" 

$messageSubject = Read-Host "Enter the email subject(default: $defaultMessageSubject)" 
$messageSubject = if ($messageSubject) { $messageSubject } else { $defaultMessageSubject }

$messageBody = Read-Host "Enter email message body(default: $defaultMessageBody)" 
$messageBody = if ($messageBody) { $messageBody } else { $defaultMessageBody }

$smtpUsername = Read-Host "Enter the SMTP user name" 

$smtpPassword = Read-Host "Enter the SMTP password" -AsSecureString 

$smtpPort = Read-Host "Enter the SMTP port(default: $defaultSmtpPort)" 
$smtpPort = if ($smtpPort) { [int]$smtpPort } else { $defaultSmtpPort }

$useSSLInput = Read-Host "Do you want to use SSL?(yes/no) (default: $defaultUseSSLInput)" 
$useSSLInput = if ($useSSLInput) { $useSSLInput } else { $defaultUseSSLInput }

# Determine the use of SSL
$useSSL = if ($useSSLInput -eq "yes") { $true } else { $false }

# Credential creation
$credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $smtpUsername, $smtpPassword

# Sending an email
try {
    Send-MailMessage -From $smtpFrom -To $smtpTo -Subject $messageSubject -Body $messageBody -SmtpServer $smtpServer -Credential $credentials -Port $smtpPort -UseSsl:$useSSL -ErrorAction Stop
    Write-Host "The email was sent successfully." -ForegroundColor Green
} catch {
    Write-Host "Failed to send email. Error message: $_" -ForegroundColor Red
}
