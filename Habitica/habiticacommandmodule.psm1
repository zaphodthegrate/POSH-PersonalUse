# Set-RandomHabiticaPet v1.0
# 04/04/2016

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
[string]$urlEquipPet = 'https://habitica.com/api/v2/user/inventory/equip/pet/'

#I saw no way in the API to grab your current inventory, but I did see that you can get your inventory when you set something
#So the first part is when I grab whatever pet you currently have, then set it again

#grabbing your current user data
$UserData = Invoke-RestMethod -Uri $urlUserData -Headers $headers -Method GET
[string]$currentPet = $UserData.items.currentPet

#sometimes the API call fails, so you need this if statement so you don't set an empty pet 
if ($currentPet) {
    [string]$urlInventory = $urlEquipPet + $currentPet
    
    #setting the same pet and capturing the results
    $allInventory = Invoke-RestMethod -Uri $urlInventory -Headers $headers -Method POST
    
    #geting the list of pets
    $allPets = Get-Member -InputObject $allInventory.pets | where {$_.MemberType -eq "NoteProperty"}

    #grabbing a random pet
    $newPet = $allPets | Get-Random
    [string]$urlNewPet = $urlEquipPet + $newPet.Name
    
    #setting the new pet
    Invoke-RestMethod -Uri $urlNewPet -Headers $headers -Method POST
} 
