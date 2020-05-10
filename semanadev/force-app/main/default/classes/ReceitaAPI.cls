public with sharing class ReceitaAPI {
    //Variável que conterá a url
    private static String endpoint = 'https://www.receitaws.com.br/v1/cnpj/';

    public static TopReceitaAPI callReceitaAPI(String CNPJ) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + CNPJ);
        request.setMethod('GET');
        request.setTimeout(12000);

        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                String json = response.getBody();
                return TopReceitaAPI.parse(json);
            } else if (response.getStatusCode() == 429) {
                //Só pode fazer 3 chamadas por minuto - senão retorna um erro - limitação do serviço gratuito
                TopReceitaAPI toReceita = new TopReceitaAPI();
                toReceita.status = 'ERROR';
                toReceita.message = 'Too Many Request';

                return toReceita;
            }
        } catch (Exception ex) {
            TopReceitaAPI toReceitaErro = new TOReceitaAPI();
            toReceitaErro.status = 'ERROR';
            toReceitaErro.message = ex.getMessage();

            return toReceitaErro;
        }
        return null;
    }
}
