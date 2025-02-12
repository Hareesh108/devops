# Deploying Next.js Application to AWS Amplify

## **1. Set Up AWS Amplify**

1. Go to the [AWS Amplify Console](https://console.aws.amazon.com/amplify/home).
2. Click **Get Started** under **Amplify Hosting**.
3. Select **Host a web app**.

---

## **2. Connect Your Repository**

1. Choose **GitHub, GitLab, or Bitbucket**.
2. Authorize AWS Amplify to access your repository.
3. Select the repository containing your Next.js app.
4. Choose the branch you want to deploy.

---

## **3. Configure Build Settings**

Amplify will detect your Next.js project and provide default build settings.
Ensure your `amplify.yml` file looks like this:

```yaml
version: 1
applications:
  - frontend:
      phases:
        preBuild:
          commands:
            - npm install
        build:
          commands:
            - npm run build
            - npm run export
      artifacts:
        baseDirectory: out
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**
```

Click **Next** and then **Deploy**.

---

## **4. Configure Custom Domain (Optional)**

1. In the Amplify Console, navigate to **Domain Management**.
2. Click **Add Domain** and enter your custom domain.
3. Update your DNS settings as instructed.

---

## **5. Manage Deployments**

- **Automatic Deployments:** Amplify automatically deploys changes from the selected branch.
- **Manual Deployments:** Trigger deployments from the Amplify console.

---

## **6. Access Your Live App**

Once the deployment is complete, Amplify will provide a URL like:

```
https://your-app.amplifyapp.com/
```

---

Your Next.js app is now live on AWS Amplify! 🚀
