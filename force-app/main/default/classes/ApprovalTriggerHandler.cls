public with sharing class ApprovalTriggerHandler {
    // This class is used to desactivate UpdateAccountCA trigger when testing
    // UpdateAccounts batch class.
    // When the boolean doNotRunTrigger is true, trigger is desactivated. 
    public static Boolean doNotRunTrigger = false;

    public static void setDoNotRunTrigger(){
        doNotRunTrigger = true;
    }
}
