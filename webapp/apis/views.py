from flask import Blueprint, request, jsonify, render_template, url_for
import simplejson

views = Blueprint('views', __name__)

@views.route('/')
@views.route('/index')
def index():
    '''
    returns index view
    '''
    return render_template('index.html', 
            meta_title = "Azure IoT Reference Architecture", 
            meta_url = request.url,
            meta_description = "A fully deployed skeleton version of the Azure IoT Reference Architecture.")