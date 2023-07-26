@isTest
Private class StudentBatchClassTest {
	@isTest
    Private static void studentBatchClass(){
        List<Student__c> stdList = new List<Student__c>();
        Institute__c inst = new Institute__c(Name='Test');
        Insert inst;
        Mentor__c ment = new Mentor__c(Name='Test', Institute__c = inst.Id);
        Insert ment;
        For(Integer i=0; i<5; i++){
            Student__c std = new Student__c();
            std.Name = 'Test';
            std.Mentor__c = ment.Id;
            
            stdList.add(std);
        }
    }
}