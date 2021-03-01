var getUrl = window.location;
var baseUrl = getUrl .protocol + "//" + getUrl.host;



function activate_delete_device_modal(ko_object){
    $("#deleteopenpositionmodal").modal("show");
    sim_vm.staged_delete_device.device_id = ko_object.device_id;
}

function create_leaf_devices(device_vm){
    alert("YAY!  Its a place holder!");
}

function delete_device(device_vm){
    alert("Delete Device Placeholder!")
}

function iothub_vm(){
    var self = this;
    self.region = "eastus";
}

function sim_region_vm(){
    var self = this;
    self.region = "eastus";
}

function leaf_devices_vm(){
    var self = this;
    self.device_id = ko.observable("liadf9");
    self.number_devices = ko.observable(1);
    self.sim_region = ko.observable("eastus");
}



function sim_manager_vm(){
    var self = this;
    self.staged_delete_device = new leaf_devices_vm();
    self.staged_delete_simregion = new sim_region_vm();
    self.staged_delete_iothub = new iothub_vm();

    self.staged_add_device = new leaf_devices_vm();
    self.staged_add_simregion = new sim_region_vm();
    self.staged_add_iothub = new iothub_vm();

    self.num_leaf_devices = ko.observable("loading...");

    self.create_leaf_devices = function() { create_leaf_devices(self.staged_add_device); };
}

var sim_vm = new sim_manager_vm();

ko.applyBindings(sim_vm, document.getElementById("page_content"));