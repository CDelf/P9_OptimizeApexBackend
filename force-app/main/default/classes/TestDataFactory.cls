@isTest
public class TestDataFactory {
    
    // Create an account
    public static Account createAccount(String name, boolean doInsert) {
        Account acc = new Account(Name = name);
        if(doInsert) {
            Insert acc;
        }
        return acc;
    }
    
    // Create a priceBookEntry
    public static PriceBookEntry createPriceBookEntry() {
        Product2 product = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert product;
        
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;
        Return pbe;
    }
    
    // Create an order with draft status, associated to an account
    public static Order createOrder(Id accountId, boolean doInsert) {
        Order newOrder = new Order(
            AccountId = accountId,
            Pricebook2Id=Test.getStandardPricebookId(),
            status = 'draft',
            effectiveDate = Date.today()
        );
        if(doInsert) {
            insert newOrder;
        }
        return newOrder;
    }
    
    // Create several orders with ordered status on one account
    // TotalAmount of each orders is equal to 100
    public static List<Order> createOrdersOnAccount(Integer numberOfOrders, Id accountId){
        // First insert draft orders
        List<Order> newOrders = new List<Order>();
        for(Integer i=0; i<numberOfOrders; i++) {
            Order newOrder = new Order(
                AccountId = accountId,
                Pricebook2Id = Test.getStandardPricebookId(),
                status = 'draft',
                effectiveDate = Date.today()
            );
            newOrders.add(newOrder);
        }
        insert newOrders;
        // Create a priceBookEntry
        PriceBookEntry pbe = TestDataFactory.createPriceBookEntry();
        // Create an order product: totalAmount is equal to 100
        List<OrderItem> items = new List<OrderItem>();
        for(Order newOrder : newOrders) {
            OrderItem item = new OrderItem (OrderId = newOrder.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 10);
            items.add(item);
        }
        insert items;     
        // Activate the orders
        for(Order newOrder : newOrders) {
            newOrder.Status = 'ordered';
        }
        update newOrders;
        return newOrders;
    }    
}