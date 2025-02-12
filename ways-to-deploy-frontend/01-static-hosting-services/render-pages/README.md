# Deploying Next.js Application to Render

## **1. Create a Render Account**

Go to [Render](https://render.com/) and sign up or log in.

---

## **2. Create a New Web Service**

1. Click **New** → **Web Service**.
2. Connect your **GitHub/GitLab** repository or deploy manually.
3. Select your Next.js repository.

---

## **3. Configure Build & Start Commands**

- **Build Command:**

  ```sh
  npm install && npm run build
  ```

- **Start Command:**

  ```sh
  npm run start
  ```

---

## **4. Set Environment Variables (If Needed)**

Go to **Environment** settings and add required variables, e.g.,

```
NEXT_PUBLIC_API_URL=https://api.example.com
```

---

## **5. Deploy Your App**

Click **Create Web Service**, and Render will start building and deploying your Next.js app.

---

## **6. Manage Deployment**

- View logs in the **Logs** tab.
- Redeploy manually using the **Manual Deploy** option.
- Set up **Automatic Deployments** for Git pushes.

---

Your Next.js app is now live on Render! 🚀
