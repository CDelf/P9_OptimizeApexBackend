@isTest(SeeAllData=false) private class TestUpdateAccounts {
    
    @isTest static void testUpdateTenAccounts() {
        // Desactivate trigger
        ApprovalTriggerHandler.setDoNotRunTrigger();
       // Create a list of 10 accounts 
        List<Account> accs = new List<Account>();
        for(Integer i=0; i<10;i++) {
            Account acc = new Account(Name = 'Test Account '+i, Chiffre_d_affaire__c = 10000);
            accs.add(acc);
        }
        insert accs;
        // Create orders associated to the accounts
        List<Order> orders = new List<Order>();
        for(Account acc : accs) {
            Order newOrder = TestDataFactory.createOrder(acc.Id, false);
            orders.add(newOrder);
        }
        insert orders;
        // Create a Price Book Entry
        PricebookEntry pbe = TestDataFactory.createPriceBookEntry();
        // Add products to orders 
        List<OrderItem> items = new List<OrderItem>();
        for(Order newOrder : orders) {
            OrderItem item = new OrderItem (OrderId = newOrder.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 10);
            items.add(item);
        }
        insert items;
        // Then activate orders
        for(Order newOrder : orders) {
            newOrder.Status = 'Ordered';
        }
        update orders;
        // Launch the batch
        Test.startTest();
        UpdateAccounts upAccs = new UpdateAccounts();
        Id batchId = Database.executeBatch(upAccs);
        Test.stopTest();
        // Check accounts CA
        List<Account> accsCA = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id IN :accs ];
        // Assertions
        for(Account acc : accsCA) {
            System.assertEquals(10100, acc.Chiffre_d_affaire__c);
        }
    }
 
   @isTest static void testChangeProductsUnitPrice() { 
        // Desactivate trigger
        ApprovalTriggerHandler.setDoNotRunTrigger();
        // Create an account
        Account acc = new Account(Name = 'Test Account', Chiffre_d_affaire__c = 10000);
        insert acc;
        // Create an ordered order on account.    
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
        // Assertions account CA should be equal to 10000 + 200*3 = 10600
        System.assertEquals(10600, accCA.Chiffre_d_affaire__c);
    }
}