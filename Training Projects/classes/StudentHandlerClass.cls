/*public class StudentHandlerClass {
    Public static void StudentHandlerMethod(List<Student__c> StdList, Map<Id, Student__c> OldStdMap){
        
    List<Student_History__c> UpdateStudentList = new List<Student_History__c>();
    Map<String, Schema.SObjectField> NewStdMap = Student__c.SObjectType.getDescribe().fields.getMap();
        
        for (Student__c newStudent : StdList) {
        Student__c oldStudent = OldStdMap.get(newStudent.Id);

        for (String fieldName : NewStdMap.keySet()) {
            if (NewStdMap.get(fieldName).getDescribe().isCustom()) {
                Object oldValue = oldStudent.get(fieldName);
                Object newValue = newStudent.get(fieldName);
                if (!oldValue.equals(newValue)) {
                    Student_History__c historyRecord = new Student_History__c();
                    historyRecord.Field_Name__c = NewStdMap.get(fieldName).getDescribe().getLabel();
                    historyRecord.Old_Value__c = String.valueOf(oldValue);
                    historyRecord.New_Value__c = String.valueOf(newValue);
                    historyRecord.Record_Id__c = newStudent.Id;
                    UpdateStudentList.add(historyRecord);
                }
            }
        }
    }

    if (!UpdateStudentList.isEmpty()) {
        INSERT UpdateStudentList;
    }
            
   }
}*/


/*public class StudentHandlerClass {
    public static void StudentHandlerMethod(List<Student__c> newStudents, Map<Id, Student__c> oldStudentsMap) {
        // List to hold Student_History__c records to be inserted
        List<Student_History__c> studentHistoryList = new List<Student_History__c>();

        // Get the object's field details using Metadata API
        Map<String, Schema.SObjectField> fieldMap = Student__c.SObjectType.getDescribe().fields.getMap();

        for (Student__c newStudent : newStudents) {
            Student__c oldStudent = oldStudentsMap.get(newStudent.Id);

            for (String fieldName : fieldMap.keySet()) {
                // Check if the field is a custom field (not standard Salesforce field)
                if (fieldMap.get(fieldName).getDescribe().isCustom()) {
                    // Compare old and new values for custom fields
                    Object oldValue = oldStudent != null ? oldStudent.get(fieldName) : null;
                    Object newValue = newStudent.get(fieldName);

                    // If the value has changed, create a new Student_History__c record
                    
                        Student_History__c historyRecord = new Student_History__c();
                        historyRecord.Field_Name__c = fieldMap.get(fieldName).getDescribe().getLabel();
                        historyRecord.Old_Value__c = String.valueOf(oldValue);
                        historyRecord.New_Value__c = String.valueOf(newValue);
                        historyRecord.Record_Id__c = newStudent.Id;
                        studentHistoryList.add(historyRecord);
                    
                }
            }
        }

        // Insert the Student_History__c records
        if (!studentHistoryList.isEmpty())
            insert studentHistoryList;
    }
}*/

public class StudentHandlerClass {
    public static void StudentHandlerMethod(List<Student__c> newStudents, Map<Id, Student__c> oldStudentsMap) {
        // List to hold Student_History__c records to be inserted
        List<Student_History__c> studentHistoryList = new List<Student_History__c>();
        //system.debug(studentHistoryList);

        // Get the object's field details using Metadata API
        Map<String, Schema.SObjectField> fieldMap = Student__c.SObjectType.getDescribe().fields.getMap();
        //system.debug(fieldMap);

        for (Student__c newStudent : newStudents) {
            Student__c oldStudent = oldStudentsMap.get(newStudent.Id);
            //system.debug(newStudent);
            //system.debug(oldStudent);

            for (String fieldName : fieldMap.keySet()) {
                // Check if the field is a custom field (not standard Salesforce field)
                    // Compare old and new values for custom fields
                    Object oldValue = oldStudent != null ? oldStudent.get(fieldName) : null;
                    Object newValue = newStudent.get(fieldName);
                    //system.debug(fieldName);

                    // If the value has changed, create a new Student_History__c record
                    if ((oldValue == null && newValue != null) || (oldValue != null && !oldValue.equals(newValue))) {
                        Student_History__c historyRecord = new Student_History__c();
                        historyRecord.Field_Name__c = fieldMap.get(fieldName).getDescribe().getLabel();
                        historyRecord.Old_Value__c = String.valueOf(oldValue);
                        historyRecord.New_Value__c = String.valueOf(newValue);
                        historyRecord.Record_Id__c = newStudent.Id;
                        studentHistoryList.add(historyRecord);
                        //system.debug(historyRecord);
                    }
            }
        }

        // Insert the Student_History__c records
        if (!studentHistoryList.isEmpty()) {
            insert studentHistoryList;
            //system.debug(studentHistoryList);
            //system.debug(studentHistoryList.size());
        }
    }
}

/*public class StudentHandlerClass {
    public static void StudentHandlerMethod(List<Student__c> newStudents, Map<Id, Student__c> oldStudentsMap) {
	List<Student_History__c> stdHistoryUpdate = new List<Student_History__c>();
        For(Student__c newStudent : newStudents){
            Student__c oldStudent = oldStudentsMap.get(newStudent.Id);
            system.debug('newStudent: ' + newStudent);
            system.debug('oldStudent: ' + oldStudent);
        
        For(Schema.SObjectField sObjFields : SObjectType.Student__c.fields.getMap().values()){
            String fieldName = String.valueOf(sObjFields);
            Object oldValue = oldStudent.get(fieldName);
            Object newValue = newStudent.get(fieldName);
            
            
            if (oldValue == newValue) {
                continue;
            }
            
            Student_History__c studHistory = new Student_History__c();
            studHistory.Record_Id__c = newStudent.Id;
            studHistory.name = fieldName;
            studHistory.Old_Value__c = String.valueOf(oldValue);
            studHistory.New_Value__c = String.valueOf(newValue);
            
            stdHistoryUpdate.add(studHistory);
        }
    }
    
   
    if (!stdHistoryUpdate.isEmpty()) {
        insert stdHistoryUpdate;
    }

        }
}*/