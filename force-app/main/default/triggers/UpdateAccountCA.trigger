trigger UpdateAccountCA on Order (before update) {

    // Create an empty list of accounts
    List<Account> accList = new List<Account>();

    // For each updated order
    for(Order newOrder : Trigger.new) {
        // request the associated account
        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :newOrder.AccountId ] ;
        // calculate new chiffre_d_affaire
        acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
       // add account to the list
       accList.add(acc);
    }
    // Update the account list
    update accList;
}