from flask import Blueprint, request, jsonify
import simplejson

simulate = Blueprint('simulate', __name__, url_prefix='/api/simulate')

@simulate.route('/leafdevice', methods=['POST'])
def simulate_leaf_device():
    '''
    simulateas a leaf device
    '''
    r_json = request.get_json()
    return simplejson.dumps(r_json, ignore_nan=True)