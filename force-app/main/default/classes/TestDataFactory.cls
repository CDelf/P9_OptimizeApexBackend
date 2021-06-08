@isTest
public class TestDataFactory {
    
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
    
    // Create an order
    public static Order createOrder(Id accountId) {
         Order newOrder = new Order(
         AccountId = accountId,
         Pricebook2Id=Test.getStandardPricebookId(),
         status = 'draft',
         effectiveDate = Date.today()
         );
        insert newOrder;
        return newOrder;
    }
}