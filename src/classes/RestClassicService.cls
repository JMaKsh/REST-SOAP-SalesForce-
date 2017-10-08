public class RestClassicService {
    private final String clientId = '3MVG9HxRZv05HarRdqyvMBonX.jIimAFHO5UthXBQkAGefdODcyHVdISePEUU8lay6jLfJCvt1drd13Oleqvq';
    private final String clientSecret = '2303845741587997910';
    private final String username = 'orgB@mg.com';
    private final String password = 'salesforce2X8XB8QwEHoqrCdZbSI12BtRBg';
    private final String endPointToken = 'https://login.salesforce.com/services/oauth2/token';
    private static final String endPoint = 'https://eu11.salesforce.com/services/apexrest/Contact';
    private static List<Contact> listContacts = new List<Contact>();

    public class DeserializeResponse {
        public String id;
        public String access_token;
    }
    public String returnAccessToken(RestClassicService account) {
        String reqbody = 'grant_type=password&client_id=' + clientId + '&client_secret=' + clientSecret + '&username=' + username + '&password=' + password;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint(endPointToken);
        HttpResponse res = http.send(req);
        DeserializeResponse response = (DeserializeResponse) JSON.deserialize(res.getbody(), DeserializeResponse.class);
        return response.access_token;
    }

    public static List<Contact> callgetContact(String filteredAccLastName) {
        filteredAccLastName = filteredAccLastName.substring(0, 4);
               RestClassicService restClassicService = new RestClassicService();
        String accessToken;
        accessToken = restClassicService.returnAccessToken (restClassicService);

        if (accessToken != null) {
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization', 'Bearer ' + accessToken);
            req1.setHeader('Content-Type', 'application/json');
            req1.setHeader('accept', 'application/json');
            req1.setMethod('GET');
            req1.setEndpoint(endPoint + '?regex=' + filteredAccLastName);
            HttpResponse res1 = h2.send(req1);
            String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
            JSONParser parser = JSON.createParser(res1.getBody());
            listContacts = deserializeContactList(res1.getBody());
        }
        return listContacts;
    }

    public static List<Contact>deserializeContactList(String responseBody) {
        List<Contact> lstContact = new List<Contact>();
        JSONParser parser = JSON.createParser(responseBody);
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        SObject contactItem = (SObject) parser.readValueAs(Sobject.class);
                        Contact contact = (Contact) contactItem;
                        lstContact.add(contact);
                        parser.skipChildren();
                    }
                }
            }
        }
        return lstContact;
    }

    public static void deleteContactonOrgB(String deleteContactId) {
        RestClassicService contactsView = new RestClassicService();
        String accessToken;
        accessToken = contactsView.returnAccessToken (contactsView);
        if (accessToken != null) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('Authorization', 'Bearer ' + accessToken);
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('accept', 'application/json');
            request.setMethod('DELETE');
            request.setEndpoint(endPoint + '?delete=' + deleteContactId);
            HttpResponse response = http.send(request);

        }
    }

    public static void editContactOnOrgB(Contact editContact) {
        RestClassicService contactsView = new RestClassicService();
        String accessToken;
        accessToken = contactsView.returnAccessToken (contactsView);

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('Id', editContact.Id);
        gen.writeStringField('LastName', editContact.LastName);
        gen.writeStringField('FirstName', editContact.FirstName);
        gen.writeStringField('Phone', editContact.Phone);
        gen.writeStringField('Email', editContact.Email);
        gen.writeEndObject();
        String jsonS = gen.getAsString();
        if (accessToken != null) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('Authorization', 'Bearer ' + accessToken);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setHeader('accept', 'application/json');
            request.setMethod('POST');
            request.setBody(jsonS);
            request.setEndpoint(endPoint);
            HttpResponse response = http.send(request);
            if (response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' +
                        response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
            }
        }
    }

    public static void saveNewContactOnOrgB(Contact newContact) {
        RestClassicService contactsView = new RestClassicService();
        String accessToken;
        accessToken = contactsView.returnAccessToken (contactsView);

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('LastName', newContact.LastName);
        gen.writeStringField('FirstName', newContact.FirstName);
        gen.writeStringField('Phone', newContact.Phone);
        gen.writeStringField('Email', newContact.Email);
        gen.writeEndObject();
        String jsonS = gen.getAsString();

        if (accessToken != null) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('Authorization', 'Bearer ' + accessToken);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setHeader('accept', 'application/json');
            request.setMethod('POST');
            request.setBody(jsonS);
            request.setEndpoint(endPoint);
            HttpResponse response = http.send(request);
            if (response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' +
                        response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
            }
        }
    }
}