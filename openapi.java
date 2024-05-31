import io.kubernetes.client.openapi.ApiClient;
import io.kubernetes.client.openapi.ApiException;
import io.kubernetes.client.openapi.Configuration;
import io.kubernetes.client.openapi.apis.AppsV1Api;
import io.kubernetes.client.openapi.models.V1Deployment;
import io.kubernetes.client.openapi.models.V1DeploymentSpec;
import io.kubernetes.client.util.Config;

public class Main {
    public static void main(String[] args) {
        try {
            ApiClient client = Config.defaultClient();
            Configuration.setDefaultApiClient(client);

            AppsV1Api api = new AppsV1Api();
            V1Deployment body = new V1Deployment();
            body.setSpec(new V1DeploymentSpec().replicas(5));

            api.replaceNamespacedDeployment("myapp-deployment", "default", body, null, null, null);
        } catch (ApiException e) {
            System.err.println("Exception when calling AppsV1Api#replaceNamespacedDeployment");
            e.printStackTrace();
        }
    }
}