@isTest private class TestUpdateAccountCA {
    
    @testSetup static void dataCreation() {
        // Create an account
        Account acc = new Account(Name = 'Test Account', Chiffre_d_affaire__c = 10000);
        insert acc;
    }
    
    @isTest static void updateAccountWithOneOrder() {
        // Search for the account previously created
        Account acc = [SELECT Id FROM Account WHERE  Name = 'Test Account' LIMIT 1 ];
        Test.startTest();
        // Create a list of orders with one already inserted then updated order, with ordered status
        List<Order> accOrders = TestDataFactory.createOrdersOnAccount(1, acc.Id);
        Test.stopTest();
        
        // Check the account's CA
        Account accCA = [ SELECT chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id ]; 
        
        // Assertion: new CA is equal to 10000 + 10*10 = 1100
        System.assertEquals(10100, accCA.Chiffre_d_affaire__c);
    }
    
    @isTest static void updateAccountOrderWithHundredOtherOrders() {
        // Search for the account previously created
        Account acc = [SELECT Id FROM Account WHERE  Name = 'Test Account' LIMIT 1 ];
        Test.startTest();
        // Create a list of orders with one already inserted then updated order, with ordered status
        List<Order> accOrders = TestDataFactory.createOrdersOnAccount(110, acc.Id);
        Test.stopTest();
        
        // Check the account's CA
        Account accCA = [ SELECT chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id ]; 
        
        // Assertion: new CA is equal to 10000 + 100*110 = 21000
        System.assertEquals(21000, accCA.Chiffre_d_affaire__c);      
    }
}