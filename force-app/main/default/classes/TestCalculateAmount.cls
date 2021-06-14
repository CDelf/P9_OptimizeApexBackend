@isTest private class TestCalculateAmount {
    
    @testSetup static void dataCreation() {
        // Create an account
        Account acc = new Account(Name = 'Test Account', Chiffre_d_affaire__c = 10000);
        insert acc;  
        // Create a priceBookEntry
        PriceBookEntry pbe = TestDataFactory.createPriceBookEntry();
        // Create a new order associated to the account
        Order newOrder = TestDataFactory.createOrder(acc.Id);
        // Create an order product: totalAmount is equal to 1500
        OrderItem item = new OrderItem (OrderId = newOrder.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert item;
    }
    
    @isTest static void updateOneOrder() {
        // Retrieve data from testSetup
        Account acc = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1 ];
        Order newOrder = [SELECT TotalAmount FROM Order WHERE AccountId = :acc.Id ];
        // Update the order to specify the shipmentCost 
        newOrder.ShipmentCost__c = 50;
        update newOrder;
        // Calculate the expected netAmount of the order given totalAmount and shipmentCost
        Decimal expectedNetAmount = (Integer) newOrder.TotalAmount - newOrder.ShipmentCost__c;
        // Request for real NetAmount of order
        Order order = [SELECT NetAmount__c FROM Order WHERE Id = :newOrder.Id ];
		// Check if both are equal
		System.assertEquals(expectedNetAmount,order.NetAmount__c);         
    }
}