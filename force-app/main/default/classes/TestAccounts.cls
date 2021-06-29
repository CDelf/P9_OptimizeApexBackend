@isTest private class TestAccounts {
    
    @testSetup static void dataCreation() {
        // Create an account
        Account acc = new Account(Name = 'Test Account', Chiffre_d_affaire__c = 10000);
        insert acc;  
        // Create a priceBookEntry
        PriceBookEntry pbe = TestDataFactory.createPriceBookEntry();
        // Create a new order associated to the account
        Order newOrder = TestDataFactory.createOrder(acc.Id, true);
        // Create an order product: totalAmount is equal to 1500
        OrderItem item = new OrderItem (OrderId = newOrder.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert item;
    }
    
    @isTest static void updateOneAccountCA() {
        // Search for the account and newly created order
        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE  Name = 'Test Account' LIMIT 1 ];
        Order newOrder = [SELECT Id FROM Order WHERE AccountId = :acc.Id LIMIT 1 ];

        // Create a list of accounts and add acc
        List<Account> accs = new List<Account> {acc};

        // Test accounts method
        Test.startTest();
        Accounts.updateAccountCA(accs);
        Test.stopTest();

        // Check actual acc CA
        Account accCA  = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id];

        // Acc CA should be equal to 11500
        System.assertEquals(11500, accCa.chiffre_d_affaire__c );
    }

    @isTest static void tryToUpdateEmptyList() {
        // Create an empty list of account
        List<Account> accs = new List<Account>();
        insert accs;

        // Test accounts method
        Test.startTest();
        try {
            Accounts.updateAccountCA(accs);    
        } catch (Exception ex) {
            System.assert(ex.getMessage().contains('No Account Specified'));
        }
        Test.stopTest();
    }
}