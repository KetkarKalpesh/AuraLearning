public class StudentBatchClass implements Database.Batchable<sObject>{
	//start, execute & Finish
    List<String> EmailAddress {get;set;} //Important {get; set;}
	//start = Query Recs Where Is_Regestration_Completed__c = False AND CreatedDate < LAST_N_DAYS:2
    Public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Name, CreatedDate FROM Student__c WHERE Is_Regestration_Completed__c = False AND CreatedDate < LAST_N_DAYS: 2');
    }
    //execute = Update Mark_For_Delete__c = true
    Public void execute(Database.BatchableContext bc, List<Student__c> StdList){
        EmailAddress = new list<string>();
        For(Student__c std : StdList){
            EmailAddress.add(std.CreatedBy.Email);
            std.Mark_For_Delete__c = 'Yes';
        }
        UPDATE StdList;
    }
    //Finish = Send Email to CreatedByUser
    Public void finish(Database.BatchableContext bc){
        list<Messaging.SingleEmailMessage> emailObjs = new list<Messaging.SingleEmailMessage>();
        messaging.SingleEmailMessage EmailObj = new messaging.SingleEmailMessage();
        EmailObj.setToAddresses(EmailAddress);
        EmailObj.setSubject('');
        EmailObj.setPlainTextBody('Few of the students are marked to be deleted.');
        emailObjs.add(EmailObj);
        If(emailObjs.size()>0){
            Messaging.sendEmail(emailObjs);
        }
    }
}