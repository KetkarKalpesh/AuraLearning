@isTest
Private class TestStudentHandlerClass {
	@isTest
    Private Static void testStudentHandlerClassMethod(){
        List<Student__c> stdList = new List<Student__c>();
        
        Institute__c inst = new Institute__c(Name = 'Institute');
        Insert inst;
        
        Mentor__c ment = new Mentor__c(Name = 'Menor', Institute__c = inst.Id);
        Insert ment;
        
        For(Integer i=1; i<5; i++){
            Student__c std = new Student__c();
            std.Mentor__c = ment.Id;
            std.Aadhar_Number__c = '123456';
            std.City__c = 'City';
            std.Name = 'Name ' + i;
            std.Landmark__c = 'LandMark';
            std.Pin_Code__c = '444444';
            std.State__c = 'State';
            stdList.add(std);
        }
        Insert stdList;
        
        List<Student__c> updatedStudents = new List<Student__c>();
        for (Student__c student : stdList) {
            Student__c updatedStudent = new Student__c(Id = student.Id);
            updatedStudent.Name = 'Updated Value';
            updatedStudents.add(updatedStudent);
        }
        update updatedStudents;
        
        List<Id> studentIds = new List<Id>();
        for (Student__c student : stdList) {
            studentIds.add(student.Id);
        }
        
        List<Student_History__c> studentHistoryList = [SELECT Field_Name__c, Old_Value__c, New_Value__c, Record_Id__c FROM Student_History__c WHERE Record_Id__c IN: studentIds];
        System.assertEquals(stdList.size(), studentHistoryList.size(), 'Number of Student_History__c records should be equal to the number of updated Student records.');

        for (Student_History__c historyRecord : studentHistoryList) {
            System.assertNotEquals(null, historyRecord.Field_Name__c, 'Field_Name__c should not be null.');
            System.assertNotEquals(null, historyRecord.Old_Value__c, 'Old_Value__c should not be null.');
            System.assertNotEquals(null, historyRecord.New_Value__c, 'New_Value__c should not be null.');
            System.assertNotEquals(null, historyRecord.Record_Id__c, 'Record_Id__c should not be null.');
    }
}
}