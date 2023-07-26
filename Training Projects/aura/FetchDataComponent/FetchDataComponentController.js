({
    getVal: function(component, event, helper) {
        //helper.getData(component, event, helper);
        var action = component.get("c.getAllObject");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.allObject", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})