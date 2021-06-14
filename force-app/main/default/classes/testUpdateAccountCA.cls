@isTest private class TestUpdateAccountCA {
    
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
    
    @isTest static void updateAccountWithOneOrder() {
        // Search for the account and newly created order
        Account acc = [SELECT Id FROM Account WHERE  Name = 'Test Account' LIMIT 1 ];
        Order newOrder = [SELECT Id FROM Order WHERE AccountId = :acc.Id];
        // Update the order to set it status to 'ordered'
        Test.startTest();
        newOrder.status = 'ordered';
        update newOrder;
        Test.stopTest();
        
        // Check the account's CA
        Account accCA = [ SELECT chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id ]; 
        
        // Assertion: new CA is equal to 11500
        System.assertEquals(11500, accCA.Chiffre_d_affaire__c);
    }
}