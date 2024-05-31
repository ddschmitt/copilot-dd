package main

import (
    "context"
    "flag"
    "path/filepath"

    corev1 "k8s.io/api/core/v1"
    appsv1 "k8s.io/api/apps/v1"
    metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
    "k8s.io/client-go/kubernetes"
    "k8s.io/client-go/tools/clientcmd"
    "k8s.io/client-go/util/homedir"
)

func main() {
    var kubeconfig *string
    if home := homedir.HomeDir(); home != "" {
        kubeconfig = flag.String("kubeconfig", filepath.Join(home, ".kube", "config"), "(optional) absolute path to the kubeconfig file")
    } else {
        kubeconfig = flag.String("kubeconfig", "", "absolute path to the kubeconfig file")
    }
    flag.Parse()

    config, err := clientcmd.BuildConfigFromFlags("", *kubeconfig)
    if err != nil {
        panic(err)
    }

    clientset, err := kubernetes.NewForConfig(config)
    if err != nil {
        panic(err)
    }

    deploymentsClient := clientset.AppsV1().Deployments(corev1.NamespaceDefault)

    scale := &appsv1.Scale{
        ObjectMeta: metav1.ObjectMeta{
            Name:      "myapp-deployment",
            Namespace: corev1.NamespaceDefault,
        },
        Spec: appsv1.ScaleSpec{
            Replicas: 5,
        },
    }

    _, err = deploymentsClient.UpdateScale(context.Background(), "myapp-deployment", scale, metav1.UpdateOptions{})
    if err != nil {
        panic(err)
    }
}