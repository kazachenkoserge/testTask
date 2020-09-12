public with sharing class TripsComponentController {
    public TripsComponentController() {

    }
    /**
     * Queries all Orders related to given Case and returns them as a list of datatable rows.
     * @param caseId Case Id
     * @returns `List<TripWrapper>`
     */
    @AuraEnabled
    public static List<TripWrapper> getTrips(Id caseId) {
        try {
            List<Order> orders =[SELECT Id, TripId__c, Account.Name FROM Order WHERE Id IN (SELECT Trip__c FROM Case WHERE Id =:caseId)];
            if (!orders.isEmpty()) {
                List<TripWrapper> returnList = new List<TripWrapper>();
                for (Order order:orders) returnList.add(new TripWrapper(order));
                return returnList;
            } else return null;
        } catch (Exception e) {
            System.debug('Exception in TripsComponentController.getTrips');
            System.debug(e.getLineNumber());
            System.debug(e.getMessage());
            return null;
        }
    }
    public class TripWrapper {
        @AuraEnabled
        public String tripId;
        @AuraEnabled
        public String clientName;
        public TripWrapper(Order trip) {
            this.clientName = trip.Account.Name;
            this.tripId = trip.TripId__c;
        }
        
    }
}
