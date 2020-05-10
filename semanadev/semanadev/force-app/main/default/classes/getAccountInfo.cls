public with sharing class getAccountInfo {
    public static Boolean hasCNPJVerification(String accountId) {
        //Buscar no banco
        //SOQL linguagem sql do Salesforce
        Account acc = [SELECT Id, Ultima_Atualizacao__c
                        FROM Account
                        WHERE Id =: accountId];

        Boolean isVerified = false;
        if (acc.Ultima_Atualizacao__c != null) {
            isVerified = true;
        } 
        return isVerified;
    }
}
