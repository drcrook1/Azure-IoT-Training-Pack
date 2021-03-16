from flask import Blueprint, request, jsonify
from azure.kusto.data import KustoClient, KustoConnectionStringBuilder
from azure.kusto.data.exceptions import KustoServiceError
from azure.kusto.data.helpers import dataframe_from_result_table
import simplejson
import os

timeseries = Blueprint('timeseries', __name__, url_prefix='/api/timeseries')

@timeseries.route('/sample', methods=['GET'])
def sample_data():
    '''
    executes a sample ADX query returning only 10 rows.
    '''
    results = query_kusto("iot_parsed | take 10")
    return simplejson.dumps(results, ignore_nan=True)

def query_kusto(query : str):
    """
    creates connection with kusto and queries
    """
    AAD_TENANT_ID = os.environ["AAD_TENANT_ID"]
    KUSTO_CLUSTER = os.environ["KUSTO_CLUSTER"]
    KUSTO_DATABASE = os.environ["KUSTO_DATABASE"]

    kcsb = KustoConnectionStringBuilder.with_az_cli_authentication(KUSTO_CLUSTER)
    kcsb.authority_id = AAD_TENANT_ID
    kusto_client = KustoClient(kcsb)
    response = kusto_client.execute(KUSTO_DATABASE, query)

    return response.primary_results
