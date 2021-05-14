@restResource(urlMapping='/caseManagement/*')
global class caseRecord {

    //Guna added the comment.
    //on 5/15/2021
    
    @httpPost
    global static case caseCreation(){
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        string jsonInput = req.requestBody.toString();
        Map<String, Object> root = (Map<string, Object>)JSON.deserializeUntyped(jsonInput);
        case obj = new case();
        obj.origin = (string)root.get('Origin');
        obj.subject = (string)root.get('subject');
        insert obj;
        
        case newCase = [select id, caseNumber, subject,createddate from case where id = :obj.id];
        
        return newCase;
    }
    
    @httpGet
    global static list<case> returnCase(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        string Inq_Id = '';
        List<case> record;
        Inq_Id = req.requestURI.substring(req.requesturi.lastIndexOf('/')+1);
        
        if(Inq_Id != null && Inq_Id != ''){
            record = [select id, caseNumber, subject,createddate from case where id = :Inq_Id];
         }
        else{
            record = [select id, caseNumber, subject,createddate from case order by createdDate limit 10];
           }
        return record;
    }
}