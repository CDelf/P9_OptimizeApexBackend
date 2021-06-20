global class UpdateAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Only request accounts having at least one order with 'ordered' status
       return Database.getQueryLocator('SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = \'Ordered\')');
   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){      
      Accounts.updateAccountCA(scope);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}