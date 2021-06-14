trigger CalculateAmount on Order (before update) {
	
	//Calculate the net amount of updated orders
	for(Order newOrder : Trigger.new) {
		if(newOrder.shipmentCost__c != null) {
	newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
	}
}
 }