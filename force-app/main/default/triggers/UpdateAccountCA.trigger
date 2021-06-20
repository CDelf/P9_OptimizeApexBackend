trigger UpdateAccountCA on Order (before update) {
    // Get updated orders Ids
    Set<Id> ordersIds = trigger.newMap.keySet();
    // Search for accounts having at least one order with 'ordered' status
    List<Account> accList = AccountsSelector.selectAssociatedAccounts(ordersIds);
    // Update theses accounts
    Accounts.updateAccountCA(accList);    
}