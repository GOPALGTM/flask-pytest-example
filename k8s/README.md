# 🚀 Deploy Flask App to AKS using Kubernetes Manifests
## 🗂 Prerequisites
Ensure the following are completed:

✅ AKS cluster is created using Terraform.

✅ kubectl is installed.

✅ Access is configured to your AKS cluster:

az aks get-credentials --resource-group <resource-group-name> --name <aks-cluster-name>
## 📦 Step-by-Step Deployment
### ✅ Step 1: Deploy the Application
Create the app pods:

kubectl apply -f deployment.yaml
kubectl get pods
### 🌐 Step 2: Expose the Application
Create the service to expose your app:

kubectl apply -f service.yaml
kubectl get svc
wait a few seconds for the EXTERNAL-IP to appear.

### 📈 Step 3: Enable Autoscaling (Optional)
Apply Horizontal Pod Autoscaler:

kubectl apply -f hpa.yaml
kubectl get hpa

### 🧼 Cleanup 
Remove all deployed resources:

kubectl delete -f hpa.yaml
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
