This module does nothing more than go through Bicep and deploys the main resources

Deployed Components
*    DPS
*    IoT Hub w/ route to ADLSg2
*    ADLSg2
*    Azure Container Instance (for leaf device)
*    Vnet w/ 3 VMs where ONLY one VM can communicate out of it to IoT Hub (for gateway patterns)
*    App Service (for cert issuer)