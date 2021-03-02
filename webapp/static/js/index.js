var getUrl = window.location;
var baseUrl = getUrl .protocol + "//" + getUrl.host;



function activate_delete_device_modal(ko_object){
    $("#delete_device_modal").modal("show");
    sim_vm.staged_delete_device.device_id(ko_object.device_id());
}

function create_leaf_devices(device_vm){
    var json_data = ko.toJSON(device_vm);
    $.ajax(
        {
            url: create_device_endpoint,
            type: "POST",
            data: json_data,
            contentType: "application/json",
            success: function(data) {
                data = JSON.parse(data);
                toastr.success(data.method_called,"Success");
            }
        }
    );
}

function delete_device(device_vm){
    var json_data = ko.toJSON(device_vm);
    $.ajax(
        {
            url: delete_device_endpoint,
            type: "POST",
            data: json_data,
            contentType: "application/json",
            success: function(data) {
                data = JSON.parse(data);
                toastr.success(data.method_called,"Success");
            }
        }
    );
}

function iothub_vm(){
    var self = this;
    self.region = ko.observable("eastus");
}

function sim_region_vm(){
    var self = this;
    self.region = ko.observable("eastus");
}

function leaf_devices_vm(){
    var self = this;
    self.device_id = ko.observable("liadf9");
    self.number_devices = ko.observable(1);
    self.sim_region = ko.observable("eastus");
    self.name = ko.observable("friendly name");
}

function hydrate_devices(){
    sim_vm.devices.removeAll();
    new_device = new leaf_devices_vm();
    sim_vm.devices.push(new_device);
    new_device_2 = new leaf_devices_vm();
    new_device_2.device_id("123456");
    sim_vm.devices.push(new_device_2);
}

function sim_manager_vm(){
    var self = this;
    self.staged_delete_device = new leaf_devices_vm();
    self.staged_delete_simregion = new sim_region_vm();
    self.staged_delete_iothub = new iothub_vm();

    self.staged_add_device = new leaf_devices_vm();
    self.staged_add_simregion = new sim_region_vm();
    self.staged_add_iothub = new iothub_vm();

    self.devices = ko.observableArray();

    self.num_leaf_devices = ko.observable("loading...");

    self.create_leaf_devices = function() { create_leaf_devices(self.staged_add_device); };
    self.delete_device = function() { delete_device(self.staged_delete_device); };
    self.activate_delete_device_modal = function() { activate_delete_device_modal(this); };
}

var sim_vm = new sim_manager_vm();

ko.applyBindings(sim_vm, document.getElementById("page_content"));
hydrate_devices();