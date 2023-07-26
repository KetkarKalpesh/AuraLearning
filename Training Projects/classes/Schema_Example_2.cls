public class Schema_Example_2 {
    Public List<String> fields {set;get;}
    public Schema_Example_2(){
        //Schema.SobjectType = This will return sObjects And Their Properties
        //Schema.sObjectField = This will return sObjects And Their Fields
        
        //Fetch the Properties of a Object
        Schema.DescribeSObjectResult result = Student__c.sObjectType.getDescribe();
        //create a Map with FieldName as key and Field As Value
        //In Description of the Object we Have fields Attribute
        Map<String, Schema.SObjectField> fieldMap = result.fields.getMap();
        Set<String> keys = fieldMap.keySet();
        fields = new List<string>(keys);
    }
}