public with sharing class AccountsSelector {

    // Search for associated accounts from orders ids 
    public static List<Account> selectAssociatedAccounts(Set<Id> orderIds) {
        List<Account> accList = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN 
                                (SELECT AccountId FROM Order WHERE Id IN :orderIds)
                                ];
        return accList;
    }

    // Query for batch
    public static String queryAccountsWithOrderedOrders() {
        String query = 'SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = \'Ordered\') ';
        return query;
    }
    
    public class AccountSelectorException extends Exception {} 
}