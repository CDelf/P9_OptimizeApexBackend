@isTest private class TestUpdateAccounts {
    
    @testSetup static void dataCreation() {
        // Create an account
        Account acc = new Account(Name = 'Test Account', Chiffre_d_affaire__c = 10000);
        insert acc;  
    }
    
    @isTest static void testUpdateTenAccounts() {
        // Search for the account and associated order
        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE  Name = 'Test Account' LIMIT 1 ];
        // Create an ordered order on account. Because of update trigger, CA is equal to 11000    
        List<Order> newOrders = TestDataFactory.createOrdersOnAccount(10, acc.Id); 
        // Launch the batch
        Test.startTest();
        UpdateAccounts upAccs = new UpdateAccounts();
        Id batchId = Database.executeBatch(upAccs);
        Test.stopTest();
        // Check new acc CA
        Account accCA = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id];
        // Assertion CA should be equal to 11000 + 10*100 = 12000
        System.assertEquals(12000, accCA.Chiffre_d_affaire__c);    
    }
    
   @isTest static void testChangeProductsUnitPrice() {
               // Search for the account and associated order
        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE  Name = 'Test Account' LIMIT 1 ];
        // Create an ordered order on account. Because of update trigger, CA is equal to 10300    
        List<Order> newOrders = TestDataFactory.createOrdersOnAccount(3, acc.Id); 
        List<OrderItem> products = [SELECT UnitPrice FROM OrderItem WHERE OrderId IN :newOrders ];
        // Change unit price of product: each order TotalAmount is equal to 200
       for(OrderItem product : products) { 
       product.unitPrice = 20;
       }
       update products;
        // Launch the batch
        Test.startTest();
        UpdateAccounts upAccs = new UpdateAccounts();
        Id batchId = Database.executeBatch(upAccs);
        Test.stopTest();
        // Check new acc CA
        Account accCA = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id];
        // Assertions account CA should be equal to 10300 + 200*3 = 10900
        System.assertEquals(10900, accCA.Chiffre_d_affaire__c);
    }
}