# Deploying Next.js Application to Vercel

## **1. Install Vercel CLI**

First, install the Vercel CLI globally if you haven't already:

```sh
npm install -g vercel
```

---

## **2. Log in to Vercel**

Authenticate with your Vercel account:

```sh
vercel login
```

Follow the instructions in the terminal to log in.

---

## **3. Initialize the Deployment**

Inside your Next.js project root directory, run:

```sh
vercel
```

Vercel will detect your Next.js app and prompt you for configuration options. You can accept the defaults or customize as needed.

---

## **4. Set Environment Variables (Optional)**

If your app requires environment variables, add them using:

```sh
vercel env add VARIABLE_NAME value
```

Or set them in the **Vercel Dashboard** under your project settings.

---

## **5. Deploy to Production**

Once everything is set up, deploy your app to production:

```sh
vercel --prod
```

This will deploy your app and provide a live URL.

---

## **6. Automatic Deployments with GitHub/GitLab/Bitbucket**

To enable automatic deployments, connect your repository to Vercel:

1. Go to [Vercel Dashboard](https://vercel.com/dashboard).
2. Click **New Project**.
3. Select your GitHub/GitLab/Bitbucket repository.
4. Configure settings and click **Deploy**.

Vercel will automatically deploy new changes when you push to your repository.

---

## **7. Manage Your Deployment**

- View deployments: `vercel ls`
- Remove a deployment: `vercel remove <deployment-name>`
- Rollback to a previous version: `vercel rollback`

---

Your Next.js app is now live on Vercel! 🚀
