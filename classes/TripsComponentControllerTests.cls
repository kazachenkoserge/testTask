@IsTest
public with sharing class TripsComponentControllerTests {
    public TripsComponentControllerTests() {

    }
    @TestSetup
    static void makeData(){
        Account acc = new Account(Name = 'test');
        insert acc;
        Order ord = new Order(Name = 'test', Status = 'Draft', TripId__c='[T#12345]', AccountId  = acc.Id, EffectiveDate = Date.today());
        insert ord;
        Case cse = new Case(Subject='test', Trip__c = ord.Id);
        insert cse;        
    }
    @IsTest
    static void testGetTrips() {
        Id cs = [SELECT Id FROM Case LIMIT 1].Id;
        System.assert(TripsComponentController.getTrips(cs)!=null);
    }
    @IsTest
    static void testGetTripsFail() {
        Id cs = [SELECT Id FROM Case LIMIT 1].Id;
        System.assert(TripsComponentController.getTrips(null)==null);
    }
}
