public with sharing class QueryGeneratorController {
    @AuraEnabled(cacheable = true)
    Public static list<sObject> getAllObjects(){
        List<sObject> objList = [SELECT sObjectType FROM ObjectPermissions GROUP BY sObjectType ORDER BY sObjectType];
        return objList;
    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> executeSOQLQuery(String soqlQuery) {
        try {
            return Database.query(soqlQuery);
        } catch (Exception e) {
            System.debug('Error executing SOQL query: ' + e.getMessage());
            return new List<SObject>();
        }
    }
}