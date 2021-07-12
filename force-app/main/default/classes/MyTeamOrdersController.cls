public without sharing class MyTeamOrdersController {
    // Get and display the list of salers and their orders amount
     public AggregateResult[] getOrders{
        get{
           return [SELECT Owner.Name ownerName, SUM(TotalAmount) totalAmount FROM Order 
                    WHERE Status = 'Ordered' GROUP BY Owner.Name];
        }    
    	set;
    }
       // Get and display the sum of all orders
       public decimal sumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal)groupedResults.get('total');
        }
        set;
    }
}