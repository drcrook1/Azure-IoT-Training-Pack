from flask import Blueprint, request, jsonify
import simplejson
import os

simulate = Blueprint('simulate', __name__, url_prefix='/api/simulate')

@simulate.route('/simregion/configure', methods=['POST'])
def configure_sim_region():
    '''
    simulateas a leaf device
    '''
    r_json = request.get_json()
    print(r_json)
    helm_chart = os.environ["DEVICE_HELM_CHART"]
    device_acr_image = os.environ["DEVICE_ACR_IMAGE"]
    DPS_CONN_STR = os.environ["DPS_CONN_STR"]
    replicas = r_json["num_devices"]
    device_deploy_name = os.environ["DEVICE_DEPLOY_NAME"]
    # read configs
    # Deploy leafdevice .yaml to aks
    # Write deployment information to sql
    # helm deploy
    # az aks get credentials -n -g
    # key vault mounting to the correct ~/.kube
    # just copy to ~/.kube
    # helm upgrade
    helm_install_cmd = "helm upgrade --install {deploy_name} {helm_chart} {replicas_set} {image_set} {env_set}".format(
                                deploy_name = device_deploy_name,
                                helm_chart = helm_chart,
                                replicas_set = "--set device.replicas={}".format(replicas),
                                image_set = "--set device.image={}".format(device_acr_image),
                                env_set = "{dps_conn_set}".format(
                                    dps_conn_set="--set device.env.DPSCONNSTR={}".format(DPS_CONN_STR)
                                )
                            )
    print(helm_install_cmd)
    stream = os.popen(helm_install_cmd)
    print(stream.read())
    r_json["method_called"] = "/simregion/configure"
    return simplejson.dumps(r_json, ignore_nan=True)
