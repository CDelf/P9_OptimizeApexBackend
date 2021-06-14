trigger UpdateAccountCA on Order (before update) {
	// Get updated orders Ids
    Set<Id> ordersIds = trigger.newMap.keySet();
    // Search for accounts having at least one order with 'ordered' status
    List<Account> accList = AccountsSelector.selectAssociatedAccounts(ordersIds);
    
    // For each updated order
    for(Order newOrder : Trigger.new) { 
        // Browse the account list
        for(Account acc : accList) {
            if(acc.Id == newOrder.AccountId) {
                // calculate the new chiffre_d_affaire
                acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
                break;
            }
        }
    }
    // Update the account list
    update accList;
}