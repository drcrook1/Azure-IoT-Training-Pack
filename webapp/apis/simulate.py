from flask import Blueprint, request, jsonify
import simplejson

simulate = Blueprint('simulate', __name__, url_prefix='/api/simulate')

@simulate.route('/simregion/configure', methods=['POST'])
def configure_sim_region():
    '''
    simulateas a leaf device
    '''
    r_json = request.get_json()
    print(r_json)
    # read configs
    # Deploy leafdevice .yaml to aks
    # Write deployment information to sql
    # helm deploy
    r_json["method_called"] = "/simregion/configure"
    return simplejson.dumps(r_json, ignore_nan=True)
