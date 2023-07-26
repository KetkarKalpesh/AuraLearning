public class DeleteStudentBatchClass implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Name FROM Student__c WHERE Mark_For_Delete__c = 'Yes']);                              
    }
    Public void execute(Database.BatchableContext bc, List<Student__c> StdList){
        
            DELETE StdList;
        
    }
    Public void finish(Database.BatchableContext bc){
        
    }
}