#
# account
alias azacl='az account list'
# group
alias azgrl='az group list'
# storage account
alias azsal='az storage account list'
# resource
alias azrct='az resource tag --tags Department=Finance --resource-group NetworkWatcherRG --name msftlearn-vnet1 --resource-type "Microsoft.Network/virtualNetworks"'
# vm
alias azvml='az vm list'
alias azvmc='az vm create --name objVM --resource-group NetworkWatcherRG --image UbuntuLTS --admin-username admin --generate-ssh-keys'
# webapp
alias azwau='az webapp up --sku F1 --location us-east --name biblia'