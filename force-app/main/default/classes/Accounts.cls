public with sharing class Accounts {
    
    public static List<Account> updateAccountCA(List<Account> accsToUpdate) {
        // Create a list of accounts from their ids
        if(accsToUpdate.size()==0) {
            throw new AccountDomainException('No Account specified');
        } else {
            // Get orders related to theses accounts
            List<Order> accOrders = OrdersSelector.selectOrdersFromAccounts(accsToUpdate);
            // Create the list of accounts that will finally be returned
            List<Account> updatedAccs = new List<Account>();
            // Update accounts CA adding totalAmount of related orders
            for(Account acc : accsToUpdate) {
                for(Order order : accOrders) {
                    if(acc.Id == order.AccountId) {
                        acc.chiffre_d_affaire__c += order.TotalAmount;
                        updatedAccs.add(acc);
                    }
                }
                
            }
            update updatedAccs;
            return updatedAccs;
        }
    }
    
    public class AccountDomainException extends Exception {} 
}