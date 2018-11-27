$RG = "kafka"
$location = "eastus2"
New-AzureRmResourceGroup -Name $RG -Location $location
New-AzureRmResourceGroupDeployment -Name kafka -ResourceGroupName $RG `
 -TemplateUri "https://raw.githubusercontent.com/sangaml/HDInsightPOC/master/kafka.json" `
-TemplateParameterUri "https://raw.githubusercontent.com/sangaml/HDInsightPOC/master/kafka.parameters.json"
