@isTest
private class DeleteStudentBatchClassTest {
	@isTest
    Private static void deleteStudentBatchClassTestMethod(){
        List<Student__c> stdList = new List<Student__c>();
        Institute__c Inst = new Institute__c(Name='Institute');
        Insert Inst;
        Mentor__c ment = new Mentor__c(Name='Mentor', Institute__c = Inst.Id);
        Insert ment;
        
        For(integer i=0; i<5; i++){
            Student__c std = new Student__c();
            std.Name = 'Name' + i;
            std.Mark_For_Delete__c = 'Yes';
            std.Mentor__c = ment.Id;
            stdList.add(std);
        }
        insert stdList;
        
        test.startTest();
        DeleteStudentBatchClass deleteStdBatch = new DeleteStudentBatchClass();
        Database.executeBatch(deleteStdBatch);
        test.stopTest();
        
        List<Student__c> remainingStudents = [SELECT Id, Name FROM Student__c WHERE Mark_For_Delete__c = 'Yes'];
        System.assertEquals(0, remainingStudents.size(), 'All students marked for delete should have been deleted');
    }
}