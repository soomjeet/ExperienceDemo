/**
 * @description       : 
 * @author            : soomjeet.sahoo
 * @group             : $groupname
 * @last modified on  : 10-08-2023
 * @last modified by  : soomjeet.sahoo
**/
public with sharing class PortfolioProfileController {

    private static final string EDUCATIONAL_INSTITUTION_RECORDTYPE_DEVELOPERNAME = 'Educational_Institutions';
    private static final string EMPLOYERS_RECORDTYPE_DEVELOPERNAME = 'Employers';
    private static final string PP_FIELD_SET_NAME = 'pp_Field_Set';
    private static final string ACCOUNT_API_NAME = Account.sObjectType.getDescribe().getName();
    private static final List<Id> ACCOUNT_RT_IDS = new List<Id>{ 
        Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(EDUCATIONAL_INSTITUTION_RECORDTYPE_DEVELOPERNAME).getRecordTypeId(),
        Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(EMPLOYERS_RECORDTYPE_DEVELOPERNAME).getRecordTypeId()
    };

    @AuraEnabled
    public static List<ExperienceComponentWrapperAccount> getExperiences(){
        List<ExperienceComponentWrapperAccount> expAccountsWrapperList = new List<ExperienceComponentWrapperAccount>(); 
        try {
            String accountGetQuery = 'SELECT '+PortfolioProfileControllerUtil.getAllFieldsFromFS(PP_FIELD_SET_NAME, ACCOUNT_API_NAME)+' FROM '+ACCOUNT_API_NAME+' WHERE RecordTypeId IN: ACCOUNT_RT_IDS';
            System.debug('accountGetQuery >> '+accountGetQuery);
            for (Account acct : Database.query(accountGetQuery, AccessLevel.SYSTEM_MODE)) {
                ExperienceComponentWrapperAccount ecWrapRec = new ExperienceComponentWrapperAccount();
                ecWrapRec.name = acct.Name;
                expAccountsWrapperList.add(ecWrapRec);
            }
        } catch (Exception exp) {
            // throw new AuraHandledException(e.getMessage());
            System.debug(exp.getStackTraceString());
            return new List<ExperienceComponentWrapperAccount>();
        }
        
        return expAccountsWrapperList;
    }



    public class ExperienceComponentWrapperAccount{
        @AuraEnabled public String name;
        @AuraEnabled public String recordTypeName;
        @AuraEnabled public String roleName;
        @AuraEnabled public String workDescription;
        @AuraEnabled public String priorityOrder;
        @AuraEnabled public String isCurrentOrg;
        @AuraEnabled public String yearRange;
    }
}