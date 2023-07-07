// Variables
var AD01Name = 'pref-AD01'
var AD02Name = 'pref-AD02'
var AD03Name = 'pref-AD03'
var vmSize = 'Standard_Bs'
var vmPublisher = 'MicrosoftWindowsServer'
var vmOffer = 'WindowsServer'
var vmSku = '2012-R2-Datacenter'
var vmVersion = 'latest'

// Parameters
param resLocation string = 'eastus'
param compName string = {}
param adminUn string = {}
param adminPwd string = {}

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
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: 'id'
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
      computerName: 'computerName'
      adminUsername: 'adminUsername'
      adminPassword: 'adminPassword'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2012-R2-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: 'id'
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
      computerName: 'computerName'
      adminUsername: 'adminUsername'
      adminPassword: 'adminPassword'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2012-R2-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: 'id'
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
