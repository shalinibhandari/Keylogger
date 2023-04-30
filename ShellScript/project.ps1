Param( [String]$Att,
       [String]$Subj,
       [String]$Body
     )

Function Send-EMail
{
    Param(
            [Parameter(`
            Mandatory=$true)]
        [String]$To,
            [Parameter(`
            Mandatory=$true)]
        [String]$From,
            [Parameter(`
            Mandatory=$true)]
        [String]$Password,
            [Parameter(`
            Mandatory=$true)]
        [String]$Subject,
            [Parameter(`
            Mandatory=$true)]
        [String]$Body,
            [Parameter(`
            Mandatory=$true)]
        [String]$Attachment
        )

try
{
    $Msg = New-Object System.Net.MailMessage($From, $To, $Subject, $Body)
    $Srv = "smtp.gmail.com"
    if($Attachment -ne $null)
    {
        try
        {
            $Attachments = $Attachment -split ("\:\:");

            ForEach($val in $Attachments)
            {
                $attach = New-Object System.Net.Mail.Attachment($val)
                $Msg.Attachments.Add($attach)
            }
        }
        catch
        {
            exit 2;
        }

        $Client = New-Object Net.Mail.SmtpClient($Srv, 587)
        $Client.EnableSsl = $true
        $Client.Credentials = New-Object System.Net.NetworkCredential($From.Split("@")[0], $Password);
        $Client.Send($Msg)
        Remove-Variable -Name Client
        Remove-Variable -Name Password
        exit 7;
    }
}

catch
    {
        exit 3;
    }
}

try
{
    Send-EMail
        -Attachment $Att
        -To "Address of the recipient"
        -Body $Body
        -Subject $Subj
        -Password "xyz"
        -From "Address of the Sender"
}

catch
{
    exit 4;
}