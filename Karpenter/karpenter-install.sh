KARPENTER_VERSION="1.12.1"
CLUSTER_NAME="TEGK-eks-cluster"
KARPENTER_NAMESPACE="kube-system"
AWS_PARTITION="aws"
AWS_ACCOUNT_ID="749856334984"

function helmtemplate() {

    helm template karpenter oci://public.ecr.aws/karpenter/karpenter --version "${KARPENTER_VERSION}" --namespace "${KARPENTER_NAMESPACE}" \
        --set "settings.clusterName=${CLUSTER_NAME}" \
        --set "settings.interruptionQueue=${CLUSTER_NAME}" \
        --set "serviceAccount.annotations.eks\.amazonaws\.com/role-arn=arn:${AWS_PARTITION}:iam::${AWS_ACCOUNT_ID}:role/TEGK-eks-karpenter-role" \
        --set controller.resources.requests.cpu=1 \
        --set controller.resources.requests.memory=1Gi \
        --set controller.resources.limits.cpu=1 \
        --set controller.resources.limits.memory=1Gi > karpenter.yaml
    
}
helmtemplate