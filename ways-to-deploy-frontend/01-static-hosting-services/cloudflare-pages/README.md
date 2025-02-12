# Deploying Next.js Application to Cloudflare Pages

## **1. Create a Cloudflare Account**

Go to [Cloudflare](https://dash.cloudflare.com/) and sign up or log in.

---

## **2. Create a New Project**

1. Navigate to **Pages** in the Cloudflare dashboard.
2. Click **Create a Project**.
3. Choose **Connect to GitHub** and select your Next.js repository.

---

## **3. Configure Build Settings**

- **Build command:**

  ```sh
  npm install && npm run build
  ```

- **Output directory:** `out`

Ensure `next.config.js` is set to use static export:

```js
const isProd = process.env.NODE_ENV === 'production';

module.exports = {
  output: 'export',
  basePath: isProd ? '/your-repo-name' : '',
  assetPrefix: isProd ? '/your-repo-name/' : '',
};
```

Replace `'your-repo-name'` with your actual repository name.

---

## **4. Set Environment Variables (If Needed)**

Go to **Settings → Environment Variables** and add required variables:

```
NEXT_PUBLIC_API_URL=https://api.example.com
```

---

## **5. Deploy Your Application**

1. Click **Save and Deploy**.
2. Cloudflare Pages will automatically build and deploy your Next.js app.

---

## **6. Manage Deployment**

- View build logs in the **Deployments** section.
- Set up **custom domains** via the **Custom Domains** tab.
- Enable **automatic deployments** for Git commits.

---

Your Next.js app is now live on Cloudflare Pages! 🚀
