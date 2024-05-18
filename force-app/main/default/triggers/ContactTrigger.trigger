/**
 * ContactTrigger Trigger Description:
 * 
 * The ContactTrigger is designed to handle various logic upon the insertion and update of Contact records in Salesforce. 
 * 
 * Key Behaviors:
 * 1. When a new Contact is inserted and doesn't have a value for the DummyJSON_Id__c field, the trigger generates a random number between 0 and 100 for it.
 * 2. Upon insertion, if the generated or provided DummyJSON_Id__c value is less than or equal to 100, the trigger initiates the getDummyJSONUserFromId API call.
 * 3. If a Contact record is updated and the DummyJSON_Id__c value is greater than 100, the trigger initiates the postCreateDummyJSONUser API call.
 * 
 * Best Practices for Callouts in Triggers:
 * 
 * 1. Avoid Direct Callouts: Triggers do not support direct HTTP callouts. Instead, use asynchronous methods like @future or Queueable to make the callout.
 * 2. Bulkify Logic: Ensure that the trigger logic is bulkified so that it can handle multiple records efficiently without hitting governor limits.
 * 3. Avoid Recursive Triggers: Ensure that the callout logic doesn't result in changes that re-invoke the same trigger, causing a recursive loop.
 * 
 * Optional Challenge: Use a trigger handler class to implement the trigger logic.
 */
trigger ContactTrigger on Contact(before insert, after insert, after update, before update, before delete, after delete, after undelete) {
	// When a contact is inserted
	public static Boolean stopRecursion = false;
	if(!stopRecursion){
		stopRecursion = true;
		ContactTriggerHandler handler = new ContactTriggerHandler();
		handler.run();
		//moved to handler
		//if(trigger.isInsert && trigger.isBefore){
			// for(Contact con : Trigger.new){
			// 	// if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
			// 	if (con.DummyJSON_Id__c == null){
			// 		Integer randomNo = (Integer)(Math.random() * 100);
			// 		con.DummyJSON_Id__c = String.ValueOf(randomNo);
			// 	} 
			// }
		}
	//When a contact is inserted
	// if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
		// if(trigger.isInsert && trigger.isAfter){

		// 	for(Contact newCon : trigger.new){
		// 		if ((newCon.DummyJSON_Id__c <>null) && numbersToOneHundred.toString().contains(newCon.DummyJSON_Id__c)){
		// 			DummyJSONCallout.getDummyJSONUserFromId(newCon.DummyJSON_Id__c);
		// 		}
		// 	}
		// }
	
	//When a contact is updated
	// 	if(trigger.isUpdate && trigger.isBefore){
	// 		for(Contact updatedCon : trigger.new){
	// 			Contact oldCon = Trigger.oldMap.get(updatedCon.Id);
	// // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
	// 			if((oldCon.DummyJSON_Id__c <> updatedCon.DummyJSON_Id__c) && (updatedCon.DummyJSON_Id__c <>null) && !(numbersToOneHundred.toString().contains(updatedCon.DummyJSON_Id__c))){
	// 				DummyJSONCallout.postCreateDummyJSONUser(updatedCon.Id);
	// 			}
	// 		}

	// 	}
	}


