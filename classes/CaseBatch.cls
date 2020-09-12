public with sharing class CaseBatch implements Database.Batchable<SObject> {   
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, TripId__c, AccountId FROM Case WHERE AccountId=null AND Status!=\'Closed\' AND TripId__c!=null');
    }
    public void execute(Database.BatchableContext context, List<Case> scope) {
        if (!scope.isEmpty()) {
            List<String> tripIds = new List<String>();
            //since variable binding in SOQLs in case of records lists works only for Id`s, we had to use this iterations.
            for (Case cs:scope){
                tripIds.add(cs.TripId__c);
            }            
            List<Order> orders = [SELECT Id, TripId__c, AccountId FROM Order WHERE TripId__c IN:tripIds AND AccountId!=null];
            Map<String, Id> tripsMap = new Map<String, Id>();
            for (Order ord:orders) {
                tripsMap.put(ord.TripId__c, ord.AccountId);
            }
            for (Case cs:scope) {
                cs.AccountId = tripsMap.get(cs.TripId__c);
            }
            update scope;
        }
    }
    public void finish(Database.BatchableContext info) {

    }
}
