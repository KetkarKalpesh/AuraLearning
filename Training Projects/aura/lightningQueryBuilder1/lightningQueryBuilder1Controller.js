({
    init : function(component, event, helper) {
        const options =[];
        const action= component.get("c.getAllObjects");
        action.setCallback(this,function(response){
            const state =response.getState();
            
            if(state ==="SUCCESS"){
                const allvalues=response.getReturnValue();
                console.log(allvalues);
                allvalues.forEach((value,i)=>{
                    var Item ={
                    "label": value,
                    "value": value
                }
                options.push(Item);
            })
            component.set("v.options",options)
        }
                           
                           });
        $A.enqueueAction(action);
    },
    handelchangeValues : function(component,event,handler){
        const fields =[]
        var selectedOptionValue = event.getParam("value");
        component.set("v.objName",selectedOptionValue);
        console.log('click')
        const action =  component.get("c.getAllFields");
        action.setParams({
            obj:selectedOptionValue
            
        })
        action.setCallback(this,function(response){
            const state = response.getState();
            console.log(state)
            if(state ==="SUCCESS"){
                const allvalues=response.getReturnValue();
                console.log(allvalues);
                allvalues.forEach((value,i)=>{
                    var Item ={
                    "label": value,
                    "value": value
                }
                fields.push(Item);
            })
            component.set("v.fields",fields)
            var listfield = component.get("v.fields");
            component.set("v.values",listfield);
        }
                           });
        
        $A.enqueueAction(action);
        
    },
    
    handleChange :function(component,event,helper){
        var selectedOptionValue = event.getParam("value");
        var selectedlist = component.set("v.selectedList",selectedOptionValue.toString() + "");
        var getvalue = component.get("v.selectedList");
        component.set("v.selectedFields", selectedOptionValue.join(", "));
    },
    
    genQuery : function (component, event, helper) {
        var objtName = component.get("v.objName");  
        var SelectId = component.get("v.options");   
        var makequery = component.get("v.selectedList");
        var querymaker = 'SELECT '+ makequery +' From '+ objtName; 
        console.log(querymaker);
        component.set("v.queryString",querymaker);  
    },
    
    fetchRecords : function(component, event, helper){    
        var action2 = component.get("c.queryRecord");
        var records;
        
        action2.setParams({
            records : component.get("v.queryString")
        });
        console.log(records)
        
        action2.setCallback(this, function(response){
            var state = response.getState();      
            if (state === "SUCCESS") { 
                var result = response.getReturnValue();
                
                console.log(response.getReturnValue())
                if(result != null)
                {    
                    component.set("v.listRecords", result); 
                    
                    if (result.length > 0) {
                        var columns = [];
                        var record = result[0];
                        for (var key in record) {
                            if (record.hasOwnProperty(key)) {
                                var column = {
                                    label: key,  // Use field API name as the column label
                                    fieldName: key,
                                    type: typeof record[key] === "number" ? "number" : "text"
                                };
                                columns.push(column);
                            }
                        }
                        component.set("v.columns", columns);
                    } 
                }
            }
        });
        
        $A.enqueueAction(action2);
    }
})