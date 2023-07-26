trigger TransactionTrigger on Transacton__c (After Update) {
    If(trigger.isAfter && trigger.isUpdate){
        TransactionHandlerClass.TransactionHandlerMethod(trigger.new, trigger.oldMap);
    }
}