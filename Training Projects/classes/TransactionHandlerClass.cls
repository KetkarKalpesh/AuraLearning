public class TransactionHandlerClass {
    public static void TransactionHandlerMethod(List<Transacton__c> transList, Map<Id, Transacton__c> transOldMap) {
        List<Transacton_History__c> ListToUpdate = new List<Transacton_History__c>();

        for (Transacton__c trnNew : transList) {
            Transacton__c trnOld = transOldMap.get(trnNew.Id);

            Schema.SObjectType TrnObjectType = Transacton__c.SObjectType;
            Map<String, Schema.SObjectField> fieldMap = TrnObjectType.getDescribe().fields.getMap();

            for (String fieldName : fieldMap.keySet()) {
                // Skip SystemModstamp and LastModifiedDate fields
                if (fieldName == 'SystemModstamp' || fieldName == 'LastModifiedDate') {
                    continue;
                }

                Object oldValue = trnOld.get(fieldName);
                Object newValue = trnNew.get(fieldName);

                if (oldValue == newValue || (oldValue != null && oldValue.equals(newValue))) {
                    continue;
                }

                Transacton_History__c trnHistory = new Transacton_History__c();
                trnHistory.Name = fieldName;
                trnHistory.Record_Id__c = trnNew.Id;
                trnHistory.Old_Value__c = String.valueOf(oldValue);
                trnHistory.New_Value__c = String.valueOf(newValue);
                ListToUpdate.add(trnHistory);
            }
        }
        if (!ListToUpdate.isEmpty()) {
            insert ListToUpdate;
        }
    }
}