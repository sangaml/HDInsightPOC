$RG = "spark"
$location = "eastus2"
New-AzureRmResourceGroup -Name $RG -Location $location
New-AzureRmResourceGroupDeployment -Name spark -ResourceGroupName $RG `
 -TemplateUri "https://raw.githubusercontent.com/sangaml/HDInsightPOC/master/spark.json" `
-TemplateParameterUri "https://raw.githubusercontent.com/sangaml/HDInsightPOC/master/spark.parameters.json"
