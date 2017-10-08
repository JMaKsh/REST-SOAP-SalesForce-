public class SoapClassicService {
    private static final String username = 'orgB@mg.com';
    private static final String password = 'salesforce2X8XB8QwEHoqrCdZbSI12BtRBg';
    public static SoapWebserviceHandler.SoapWebService soapWebService;

    public static SoapWebserviceHandler.SoapWebService initializeConnection() {
        partnerSoapSforceCom.Soap partnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoapSforceCom.LoginResult partnerLoginResult = partnerSoap.login(username, password);
        SoapWebserviceHandler.SessionHeader_element webserviceSessionHeader = new SoapWebserviceHandler.SessionHeader_element();
        webserviceSessionHeader.sessionId = partnerLoginResult.sessionId;
        soapWebService = new SoapWebserviceHandler.SoapWebService();
        soapWebService.SessionHeader = webserviceSessionHeader;
        return soapWebService;

    }

    public static List <Contact> callgetContact(String filteredAccLastName) {
        SoapClassicService.initializeConnection();
        filteredAccLastName = filteredAccLastName.substring(0, 4);
        List<SoapWebserviceHandler.Contact> listContacts = soapWebService.getContacts(filteredAccLastName);
        List<Contact> contactsList = new List<Contact>();
        for (SoapWebserviceHandler.Contact contact : listContacts) {
            Contact tempContact = new Contact();
            tempContact.Id = contact.Id;
            tempContact.LastName = contact.LastName;
            tempContact.FirstName = contact.FirstName;
            tempContact.Phone = contact.Phone;
            tempContact.Email = contact.Email;
            contactsList.add(tempContact);
        }
        System.debug(listContacts);
        return contactsList;

    }
    public static void deleteContactonOrgB(String deleteContactId) {
        SoapClassicService.initializeConnection();
        soapWebService.deleteContact(deleteContactId);
    }

    public static void editContactOnOrgB(Contact editContact) {
        SoapClassicService.initializeConnection();
        soapWebService.upsertContact(editContact.Id, editContact.LastName, editContact.FirstName, editContact.Phone, editContact.Email);
    }
}