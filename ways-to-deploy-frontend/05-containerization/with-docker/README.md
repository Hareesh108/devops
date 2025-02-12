# Deploying Next.js Application with Docker

## **1. Create a `Dockerfile`**

Create a `Dockerfile` in your Next.js project root:

```dockerfile
FROM node:18-alpine
WORKDIR /src/user/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]# Use an official Node.js runtime as a parent image
FROM node:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .

# Build your Next.js app for production
RUN npm run build

# Start the application
CMD ["npm", "start"]
```

---

## **2. Create a `.dockerignore` file**

Exclude unnecessary files from the Docker image by creating a `.dockerignore` file:

```plaintext
node_modules
.next/cache
*.log
.DS_Store
.env
```

---

## **3. Build the Docker Image**

Run the following command in the terminal:

```sh
docker build -t nextjs-app .
```

---

## **4. Run the Docker Container**

Start the container using:

```sh
docker run -p 3000:3000 nextjs-app
```

Your Next.js app should now be running at **`http://localhost:3000`** 🚀

---

## **5. Deploy to a Cloud Provider (Optional)**

You can deploy your containerized Next.js app to a cloud provider using:

- **AWS ECS**
- **Google Cloud Run**
- **DigitalOcean App Platform**
- **Kubernetes (K8s)**
- **Docker Compose for multi-container setups**
