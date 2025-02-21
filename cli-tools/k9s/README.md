# K9s Tool Commands with Examples

## k9s (Kubernetes TUI)

- A terminal-based UI for Kubernetes.
- Provides a live, interactive way to manage cluster resources.
- Offers better visibility than plain kubectl commands.

## 1. Basic Commands

### **Launch K9s**

```sh
k9s
```

**Example:** Opens K9s with the default Kubernetes context.

### **Launch K9s in a Specific Namespace**

```sh
k9s -n dev
```

**Example:** Opens K9s and focuses on the `dev` namespace.

### **Launch K9s with a Specific Kubernetes Context**

```sh
k9s --context my-cluster
```

**Example:** Opens K9s using the `my-cluster` context.

### **Quit K9s**

```sh
:q
```

**Or press:** `Ctrl+C`

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

```sh
:po
```

**Example:** Opens the Pods view.

### **View Deployments**

```sh
:deploy
```

**Example:** Opens the Deployments list.

### **View Services**

```sh
:svc
```

**Example:** Opens the Services list.

### **View Namespaces**

```sh
:ns
```

**Example:** Lists all namespaces.

### **View ConfigMaps**

```sh
:cm
```

**Example:** Opens the ConfigMaps list.

### **View Secrets**

```sh
:secrets
```

**Example:** Lists Kubernetes Secrets.

---

## 4. Pod Actions

### **Describe a Pod**

Press `d` on a selected pod.  
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

Press `s` on a selected pod.  
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

These commands will help you efficiently manage Kubernetes clusters using **K9s**! 🚀
