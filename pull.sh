
export KF_NAME=my-kubeflow
export BASE_DIR=/root/
export KF_DIR=${BASE_DIR}/${KF_NAME}
export CONFIG_URI="https://kubeflow.oss-cn-beijing.aliyuncs.com/kfctl_k8s_istio.v1.0.1.yaml"
#export CONFIG_URI="file:///root/kubeflow/kfctl_k8s_istio.v1.0.1.yaml"

mkdir -p ${KF_DIR}
cd ${KF_DIR}
kfctl build -V -f ${CONFIG_URI}
export CONFIG=${KF_DIR}/kfctl_k8s_istio.v1.0.1.yaml

