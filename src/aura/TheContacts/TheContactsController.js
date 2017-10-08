({
    doInit: function (component, event, helper) {
        var action = component.get("c.getContactsFromOrgA");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var contactMap = response.getReturnValue();//component.set("v.contacts", response.getReturnValue());
                component.set("v.contactsMap", contactMap);
                var contactList = [];
                for (var key in contactMap) {
                    console.log("key = " + key);
                    contactList.push(contactMap[key]);
                }
                console.log(contactList);
                component.set("v.contactsList", contactList);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },

    locationChange: function (component, event, helper) {
        var token = event.getParam("token");
        if (token != null) {
            if (token.indexOf('contact/') === 0) {
                var contactId = token.substr(token.indexOf('/') + 1);
                var map = component.get("v.contactsMap");
                if (!map) {
                    var link = location.href;
                    console.log(link.substring(0, link.indexOf(token) - 1));
                    location.href = link.substring(0, link.indexOf(token) - 1);
                    return;
                }
                component.set("v.selContact", map[contactId]);
                console.log(map[contactId].LastName);
                var action = component.get("c.getContactsFromOrgB");
                action.setParams({
                    "regex": map[contactId].LastName
                });
                action.setCallback(this, function (response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var contactsBMap = response.getReturnValue();
                        component.set("v.contactsBMap", contactsBMap);
                        var contactsBList = [];
                        for (var key in contactsBMap) {
                            console.log("key = " + key);
                            contactsBList.push(contactsBMap[key]);
                        }
                        console.log(contactsBList);
                        component.set("v.contactsBList", contactsBList);
                    }
                    else {
                        console.log("Failed with state: " + state);
                    }
                });
                $A.enqueueAction(action);
            }
        }
    },

    createNewContactB: function (component, event, helper) {
        component.set("v.show", true);
    }
})