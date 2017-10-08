({
    createNewContactB: function (component, event, helper) {
        component.set("v.show", true);
    },

    cancel: function (component, event, helper) {
        var tempContact = component.get("v.tempContact");
        component.set("v.show", false);
        component.set("v.newContact", tempContact);
    },

    saveNewContact: function (component, event, helper) {
        var newContact = component.get("v.newContact");
        var tempContact = component.get("v.tempContact");
                var emailField = component.find("ContactEmail");
        var emailFieldValue = emailField.get("v.value");
        console.log('newContact.Email: '+newContact.Email);
        newContact.sobjectType = 'Contact';
        var isValidEmail = true;
        var emailFieldValue = newContact.Email;
        var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (!$A.util.isEmpty(emailFieldValue)) {
            if (emailFieldValue.match(regExpEmailformat)) {
                emailField.set("v.errors", [{message: null}]);
                $A.util.removeClass(emailField, 'slds-has-error');
                isValidEmail = true;
            } else {
                $A.util.addClass(emailField, 'slds-has-error');
                emailField.set("v.errors", [{message: "Please Enter a Valid Email Address"}]);
                isValidEmail = false;
            }
        }

        if (isValidEmail) {
            var action = component.get("c.saveEditContact");
            action.setParams({
                "contactNew": JSON.stringify(newContact)
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
            component.set("v.show", false);
            component.set("v.newContact",tempContact);

        }
    }
})