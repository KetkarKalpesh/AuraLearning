import { LightningElement, wire } from 'lwc';
import getAccountWithContact from '@salesforce/apex/AccountWrapperDemo.getAccountWithContact';
import getAccountWithOpportunity from '@salesforce/apex/AccountWrapperOpportunity.getAccountWithOpportunity';

export default class WrapperComponent extends LightningElement {
    @wire(getAccountWithContact) wrapperList;

    @wire(getAccountWithOpportunity) warpperListAccOpp;
}