public with sharing class AccountFetchController {
    @AuraEnabled(cacheable=true)
    Public static List<Account> getAccounts(string AccName){
        string keyString = '%' + AccName + '%';
        return [SELECT Id, Name FROM Account WHERE Name LIKE: keyString];
    }
}