@isTest private class TestMyTeamOrders {
    
    @isTest static void controllerTest() {
		// Create an account
        Account acc = new Account(name = 'Test', chiffre_d_affaire__c = 10000);
        insert acc;
        // Create an order associated to this account
        // Amount is equal to 100
        List<Order> newOrders = TestDataFactory.createOrdersOnAccount(1, acc.Id);
        Order newOrder = newOrders.get(0);
        
        Test.StartTest(); 
        // Instanciate the visualforce page and define parameters
  		PageReference pageRef = Page.MyTeamOrders; 
  		pageRef.getParameters().put('id', String.valueOf(newOrder.Id));
  		Test.setCurrentPage(pageRef);
        // Instanciate the VF custom controller
        MyTeamOrdersController controller = new MyTeamOrdersController();
 		Test.StopTest();
        System.assertEquals(1, controller.getOrders.size());
        System.assertEquals(100, controller.sumOrders);
    }
}