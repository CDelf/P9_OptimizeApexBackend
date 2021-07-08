public with sharing class Accounts {
    
    public static List<Account> updateAccountCA(List<Account> accsToUpdate) {
        // If the account list is empty, throw an exception
        if(accsToUpdate.size()==0) {
            throw new AccountDomainException('No Account Specified');
        } else {
            // Get orders related to theses accounts
             list<Order> accOrders =  OrdersSelector.selectOrdersFromAccounts(accsToUpdate);
            // Update accounts CA adding totalAmount of related orders
            for(Account acc : accsToUpdate) {
                for(Order newOrder : accOrders) {
                    if(acc.Id == newOrder.AccountId) {
                        acc.chiffre_d_affaire__c += newOrder.TotalAmount;
                    }
                } 
            }
            update accsToUpdate;
            return accsToUpdate;
        }
    }
    
    public class AccountDomainException extends Exception {} 
}