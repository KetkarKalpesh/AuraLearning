import { LightningElement, wire, track } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import getAllObjects from '@salesforce/apex/QueryGeneratorController.getAllObjects';
import executeSOQLQuery from '@salesforce/apex/QueryGeneratorController.executeSOQLQuery';

export default class QueryGenerator extends LightningElement {

    @track objValue;
    @track fieldValue;
    @track objectOptions = [];
    @track fieldOptions = [];
    @track generatedQuery;
    @track data;
    @track columns;
    showDualListBox = false;
    showButton = false;
    showTextArea = false;
    showDataTable = false;
    showTable = false;
    
    


    @wire (getAllObjects)
    wiredData({error, data}){
        if(data){
            //console.log('data: ', data)
            data.map( item => {
                this.objectOptions = [...this.objectOptions,{label : item.SobjectType, value : item.SobjectType}];
            })
        }
        else if(error){
            console.log('error: ', error)
        }
    }

    handleObjectChange(event){
        this.objValue = event.target.value;
        this.fieldValue = '';
        this.fieldOptions = [];
        this.showDualListBox = true;
        this.showButton = false;
        this.showTextArea = false;
    }

    @wire (getObjectInfo, { objectApiName: '$objValue' })
    wiredFieldValues({error, data}){
        if(data){
            this.fieldValue = '';
            //console.log('data: ', data);
            //console.log('Field Value: ', this.fieldValue);
            
            for(let i in data.fields){
                //console.log('Item is: ' + JSON.stringify(data.fields[i]));
                this.fieldOptions = [...this.fieldOptions,{label:data.fields[i].label, value:data.fields[i].apiName}];
            }
        }
        else if(error){
            console.log('error: ', error);
        }
    }

    handleFieldChange(event){
        this.fieldValue = event.target.value;
        //console.log('Selected Value: ' + this.fieldValue);
        this.showButton = true;
        this.showTextArea = false;
        this.showDataTableButton = false;
        this.showDataTable = false;
    }

    handleQueryClick(event){
        this.generatedQuery = 'SELECT ' + this.fieldValue + ' FROM ' + this.objValue;
        this.showTextArea = true;
        this.showDataTableButton = true;
    }

    handleTableClick(event){
        this.showDataTable = true;
    
        executeSOQLQuery({ soqlQuery: this.generatedQuery })
            .then(result => {
                this.data = result; // Assign the result data to the 'data' property
                this.columns = this.extractColumns(result); // Extract columns dynamically based on data
                this.showDataTable = true; // Show the datatable after receiving the data
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }

    // Method to extract columns dynamically based on data fields
    extractColumns(data) {
        if (!data || data.length === 0) {
            return [];
        }

        // Assuming the data contains SObject records and all records have the same fields
        return Object.keys(data[0]).map(field => ({
            label: field,
            fieldName: field,
            type: 'text',
        }));
    }

}