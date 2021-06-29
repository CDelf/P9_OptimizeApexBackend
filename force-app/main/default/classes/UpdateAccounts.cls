global class UpdateAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Only request accounts having at least one order with 'ordered' status
       String query = AccountsSelector.queryAccountsWithOrderedOrders();
       return Database.getQueryLocator(query);
   }
   // Update the Chiffre_d_affaire field of all of these accounts, 
   // according to their ordered orders totalAmounts 
   global void execute(Database.BatchableContext info, List<Account> scope){      
      Accounts.updateAccountCA(scope);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}