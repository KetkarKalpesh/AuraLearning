trigger StudentHandlerTrigger on Student__c (After Update) {
    If(trigger.isAfter && trigger.isUpdate){
        StudentHandlerClass.StudentHandlerMethod(trigger.new, trigger.OldMap);
    }
}