var getUrl = window.location;
var baseUrl = getUrl .protocol + "//" + getUrl.host;



function activate_configure_sim_region_modal(ko_object){
    $("#configure_sim_region_modal").modal("show");
    sim_vm.staged_sim_configure.region(ko_object.region());
}

function configure_sim_region(ko_object){
    var json_data = ko.toJSON(ko_object);
    $.ajax(
        {
            url: configure_sim_region_endpoint,
            type: "POST",
            data: json_data,
            contentType: "application/json",
            success: function(data) {
                data = JSON.parse(data);
                toastr.success(data.method_called,"Success");
                $("#configure_sim_region_modal").modal("hide");
            }
        }
    );
}

function sim_region_vm(){
    var self = this;
    self.region = ko.observable("eastus");
    self.name = ko.observable("name");
    self.num_devices = ko.observable(0);
}

function hydrate_sim_regions(){
    sim_vm.simulated_regions.removeAll();
    new_region = new sim_region_vm();
    new_region.name("default");
    sim_vm.simulated_regions.push(new_region);
    sim_vm.num_devices(new_region.num_devices());
}

function sim_manager_vm(){
    var self = this;

    self.add_sim_region = new sim_region_vm();
    self.staged_sim_configure = new sim_region_vm();

    self.simulated_regions = ko.observableArray();

    self.num_devices = ko.observable("loading...");

    self.configure_sim_region = function() { configure_sim_region(self.staged_sim_configure); };
    self.activate_configure_sim_region_modal = function() { activate_configure_sim_region_modal(this); };
}

var sim_vm = new sim_manager_vm();

ko.applyBindings(sim_vm, document.getElementById("page_content"));
hydrate_sim_regions();