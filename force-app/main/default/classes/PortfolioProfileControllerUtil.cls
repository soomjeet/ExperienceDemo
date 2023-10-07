public with sharing class PortfolioProfileControllerUtil {
    public static String getAllFieldsFromFS(String fSName, String objName){
        String commaSeparatedFieldApiNames = '';
        for(Schema.FieldSetMember fsMem : getFSetMembersFromFSName(fSName,objName)){
            commaSeparatedFieldApiNames = commaSeparatedFieldApiNames+fsMem.getFieldPath()+',';
        }
        return commaSeparatedFieldApiNames.removeEnd(',');
    }

    private static List<Schema.FieldSetMember> getFSetMembersFromFSName(String fSName, String objName){
        List<Schema.FieldSetMember> opFSMs = new List<Schema.FieldSetMember>();
        if(!String.isBlank(fSName) && !String.isBlank(objName)){
            Map<String, Schema.SObjectType> describeMapGlobal = Schema.getGlobalDescribe(); 
            Schema.SObjectType typeObj = describeMapGlobal.get(objName);
            Schema.DescribeSObjectResult describeSobjectRes = typeObj.getDescribe();
            Schema.FieldSet fieldSetObj = describeSobjectRes.FieldSets.getMap().get(fSName); 
            opFSMs = fieldSetObj.getFields();
        }
        return opFSMs; 
    } 

}