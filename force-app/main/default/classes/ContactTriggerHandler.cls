public with sharing class ContactTriggerHandler extends TriggerHandler {
   
    private List<Contact> newConList;
    private List<Contact> oldConList;
    private Map<Id, Contact> newConMap;
    private Map<Id, Contact> oldConMap;
    
    public ContactTriggerHandler() {
        this.newConList = (List<Contact>)Trigger.new;
        this.oldConList = (List<Contact>)Trigger.old;
        this.newConMap = (Map<Id, Contact>)Trigger.newMap;
        this.oldConMap = (Map<Id, Contact>)Trigger.oldMap;
        }
    
    public override void beforeInsert(){
		for(Contact con : this.newConList){
				// if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
			if (con.DummyJSON_Id__c == null){
				Integer randomNo = (Integer)(Math.random() * 100);
				con.DummyJSON_Id__c = String.ValueOf(randomNo);
			} 
		}
    }

    public override void afterInsert(){
        Set<Integer> numbersToOneHundred = new Set<Integer>();
        for(Integer i = 0; i<= 100; i++){
            numbersToOneHundred.add(i);
        }
        for(Contact newCon : this.newConList){
            if ((newCon.DummyJSON_Id__c <>null) && numbersToOneHundred.toString().contains(newCon.DummyJSON_Id__c)){
                DummyJSONCallout.getDummyJSONUserFromId(newCon.DummyJSON_Id__c);
            }
        }
    }

    public override void beforeUpdate(){
        Set<Integer> numbersToOneHundred = new Set<Integer>();
        for(Integer i = 0; i<= 100; i++){
            numbersToOneHundred.add(i);
        }
        for(Contact updatedCon : this.newConList){
            Contact oldCon = This.oldConMap.get(updatedCon.Id);
        // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
            if((oldCon.DummyJSON_Id__c <> updatedCon.DummyJSON_Id__c) && (updatedCon.DummyJSON_Id__c <>null) && !(numbersToOneHundred.toString().contains(updatedCon.DummyJSON_Id__c))){
                DummyJSONCallout.postCreateDummyJSONUser(updatedCon.Id);
            }
        }
    }

}