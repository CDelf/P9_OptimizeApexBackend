@isTest private class TestUpdateAccountCA {
    
    @testSetup static void accountCreation() {
        // Create an account
        Account acc = new Account(Name = 'Test Account', Chiffre_d_affaire__c = 10000);
        insert acc;
    }
    
    // Method to get the account just created
    static Account findAccount() {
        Account acc = [SELECT Id FROM Account WHERE  Name = 'Test Account' LIMIT 1 ];
        return acc;
    }

    @isTest static void updateAccountWithOneOrder() {
        // Get the account
        Account acc = TestUpdateAccountCA.findAccount();
        Test.startTest();
        // Create a list of orders with one already inserted then updated order, with ordered status
        List<Order> accOrders = TestDataFactory.createOrdersOnAccount(1, acc.Id);
        Test.stopTest();
        // Check the account's CA
        Account accCA = [ SELECT chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id ]; 
        // Assertion: new CA is equal to 10000 + 10*10 = 10100
        System.assertEquals(10100, accCA.Chiffre_d_affaire__c);
    }
    
    @isTest static void updateAccOrderWithMoreThanOneHundredOtherOrders() {
        // Get the account
        Account acc = TestUpdateAccountCA.findAccount();
        Test.startTest();
        // Create a list of orders with one already inserted then updated order, with ordered status
        List<Order> accOrders = TestDataFactory.createOrdersOnAccount(110, acc.Id);
        Test.stopTest(); 
        // Check the account's CA
        Account accCA = [SELECT chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id]; 
        // Assertion: new CA is equal to 10000 + 110*100 = 21000
        System.assertEquals(21000, accCA.Chiffre_d_affaire__c);      
    }    
    
    @isTest static void updateAccOrderWithMoreThanTwoHundredOtherOrders() {
        // Get the account
        Account acc = TestUpdateAccountCA.findAccount();
        Test.startTest();
        // Create a list of orders with one already inserted then updated order, with ordered status
        List<Order> accOrders = TestDataFactory.createOrdersOnAccount(200, acc.Id);
        Test.stopTest(); 
        // Check the account's CA
        Account accCA = [ SELECT chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id ]; 
        // Assertion: new CA is equal to 10000 + 100*200
        System.assertEquals(30000, accCA.Chiffre_d_affaire__c);      
    }
    @isTest static void updateAccOrdersWithMultipleProducts() {
        // Get the account
        Account acc = TestUpdateAccountCA.findAccount();
        // Create 2 orders with 2 products each
        // Each TotalAmount of order is equal to 100
        Test.startTest();
        List<Order> newOrders = TestDataFactory.createMultipleProductsOrders(acc.Id, 2, 2);
        Test.stopTest();
        // Check the account's CA
        Account accCA = [ SELECT chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id ]; 
        // Assertion: new CA is equal to 10000 + 200 = 10200
        System.assertEquals(10200, accCA.Chiffre_d_affaire__c);  
    }
}