from kubernetes import client, config

def scale_deployment(name, namespace, replicas):
    config.load_kube_config()

    with client.ApiClient() as api_client:
        api_instance = client.AppsV1Api(api_client)
        body = {"spec": {"replicas": replicas}}
        api_instance.patch_namespaced_deployment(name=name, namespace=namespace, body=body)

scale_deployment(name="myapp-deployment", namespace="default", replicas=5)