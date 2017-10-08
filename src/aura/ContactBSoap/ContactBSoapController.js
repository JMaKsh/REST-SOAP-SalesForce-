({
    showDetails: function (component, event, helper) {
        var selectedItem = event.currentTarget;
        var selectedId = selectedItem.dataset.record;
        console.log('selectedId  = ' + selectedId);
        var map = component.get("v.contactsBMap");
        var selectedContact = map[selectedId];
        var selectContact = map[selectedId];
        console.log(selectedContact);
        component.set("v.selectedContactB", selectedContact);
        component.set("v.selectContactB", selectContact);

    },

    editClick: function (component, event, helper) {
        var contactId = event.target.id;
        console.log("contactId" + contactId);
        var Mapcontact = component.get("v.contactsBMap");
        console.log("contact" + Mapcontact[contactId].LastName);
        component.set("v.selectContactB", Mapcontact[contactId]);
        component.set("v.show", true);
    },

    deleteClick: function (component, event, helper) {
        if (confirm("Are you sure to delete this Item?")) {
            var contactId = event.target.id;
            console.log("deleteClick delete ID: " + contactId);
            var action = component.get("c.deleteContactFromOrgB");
            action.setParams({
                "deleteId": contactId
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    console.log("SUCCESS deleted");

                }
                else {
                    console.log("Failed with state: " + state);
                }
            });
            $A.enqueueAction(action);
        }
    },

    handleComponentEvent: function (component, event) {
        var visible = event.getParam("show");

        // set the handler attributes based on event data
        component.set("v.show", visible);

    }
})