public with sharing class AccountsSelector {

    // Query for UpdateAccounts batch 
    // Search for accounts having at least one ordered order
    public static String queryAccountsWithOrderedOrders() {
        String query = 'SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = \'Ordered\')';
        return query;
    }
    
    // Search for associated accounts from orders ids 
    public static List<Account> selectAssociatedAccounts(Set<Id> orderIds) {
        List<Account> accList = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN 
                                (SELECT AccountId FROM Order WHERE Id IN :orderIds)
                                ];
        return accList;
    }

    public class AccountSelectorException extends Exception {} 
}
