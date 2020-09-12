@IsTest
public with sharing class EmailHandlerTest {
    public EmailHandlerTest() {

    }
    @TestSetup
    static void makeData(){
        //dont really like this fancy TestDataFactory
        Account acc = new Account (Name='test');
        insert acc;
        Order ord = new Order(Name = 'test', Status = 'Draft', TripId__c='[T#12345]', AccountId  = acc.Id, EffectiveDate = Date.today());
        insert ord;
    }
    @IsTest
    public static void testEmailHandler(){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'test';
        email.plainTextBody = '[T#12345]';
        envelope.fromAddress = 'test@test.com';        
        System.assert(new EmailHandler().handleInboundEmail(email, envelope).success);
    }
    @IsTest
    public static void testEmailHandlerErorr(){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'test';
        email.plainTextBody = null;
        envelope.fromAddress = 'test@test.com';        
        System.assert(new EmailHandler().handleInboundEmail(email, envelope).success);
    }
    @IsTest
    public static void testTrigger() {
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();

        email.subject = 'test';
        email.plainTextBody = '[T#12345]';
        envelope.fromAddress = 'test@test.com';        
        System.assert(new EmailHandler().handleInboundEmail(email, envelope).success);
    }
}
