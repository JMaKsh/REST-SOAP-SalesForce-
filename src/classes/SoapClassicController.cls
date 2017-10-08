public with sharing class SoapClassicController {

    public String orgAaccDetailId {
        get;
        set;
    }

    public String orgBaccDetailId {
        get;
        set;
    }

    public String filteredAccLastName {
        get;
        set;
    }
    public Contact orgAContactDetail {
        get;
        set;
    }
    public Contact orgBContactDetail {
        get;
        set;
    }

    public List<Contact> contactsFromOrgA {
        public get;
        private set;
    }
    public Map<Id, Contact> contactMap;
    public Map<Id, Contact> mapBContacts;

    public List<Contact> filteredContactsFromOrgB {
        public get;
        private set;
    }
    public String contactBDeleteId {
        get;
        set;
    }

    public Boolean visible {
        get;
        set;
    }

    public Boolean show {
        get;
        set;
    }

    public String editId {
        get;
        set;
    }
    public String editLastName {
        get;
        set;
    }
    public String editFirstName {
        get;
        set;
    }
    public String editPhone {
        get;
        set;
    }
    public String editEmail {
        get;
        set;
    }

    public String newContactLastName {
        get;
        set;
    }

    public String newContactFirstName {
        get;
        set;
    }
    public String newContactPhone {
        get;
        set;
    }
    public String newContactEmail {
        get;
        set;
    }
    public SoapClassicController() {
        contactsFromOrgA = [
                SELECT Id,
                        LastName,
                        FirstName,
                        Phone,
                        Email
                FROM Contact
        ];
        orgBContactDetail = new Contact();
        contactMap = new Map<Id, Contact>(contactsFromOrgA);
        List<Contact> filteredContactsFromOrgB = new List<Contact>();
    }

    public PageReference orgAContactDetailInfo() {
        visible = false;
        System.debug(orgAaccDetailId);
        if(orgAaccDetailId!=null) {
            orgAContactDetail = contactMap.get(orgAaccDetailId);
            filteredContactsFromOrgB = SoapClassicService.callgetContact(filteredAccLastName);
        }
        return null;

    }

    public void orgBContactDetailInfo() {
        mapBContacts = new Map<Id, Contact>(filteredContactsFromOrgB);
        orgBContactDetail = mapBContacts.get(orgBaccDetailId);
    }

    public void deleteContactOnOrgB() {
        SoapClassicService.deleteContactonOrgB(contactBDeleteId);
        orgAContactDetailInfo();
    }

    public void editContactOnOrgB() {
        visible = true;

    }
    public void saveEditContact() {
        Contact contactEdit = new Contact(Id = editId, LastName = editLastName, FirstName = editFirstName, Phone = editPhone, Email = editEmail);
        System.debug(contactEdit);
        SoapClassicService.editContactOnOrgB(contactEdit);
        visible = false;
        orgAContactDetailInfo();

    }

    public PageReference cancelEdit() {
        visible = false;
        return null;
    }

    public PageReference cancelNew() {
        show = false;
        return null;
    }

    public PageReference showInputSection() {
        show = true;
        return null;
    }

    public void saveNewContact() {
        Contact newContact = new Contact(LastName = newContactLastName, FirstName = newContactFirstName, Phone = newContactPhone, Email = newContactEmail);
        SoapClassicService.editContactOnOrgB(newContact);
        show = false;
        newContactLastName = null;
        newContactFirstName = null;
        newContactPhone = null;
        newContactEmail = null;
    }
}