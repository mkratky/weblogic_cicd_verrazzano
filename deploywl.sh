oci ce cluster create-kubeconfig --cluster-id ocid1.cluster.oc1.eu-frankfurt-1.aaaaaaaaae3tqnbzgjstqzdcme2wkojtgnrdomjumm4tmmzxhc3tkyrygvtg --file $HOME/.kube/config --region eu-frankfurt-1 --token-version 2.0.0 
kubectl apply -f ${PWD}/vtest-application.yaml
kubectl apply -f ${PWD}/vtest-components.yaml
