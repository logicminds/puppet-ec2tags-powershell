# Running in context of the remote server
# You'll want to ensure the instance has permissions to describe/list ec2 tags to accomplish this without error

$response = Invoke-RestMethod -Uri 'http://169.254.169.254/latest/dynamic/instance-identity/document' -TimeoutSec 5
$filters = @(
    [Amazon.EC2.Model.Filter]::new('resource-id', $response.InstanceId)
)
$tags = Get-EC2Tag -Filters $filters
$tagcollection = $tags.ForEach{
    $t = $_
    Write-Host 'ec2_tag_'+$t.key+'='+$t.Value
}
