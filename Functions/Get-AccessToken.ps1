function Get-AccessToken {

    [CmdletBinding(PositionalBinding = $false)]

    Param(
        # Insert 3Sys API Client ID
        [Parameter(Mandatory = $true)]
        [String]
        $ClientID,

        # Insert 3Sys API Client Secret
        [Parameter(Mandatory = $true)]
        [String]
        $ClientSecret,

        # The sitehost to connect to
        [Parameter(Mandatory = $true)]
        [string]
        $Server
    )
    
    Add-type -AssemblyName System.Web
    
    $ClientIdEncoded = [System.Web.HttpUtility]::UrlEncode($ClientID)
    $ClientSecretEncoded = [System.Web.HttpUtility]::UrlEncode($ClientSecret)

    $PassAccessTokenParams = @{
        Uri         = "https://$Server/Wcbs.API/api/token"
        Method      = 'POST'
        ContentType = 'application/x-www-form-urlencoded'
        Body        = "grant_type=client_credentials&client_id=$ClientIdEncoded&client_secret=$ClientSecretEncoded"
    }

    Invoke-RestMethod @PassAccessTokenParams -Verbose
}
