function kk-kubeconfig () {
  export KUBECONFIG="$(kind get kubeconfig-path)"
}

function kk-token () {
  kubectl -n kube-system describe secrets \
    `kubectl -n kube-system get secrets | awk '/clusterrole-aggregation-controller/ {print $1}'` | \
    awk '/token:/ {print $2}'
}

function kk-apply-dashboard () {
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml
}
