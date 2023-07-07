// Variables

var vmPublisher = 'MicrosoftWindowsServer'
var vmOffer = 'WindowsServer'
var vmSku = '2022-datacenter-azure-edition-core'
var vmVersion = 'latest'
var vNetName = 'pref-vNet'
var nsgName = 'pref-nsg'
var lawName = 'pref-law'

// Parameters
param vmNames array = [
  'pref-AD01'
  'pref-AD02'
  'pref-AD03'
]
param adminUn string
@minLength(12)
@secure()
param adminPwd string
param dnsLabelPrefix string = toLower('${vmNames}-${uniqueString(resourceGroup().id, 'vmname')}')
param publicIpName string = 'mgmtPublicIP'
param publicIPAllocationMethod string = 'Dynamic'
param publicIpSku string = 'Basic'
param vmSize string = 'Standard_Bs'
param resLocation string = resourceGroup().location
param securityType string = 'TrustedLaunch'


// Resources
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: lawName
  location: resLocation
  properties: {
    sku: {
      name: 'Free'
    }
  }
}

resource advNet 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vNetName
  location: resLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'ADSubNet'
        properties: {
          addressPrefix: '10.10.0.0/24'
        }
      }
      {
        name: 'WebNet'
        properties: {
          addressPrefix: '10.10.1.0/24'
        }
      }
      {
        name: 'MgmtNet'
        properties: {
          addressPrefix: '10.10.10.0/24'
        }
      }
    ]
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: nsgName
  location: resLocation
  properties: {
    securityRules: [
      {
        name: 'ssh'
        properties: {
          description: 'SSH Access'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
        }
      }
      {
        name: 'rdp'
        properties: {
          description: 'RDP Access'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '10.10.0.0/24,10.10.10.0/24'
          destinationAddressPrefix: '10.10.0.0/24,10.10.10.0/24'
          access: 'Allow'
          priority: 111
          direction: 'Inbound'
          }
        }
    ]
  }
}

resource ADVM01NIC 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'ADVM01-nic'
  location: resLocation
  properties: {
    ipConfigurations: [
      {
        name: 'name'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: 'ADSubNet'
          }
        }
      }
    ]
  }
}

resource ADVMs 'Microsoft.Compute/virtualMachines@2020-12-01' = [for name in vmNames: {
  name: '${name}'
  location: resLocation
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: '${name}'
      adminUsername: adminUn
      adminPassword: adminPwd
    }
    storageProfile: {
      imageReference: {
        publisher: vmPublisher
        offer: vmOffer
        sku: vmSku
        version: vmVersion
      }
      osDisk: {
        name: '${name}-OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: {}
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri:  'storageUri'
      }
    }
  }
}]
