({
	getData : function(component, event, helper) {
		var action = component.get("c.getAllObject");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS" || state === "DRAFT"){
                var result = response.getReturnValue();
                var listofObjects = [];
                for(var key in result){
                    listofObjects.push({key: key, value: result[key]});
                }
                component.set("v.allObject", listofObjects);
            }
            else if(status === "INCOMPLETE"){
                console.log("No responce");
            }
                else if(status === "ERROR"){
                    if(errors){
                        if(errors[0] && errors[0].message);
                    }
                }
                    else{
                        console.log("Unkonown Error");
                    }
        });
        $A.enqueueAction(action);
	},
})