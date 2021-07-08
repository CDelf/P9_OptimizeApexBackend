@isTest private class TestAccounts {
    
    @testSetup static void dataCreation() {
        // Create accounts
        List<Account> accs = new List<Account>();
        for(Integer i = 0; i<3; i++) {
            Account acc = new Account(Name = 'Test Account '+ i, Chiffre_d_affaire__c = 10000);
            accs.add(acc);
        }
        insert accs;
    }
    
    @isTest static void updateMoreThanTwoHundredOrdersAccountCA() {
        // Get an account
        Account acc = [ SELECT Chiffre_d_affaire__c FROM Account WHERE Name='Test Account 1' LIMIT 1 ];
        // Create 210 ordered orders on account
        List<Order> accOrders = TestDataFactory.createOrdersOnAccount(210, acc.Id);
        // Create a list of accounts and add acc
        List<Account> accs = new List<Account> {acc};
        // Test accounts method
        Test.startTest();
        Accounts.updateAccountCA(accs);
        Test.stopTest();
        // Check actual acc CA
        Account accCA  = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id];
        // Acc CA should be equal to 10000 + 210 * 100
        System.assertEquals(31000, accCa.chiffre_d_affaire__c );
    }

    @isTest static void updateThreeAccountsCA() {
        // Get the accounts
        List<Account> accs = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE  Name LIKE 'Test Account %' LIMIT 3 ];
        // Add two ordered orders for each account
        List<Order> orderAccOne = TestDataFactory.createOrdersOnAccount(2, accs.get(0).Id);
        List<Order> orderAccTwo = TestDataFactory.createOrdersOnAccount(2, accs.get(1).Id);
        List<Order> orderAccThree = TestDataFactory.createOrdersOnAccount(2, accs.get(2).Id);
        // Test accounts method
        Test.startTest();
        Accounts.updateAccountCA(accs);
        Test.stopTest();
        // Check actual acc CA
        List<Account> accsCA  = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accs ];
        // Each account CA should be equal to 10000 + 200
        System.assertEquals(10200, accsCa.get(0).Chiffre_d_affaire__c );
        System.assertEquals(10200, accsCa.get(1).Chiffre_d_affaire__c );
        System.assertEquals(10200, accsCa.get(2).Chiffre_d_affaire__c );
    }

    @isTest static void updateAccsCAMultipleOrdersWithMultipleProducts() {
        // Get the accounts
        List<Account> accs = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE  Name LIKE 'Test Account %' LIMIT 3 ];
        // Add two ordered orders having two products for each account
        // TotalAmount of each order is equal to 100
        List<Order> orderAccOne = TestDataFactory.createMultipleProductsOrders(accs.get(0).Id, 2, 2);
        List<Order> orderAccTwo = TestDataFactory.createMultipleProductsOrders(accs.get(1).Id, 2, 2);
        List<Order> orderAccThree = TestDataFactory.createMultipleProductsOrders(accs.get(2).Id, 2, 2);
        // Test accounts method
        Test.startTest();
        Accounts.updateAccountCA(accs);
        Test.stopTest();
        // Check actual acc CA
        List<Account> accsCA  = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accs ];
        // Each account CA should be equal to 10000 + 200
        System.assertEquals(10200, accsCa.get(0).Chiffre_d_affaire__c );
        System.assertEquals(10200, accsCa.get(1).Chiffre_d_affaire__c );
        System.assertEquals(10200, accsCa.get(2).Chiffre_d_affaire__c );
    }

    @isTest static void tryToUpdateEmptyList() {
        // Create an empty list of account
        List<Account> accs = new List<Account>();
        insert accs;
        // Test Accounts.updateAccountCA method
        Test.startTest();
        try {
            Accounts.updateAccountCA(accs);  
            // Assertion : empty account list should throw an exception  
        } catch (Exception ex) {
            System.assert(ex.getMessage().contains('No Account Specified'));
        }
        Test.stopTest();
    }
}