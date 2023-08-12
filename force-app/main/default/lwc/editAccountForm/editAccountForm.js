import { LightningElement, api } from 'lwc';

export default class EditAccountForm extends LightningElement {
    @api recordId;

    handleSubmit(event) {
        event.preventDefault();
        this.template.querySelector('lightning-record-edit-form').submit();
    }
}
