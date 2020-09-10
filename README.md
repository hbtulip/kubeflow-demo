# kubeflow-demo
Kubeflow可以帮助用户在Kubernetes平台上高效的开发、构建、训练和部署模型。Kubeflow已正式发布1.0版本，它包含的核心组件有很多，我们来初步体验一下Jupyter Nodebook和TFJob。

----

## 部署Kubeflow

Kubeflow 1.0 要求工作节点的最低配置为：4 CPU，50 GB storage，12 GB memory，官方建议的Kubernetes版本为 v1.14和v1.15。今天我们尝试在v1.18上进行安装和测试。

<!-- ![](https://www.hmxq.top/kubeflow-demo/tf020.png  " ") -->
<div align="center"> <img src="https://www.hmxq.top/kubeflow-demo/tf020.png" width="80%"> </div>

### 安装步骤

- Kubernetes v1.18.3
- Kubeflow v1.0.1

```bash
#下载kfctl
wget https://github.com/kubeflow/kfctl/releases/download/v1.0.1/kfctl_v1.0.1-0-gf3edb9b_linux.tar.gz
tar zxcf kfctl_v1.0.1-0-gf3edb9b_linux.tar.gz
mv kfctl /usr/bin/

#初始化部署环境和下载所用manifests
pull.sh
kubectl create -f local_pv.yaml

#进入生成的my-kubeflow目录，开始安装kubeflow，大约10分钟
cd my-kubeflow
kfctl apply -V -f ./kfctl_k8s_istio.v1.0.1.yaml
kubectl get pods -n kubeflow
```
<div align="center"> <img src="https://www.hmxq.top/kubeflow-demo/tf001.png" width="80%"> </div>

```bash
#获取外部访问端口，例如：http://192.168.2.152:31380/
kubectl get svc -n istio-system istio-ingressgateway
```
<div align="center"> <img src="https://www.hmxq.top/kubeflow-demo/tf003.png" width="80%"> </div>

## Jupyter Nodebook

Jupyter Nodebook是一个开源的Web应用程序，灵活易用可交互，允许用户在线创建实时运行的程序代码，用于构建和训练机器学习模型。对于机器学习初学者来说，学会使用Jupyter Nodebook非常重要。

#### 1、访问Kubeflow，创建命名空间hmxflow；
#### 2、Nodebook Servers，创建新的hmx-notebook1；
//注意Docker Image是否可以访问；
//registry.cn-hangzhou.aliyuncs.com/kubeflow-images-public/tensorflow-1.15.2-notebook-cpu:1.0.0
//registry.cn-hangzhou.aliyuncs.com/kubeflow-images-public/tensorflow-1.15.2-notebook-gpu:1.0.0
![](https://www.hmxq.top/kubeflow-demo/tf008.png " ")

#### 3、hmx-notebook1创建成功；
![](https://www.hmxq.top/kubeflow-demo/tf005.png " ")

#### 4、连接hmx-notebook1，并新建hmx-test
![](https://www.hmxq.top/kubeflow-demo/tf006.png " ")

#### 5、hmx-notebook1上hmx-test.ipynb的运行结果
Accuracy:  0.9015


## TFJob
模型训练是机器学习最主要的实践场景，尤其以使用机器学习框架TensorFlow进行模型训练最为流行，但是随着机器学习的平台由单机变成集群，这个问题变得复杂了。GPU的调度和绑定，涉及到分布式训练的编排和集群规约属性的配置（cluster spec）也成了数据科学家们巨大的负担。
为了解决这一问题，一个新的资源类型TFJob，即TensorFlow Job被定义出来了。通过这个资源类型，
使用TensorFlow的数据科学家无需编写复杂的配置，只需要关注数据的输入，代码的运行和日志的输入输出。

```bash
cd dist-mnist
docker build -f Dockerfile -t kubeflow/tf-dist-mnist-test:1.0 ./
kubectl create -f ./tf_job_mnist.yaml
kubectl get tfjob,pod
```

![](https://www.hmxq.top/kubeflow-demo/tf009.png " ")


