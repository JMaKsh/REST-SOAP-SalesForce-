({
    cancel: function (component, event, helper) {
        var compEvent = component.getEvent("ComponentEvent");
        var temp = component.get("v.selectContact");
        compEvent.setParam("showEditForm", false);
        compEvent.fire();
    },

    saveEditedContact: function (component, event, helper) {

        var editedContact = component.get("v.selectContact");
        editedContact.sobjectType = 'Contact';
        console.log("EditedContactTypeafter: " + editedContact.sobjectType);
        console.log("editedContact---->" + JSON.stringify(editedContact));
        var action = component.get("c.editContactOnOrgB");
        action.setParams({
            "contactEdit": JSON.stringify(editedContact)
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("SUCCESS edited");
            }
            else {
                console.log(response.getError());
            }
        });
        $A.enqueueAction(action);
        var compEvent = component.getEvent("ComponentEvent");
        var temp = component.get("v.selectContact");
        compEvent.setParam("showEditForm", false);
        compEvent.fire();
    }
})