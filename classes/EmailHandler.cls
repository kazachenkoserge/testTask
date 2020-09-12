global class EmailHandler implements Messaging.InboundEmailHandler {
public EmailHandler() {

}
/**
 * Implements handleInboundEmail method from InboundEmailHandler interface.
 * @param email 
 * @param envelope 
 * @returns `Messaging.InboundEmailResult`
 */
global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    try {
        if (Schema.SObjectType.Case.fields.Subject.isCreateable()&&Schema.SObjectType.Case.fields.SuppliedEmail.isCreateable()) {
            Case newCase = new Case(Subject = email.subject, SuppliedEmail = envelope.fromAddress, TripId__c = email.plainTextBody==null?getTripId(email.htmlBody):getTripId(email.plainTextBody));
            insert newCase;
        }
    } catch (Exception e) {
        System.debug('Exception in EmailHandler.handleInboundEmail ');
        System.debug(e.getLineNumber());
        System.debug(e.getMessage());
        result.success=false;
        return result;
    }
    result.success = true;
	return result;
}
/**
 * Searchs for TripId in an email body. 
 * @param emailBody Email body as String
 * @returns `String` Returns TripId if found. Null otherwise. 
 */
private static String getTripId(String emailBody) {
    try {
        Pattern regexPattern = Pattern.compile('(\\[)(T#)[0-9]{5}(\\])');
        Matcher tripIdMatcher = regexPattern.matcher(emailBody);
        if (tripIdMatcher.find()) return emailBody.substring(tripIdMatcher.start(), tripIdMatcher.end());
        else return null;
    } catch (Exception e) {
        System.debug('Exception in EmailHandler.getTripId ');
        System.debug(e.getLineNumber());
        System.debug(e.getMessage());
        return null;
    }
}
}
