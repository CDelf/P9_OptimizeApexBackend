public with sharing class OrdersSelector {

    // Search for orders from associated accounts
    public static List<Order> selectOrdersFromAccounts(List<Account> accList) {
        if(accList == null || accList.size() == 0) {
            throw new OdersSelectorException('No Account Specified');
        } else {
        list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId, Account.Chiffre_d_affaire__c 
                                   FROM Order WHERE AccountId IN :accList];
        return listOrders;
        }
    }
    public class OdersSelectorException extends Exception {} 
}

