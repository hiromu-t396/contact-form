using namespace System.Net

# Input bindings are passed in via param block.
param( $Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host  "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$Request_Array = $Request.Body.Split("&")
$Request_Hash = @{};
foreach($line in $Request_Array){
    $line =  [System.Web.HttpUtility]::UrlDecode(($line), [System.Text.Encoding]::UTF8)
    $line_split = ($line.Split("="))
    $Request_Hash.($line_split[0]) = $line_split[1]
}

$Response_Hash    = [PSObject]@{
    PartitionKey = $Request_Hash.email
    RowKey = get-date -Format  "yyyy-MM-dd HH:mm:ss.ms"
    name = $Request_Hash.name
    email = $Request_Hash.email
    telephone = ($Request_Hash.tel1 + "-" + $Request_Hash.tel2 + "-" + $Request_Hash.tel3)
    category = $Request_Hash.category
    inquiry = $Request_Hash.message
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext] @{
    headers    = @{ 'content-type' = 'text/json' }
    StatusCode = [HttpStatusCode]::OK
    Body = $Response_Hash | ConvertTo-Json
})

# Inquiry table update
Push-OutputBinding -Name outputTable -Value ($Response_Hash | ConvertTo-Json)