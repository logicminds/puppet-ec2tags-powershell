# frozen_string_literal: true

Facter.add(:aws_ec2tags) do
  confine kernel: 'windows'
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  # You'll want to ensure the instance has permissions to describe/list ec2 tags to accomplish this without error

  $response = Invoke-RestMethod -Uri 'http://169.254.169.254/latest/dynamic/instance-identity/document' -TimeoutSec 5
  $filters = @(
      [Amazon.EC2.Model.Filter]::new('resource-id', $response.InstanceId)
  )
  $tags = Get-EC2Tag -Filters $filters
  $tagcollection = $tags.ForEach{
      $t = $_
      [pscustomobject]@{
          Name  = { $t.name -replace ' ', '_' }
          Value = $t.value
      }
  }
  Write-Host "Tags For Instance: $($tagcollection | Format-Table -AutoSize -Wrap | Out-String)"
  $script:NameTag = $Tags.GetEnumerator().Where{ $_.Key -eq 'Name' }.Value.ToLower().Trim()
  $script:InstanceId = $response.InstanceId
  $script:AccountId = $response.accountId
    setcode do
      'hello facter'
    end
end
