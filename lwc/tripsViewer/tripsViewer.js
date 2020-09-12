import { LightningElement, api, track } from 'lwc';
import "@salesforce/apex/TripsComponentController.getTrips";
import getTrips from '@salesforce/apex/TripsComponentController.getTrips';
export default class TripsViewer extends LightningElement {
    @track tripsLoaded=false;
    @track data;
    @track columns = [
        {
            label: 'Trip Id',
            fieldName : 'tripId'
        },
        {
            label: 'Client name',
            fieldName : 'clientName'
        }
    ]
    @api
    set recordId(recordId) {
        //Yes, I know about @wire. But I preffer to proceed data on backend. 
        if (console.log!=null) {
            getTrips({'caseId':recordId}).then(result=>{
                if (result!=null&&result.length>0) {
                    this.data=result;
                    this.tripsLoaded = true;
                }
            }).catch(error=>{
                console.log('Error in Trips component');
                console.log(error.message)
            });
        }
    }
    get recordId(){
        return null;
    }
}