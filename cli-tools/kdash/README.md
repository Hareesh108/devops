# KDash Tool Commands with Examples

## kdash (Kubernetes Dashboard TUI)

- A terminal-based UI for Kubernetes.
- Provides a real-time, interactive way to manage cluster resources.
- Offers better visibility than plain kubectl commands.

## 1. Basic Commands

### **Launch KDash**

```sh
kdash
```

**Example:** Opens KDash with the default Kubernetes context.

### **Launch KDash in a Specific Namespace**

```sh
kdash -n dev
```

**Example:** Opens KDash and focuses on the `dev` namespace.

### **Launch KDash with a Specific Kubernetes Context**

```sh
kdash --context my-cluster
```

**Example:** Opens KDash using the `my-cluster` context.

### **Quit KDash**

Press `q` or `Ctrl+C`

---

## 2. Navigation Commands

### **Open Command Bar**

Press `:`

### **Show Help Menu**

Press `?`

### **Exit a Menu or Return to the Previous View**

Press `Esc`

### **Switch to All Namespaces View**

Press `0`

---

## 3. Viewing Kubernetes Resources

### **View Pods**

Press `p`

**Example:** Opens the Pods view.

### **View Deployments**

Press `d`

**Example:** Opens the Deployments list.

### **View Services**

Press `s`

**Example:** Opens the Services list.

### **View Namespaces**

Press `n`

**Example:** Lists all namespaces.

### **View ConfigMaps**

Press `c`

**Example:** Opens the ConfigMaps list.

### **View Secrets**

Press `e`

**Example:** Lists Kubernetes Secrets.

---

## 4. Pod Actions

### **Describe a Pod**

Press `i` on a selected pod.  
Equivalent command in `kubectl`:

```sh
kubectl describe pod <pod-name>
```

### **View Pod Logs**

Press `l` on a selected pod.  
Equivalent command in `kubectl`:

```sh
kubectl logs <pod-name>
```

### **Stream Pod Logs**

Press `f` on a selected pod.  
Equivalent command in `kubectl`:

```sh
kubectl logs -f <pod-name>
```

### **Edit a Pod YAML File**

Press `e` on a selected pod.  
Equivalent command in `kubectl`:

```sh
kubectl edit pod <pod-name>
```

### **Delete a Pod**

Press `x` on a selected pod and confirm.  
Equivalent command in `kubectl`:

```sh
kubectl delete pod <pod-name>
```

### **Restart a Pod (By Deleting It, If Managed by a Deployment)**

Press `r` on a selected pod.  
Equivalent command in `kubectl`:

```sh
kubectl delete pod <pod-name>
```

*(If the pod is part of a Deployment, it will be automatically recreated.)*

---

## 5. Additional Features

### **Switch Kubernetes Context**

Press `Shift + S`  
Equivalent command in `kubectl`:

```sh
kubectl config use-context <context-name>
```

### **Toggle View Mode**

Press `Ctrl + A`

### **Search for a Resource**

Press `/` and type the resource name.

### **Directly Jump to a Resource**

Press `:` followed by the resource name (e.g., `:pods`).

---

These commands will help you efficiently manage Kubernetes clusters using **KDash**! 🚀
