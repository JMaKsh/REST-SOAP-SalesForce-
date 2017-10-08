
public with sharing class SoapLightningController {

    @AuraEnabled
    public static Map<Id, Contact> getContactsFromOrgA() {

        Map<Id, Contact> contactAMap = new Map<Id, Contact>([
                SELECT Id,
                        LastName,
                        FirstName,
                        Phone,
                        Email
                FROM Contact
        ]);

        return contactAMap;
    }

    @AuraEnabled
    public static Map<Id, Contact> getContactsFromOrgB(String regex) {
        List<Contact> contactsFromOrgB = new List<Contact>();
        contactsFromOrgB = SoapClassicService.callgetContact(regex);
        Map<Id, Contact> contactsMapFromOrgB = new Map<Id, Contact>(contactsFromOrgB);
        return contactsMapFromOrgB;
    }

    @AuraEnabled
    public static void deleteContactFromOrgB(String deleteId) {
        SoapClassicService.deleteContactonOrgB(deleteId);
    }

    @AuraEnabled
    public static void editContactOnOrgB(String contactEdit) {
        Contact editedContact = (Contact) JSON.deserialize(contactEdit, Contact.class);
        SoapClassicService.editContactOnOrgB(editedContact);
    }

    @AuraEnabled
    public static void saveEditContact(String contactNew) {
        Contact newContact = (Contact) JSON.deserialize(contactNew, Contact.class);
        SoapClassicService.editContactOnOrgB(newContact);
    }
}