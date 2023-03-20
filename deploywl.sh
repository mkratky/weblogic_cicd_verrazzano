oci ce cluster create-kubeconfig --cluster-id ocid1.cluster.oc1.eu-frankfurt-1.aaaaaaaam5t6sadpzxwaonq4z4nxibsnigloicbdvpgrcffsbc64aop2qm2a --file $HOME/.kube/config --region eu-frankfurt-1 --token-version 2.0.0  --kube-endpoint PUBLIC_ENDPOINT
kubectl apply -f ${PWD}/vtest-application.yaml -n vtest
kubectl apply -f ${PWD}/vtest-components.yaml -n vtest
