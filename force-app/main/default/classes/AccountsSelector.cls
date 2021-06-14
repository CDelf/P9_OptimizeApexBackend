public with sharing class AccountsSelector {

    // Search for associated accounts from orders ids 
    public static List<Account> selectAssociatedAccounts(Set<Id> orderIds) {
        List<Account> accList = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN 
                                (SELECT AccountId FROM Order WHERE Id IN :orderIds)
                                ];
        return accList;
    }

    // Search for accounts having at least one order with 'ordered' status
    public static List<Account> selectAccountsWithOrderedOrder() {
        List<Account> accList = [SELECT Id FROM Account WHERE Id IN 
                                (SELECT AccountId FROM Order WHERE Status = 'Ordered')  
                                ];
        return accList;
    }
}
