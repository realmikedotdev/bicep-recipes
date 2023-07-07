// Variables
var AD01Name = 'pref-AD01'
var AD02Name = 'pref-AD02'
var AD03Name = 'pref-AD03'
var vmSize = 'Standard_Bs'
var vmPublisher = 'MicrosoftWindowsServer'
var vmOffer = 'WindowsServer'
var vmSku = '2012-R2-Datacenter'
var vmVersion = 'latest'
var vNetName = 'pref-vNet'
var nsgName = 'pref-nsg'
var lawName = 'pref-law'

// Parameters
param resLocation string = 'eastus'
param compName string = {}
param adminUn string = {}
@secure()
param adminPwd string = {}

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

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'name'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'name'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: 'subnet.id'
          }
        }
      }
    ]
  }
}

resource ADVM01 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: AD01Name
  location: resLocation
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: compName
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
        name: '${AD01Name}-OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: '${AD01Name}-NIC'
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
}

resource ADVM02 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: AD02Name
  location: resLocation
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: compName
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
        name: '${AD02Name}-OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: '${AD02Name}-NIC'
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
}

resource ADVM03 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: AD03Name
  location: resLocation
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: compName
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
        name: '${AD03Name}-OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: '${AD03Name}-NIC'
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
}

