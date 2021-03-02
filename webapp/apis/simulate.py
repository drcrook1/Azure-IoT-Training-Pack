from flask import Blueprint, request, jsonify
import simplejson

simulate = Blueprint('simulate', __name__, url_prefix='/api/simulate')

@simulate.route('/leafdevice/create', methods=['POST'])
def create_leaf_device():
    '''
    simulateas a leaf device
    '''
    r_json = request.get_json()
    print(r_json)
    # read configs
    # Deploy leafdevice .yaml to aks
    # Write deployment information to sql
    r_json["method_called"] = "leafdevice/create"
    return simplejson.dumps(r_json, ignore_nan=True)

@simulate.route('/leafdevice/delete', methods=['POST'])
def delete_leaf_device():
    '''
    simulateas a leaf device
    '''
    r_json = request.get_json()
    print(r_json)
    # read configs
    # Deploy leafdevice .yaml to aks
    # Write deployment information to sql
    r_json["method_called"] = "leafdevice/delete"
    return simplejson.dumps(r_json, ignore_nan=True)    