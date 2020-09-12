trigger CaseTrigger on Case (before insert) {
	Boolean safety = true; // safety switch. If true, trigger goes live.
	if (safety) {
		try {
			for (Case newCase:trigger.new) {
				if (newCase.TripId__c!=null) {
					List<Order> trips = [SELECT Id, AccountId, TripId__c FROM Order WHERE TripId__c=:newCase.TripId__c];
                    if (!trips.isEmpty()) {
                        newCase.AccountId = trips[0].AccountId;
                        newCase.Trip__c = trips[0].Id;                        
                    }
				}
			}
		} catch (Exception e) {
			System.debug('Exception in trigger CaseTrigger');
			System.debug(e.getLineNumber());
			System.debug(e.getMessage());
			for (Case newCase:trigger.new) {
				newCase.addError('Exception in trigger. Check logs for details.');
			}
		}
	}
}