# Kubectl Command Guide with Examples

## kubectl (Kubernetes CLI)

- The default and most widely used CLI tool for interacting with Kubernetes clusters.
- Used for managing pods, deployments, services, configmaps, and more.

## 1. Basic Commands

### **Check Kubernetes Version**

```sh
kubectl version --short
```

### **View Cluster Information**

```sh
kubectl cluster-info
```

### **Get Current Context**

```sh
kubectl config current-context
```

### **List All Contexts**

```sh
kubectl config get-contexts
```

### **Switch Context**

```sh
kubectl config use-context <context-name>
```

### **Set Default Namespace**

```sh
kubectl config set-context --current --namespace=<namespace>
```

---

## 2. Working with Namespaces

### **List All Namespaces**

```sh
kubectl get namespaces
```

### **Create a Namespace**

```sh
kubectl create namespace <namespace>
```

### **Delete a Namespace**

```sh
kubectl delete namespace <namespace>
```

---

## 3. Managing Pods

### **List All Pods**

```sh
kubectl get pods
```

### **List Pods in a Specific Namespace**

```sh
kubectl get pods -n <namespace>
```

### **Describe a Pod**

```sh
kubectl describe pod <pod-name>
```

### **Get Pod Logs**

```sh
kubectl logs <pod-name>
```

### **Stream Pod Logs**

```sh
kubectl logs -f <pod-name>
```

### **Execute a Command in a Running Pod**

```sh
kubectl exec -it <pod-name> -- <command>
```

### **Delete a Pod**

```sh
kubectl delete pod <pod-name>
```

---

## 4. Managing Deployments

### **List Deployments**

```sh
kubectl get deployments
```

### **Describe a Deployment**

```sh
kubectl describe deployment <deployment-name>
```

### **Scale a Deployment**

```sh
kubectl scale deployment <deployment-name> --replicas=<number>
```

### **Update a Deployment**

```sh
kubectl set image deployment/<deployment-name> <container-name>=<new-image>
```

### **Roll Back a Deployment**

```sh
kubectl rollout undo deployment <deployment-name>
```

---

## 5. Managing Services

### **List All Services**

```sh
kubectl get services
```

### **Describe a Service**

```sh
kubectl describe service <service-name>
```

### **Expose a Deployment as a Service**

```sh
kubectl expose deployment <deployment-name> --type=<type> --port=<port>
```

### **Delete a Service**

```sh
kubectl delete service <service-name>
```

---

## 6. Managing ConfigMaps & Secrets

### **List All ConfigMaps**

```sh
kubectl get configmaps
```

### **Describe a ConfigMap**

```sh
kubectl describe configmap <configmap-name>
```

### **Create a ConfigMap from a File**

```sh
kubectl create configmap <configmap-name> --from-file=<file-path>
```

### **List All Secrets**

```sh
kubectl get secrets
```

### **Describe a Secret**

```sh
kubectl describe secret <secret-name>
```

### **Create a Secret from a File**

```sh
kubectl create secret generic <secret-name> --from-file=<file-path>
```

---

## 7. Other Useful Commands

### **Get Events in the Cluster**

```sh
kubectl get events
```

### **Get Resource Usage (CPU/Memory)**

```sh
kubectl top pod
```

### **Delete All Resources in a Namespace**

```sh
kubectl delete all --all -n <namespace>
```

---

These commands will help you effectively manage Kubernetes clusters using **kubectl**! 🚀
