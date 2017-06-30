# Habitica Command Module 0.1
# 06/30/2017

Function Get-HabiticaUserData {
Param(
    [Parameter(ParameterSetName='ManualGuids',Position=0,Mandatory=$true)][string]$userguid,
    [Parameter(ParameterSetName='ManualGuids',Position=1,Mandatory=$true)][string]$keyguid#,
    #[Parameter(ParameterSetName='ImportGuids',ValueFromPipeline=$true)]$guidobject,
    #[Parameter(ParameterSetName='ImportGuids')][switch]$UseSavedCredentials
)

#Change these values to your own from the Habitica Page -> Settings -> API
$headers = @{'x-api-user' = $userguid;'x-api-key' = $keyguid}

#Habitica API URLs
[string]$urlUserData = 'https://habitica.com/api/v3/user'

#grabbing your current user data
$UserData = Invoke-RestMethod -Uri $urlUserData -Headers $headers -Method GET

return $UserData
}

Get-Member -inputobject $userdata.data.items.hatchingpotions