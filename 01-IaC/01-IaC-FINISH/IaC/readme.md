This is the finished IaC code as far as this module is concerned.

IaC here will simply deploy the basic components for the entire architecture with minimalistic configuration.

Deployed Components
*    DPS
*    IoT Hub w/ route to ADLSg2
*    ADLSg2
*    Azure Container Instance (for leaf device)
*    Vnet w/ 3 VMs where ONLY one VM can communicate out of it to IoT Hub (for gateway patterns)
*    App Service (for cert issuer)