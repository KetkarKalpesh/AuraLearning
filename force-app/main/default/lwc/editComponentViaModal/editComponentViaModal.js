import { LightningElement, track, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import getAccounts from '@salesforce/apex/AccountFetchController.getAccounts';
const DELAY = 1200;
const actions = [
    { label: 'Edit Account', name: 'edit' },
    { label: 'View Account', name: 'view' },
    // { label: 'Delete Account', name: 'delete' }
];

export default class EditComponentViaModal extends NavigationMixin(LightningElement) {
    @track data = [];
    columns = [
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        {
            type: 'action',
            typeAttributes: { rowActions: actions },
        },
    ];

    // columns = [
    //     { label: 'Account Name', fieldName: 'Name', type: 'text' },
    //     {
    //         type: 'button', label:'Actions', initialWidth: 250, typeAttributes: {
    //             iconName: 'utility:add',
    //             variant: 'border-filled',
    //             alternativeText: 'View Actions',
    //             name: 'actions',
    //             title: 'View Actions',
    //             rowActions: ROW_ACTIONS
    //         }
    //     }
    // ];

    @track searchState = false;
    @track showInput = false;
    @track showInputField = false;
    @track dataLoading = false;
    buttonLabel = 'Show Input';
    @track accountName = '';
    @track showEditModal = false;
    @track selectedRecordId;
    @track showEditModal = false;
    @track selectedRecordId;

    toggleVisibility() {
        this.searchState = !this.searchState;
        this.buttonLabel = this.searchState ? 'Hide Input' : 'Show Input';
        this.showInput = this.searchState;
        this.showInputField = false;
        this.showEditModal = false;
        this.data = [];
    }

    handleInputChange(event) {
        const accountName = event.target.value;
        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(() => {
            this.accountName = accountName;
            this.fetchData();
        }, DELAY);
    }

    fetchData() {
        if (this.accountName) {
            this.dataLoading = true;
            getAccounts({ AccName: this.accountName })
                .then((result) => {
                    this.data = result;
                    this.showInputField = this.data.length > 0;
                    this.dataLoading = false;
                })
                .catch((error) => {
                    console.error('error: ', error);
                    this.dataLoading = false;
                });
        } else {
            this.data = [];
            this.showInputField = false;
        }
    }

    handleRowAction(event) {
        if (event.detail.action.name === "edit") {
                this[NavigationMixin.Navigate]({
                    type: "standard__recordPage",
                    attributes: {
                    recordId: event.detail.row.Id,
                    actionName: "edit"
                 }
            });
        }
        else if (event.detail.action.name === "view") {
            this[NavigationMixin.Navigate]({
                type: "standard__recordPage",
                attributes: {
                recordId: event.detail.row.Id,
                actionName: "view"
             }
        });
        }
    }

    // handleRowAction(event) {
    //     const actionName = event.detail.action.name;
    //     const row = event.detail.row;
    //     if (actionName === 'actions') {
    //         // Handle dropdown arrow click, you can show a dropdown or directly trigger 'Edit' here
    //     } else if (actionName === 'edit') {
    //         this.selectedRecordId = row.Id;
    //         this[NavigationMixin.Navigate]({
    //                 type: "standard__recordPage",
    //                 attributes: {
    //                 recordId: event.detail.row.Id,
    //                 actionName: "edit"
    //              }
    //         });
    //     }
    // }

    // navigateToEditAccountPage() {
    //     this[NavigationMixin.Navigate]({
    //         type: 'standard__recordPage',
    //         attributes: {
    //             recordId: this.selectedRecordId,
    //             objectApiName: 'Account',
    //         }
    //     });
    // }

}
