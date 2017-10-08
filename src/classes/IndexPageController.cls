public class IndexPageController {
    
    public  PageReference restClassic(){
        return Page.RestClassicPage;
    }
    
    public PageReference soapClassic(){
        return Page.SOAPClassicPage;
    }
    
    public PageReference restLightning(){
        String url = 'https://gorinshteyn-dev-ed.lightning.force.com/c/RestLightning.app';
        PageReference page = new PageReference(url);
        page.setRedirect(true);
        return page;
    }

    public PageReference soapLightning(){
        String url = 'https://gorinshteyn-dev-ed.lightning.force.com/c/SoapLightning.app';
        PageReference page = new PageReference(url);
        page.setRedirect(true);
        return page;
    }
}