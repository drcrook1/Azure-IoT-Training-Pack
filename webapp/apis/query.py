from azure.kusto.data import KustoClient, KustoConnectionStringBuilder
from azure.kusto.data.exceptions import KustoServiceError
from azure.kusto.data.helpers import dataframe_from_result_table

AAD_TENANT_ID = "72f988bf-86f1-41af-91ab-2d7cd011db47"
KUSTO_CLUSTER = "https://nvidiadeepstreamadx.eastus.kusto.windows.net"
KUSTO_DATABASE = "nvidiadeepstreamadxdb"

# authenticate with AAD device code.
#kcsb = KustoConnectionStringBuilder.with_aad_device_authentication(
#    KUSTO_CLUSTER)

# authenticate with Azure CLI
kcsb = KustoConnectionStringBuilder.with_az_cli_authentication(KUSTO_CLUSTER)
kcsb.authority_id = AAD_TENANT_ID

kusto_client = KustoClient(kcsb)
kusto_query = "iot_parsed | take 10"

response = kusto_client.execute(KUSTO_DATABASE, kusto_query)
# iterating over rows is possible
for row in response.primary_results[0]:
    # printing specific columns by index
    print(row)
    print(row[0])
    print(row[1])
    print(row[2])
    print("\n")
