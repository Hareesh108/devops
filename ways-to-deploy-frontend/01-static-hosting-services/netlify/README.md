# Deploying Next.js Application to Netlify

## **1. Install Netlify CLI (Optional)**

First, install Netlify CLI globally if you haven't already:

```sh
npm install -g netlify-cli
```

---

## **2. Build Your Next.js App**

Netlify requires a static export of your Next.js app:

```sh
npm run build
npm run export
```

This will generate an `out` directory containing the static files.

---

## **3. Deploy via Netlify CLI (Optional)**

If using Netlify CLI, run:

```sh
netlify deploy
```

Follow the prompts to select a site and deploy.

For a production deployment, use:

```sh
netlify deploy --prod
```

---

## **4. Deploy via Netlify Dashboard**

1. Go to [Netlify](https://app.netlify.com/) and log in.
2. Click **New Site from Git**.
3. Connect your GitHub/GitLab/Bitbucket repository.
4. Set build settings:
   - **Build command:** `npm run build && npm run export`
   - **Publish directory:** `out`
5. Click **Deploy Site**.

---

## **5. Set Up Environment Variables (If Needed)**

Go to **Site Settings → Environment Variables** and add required variables:

```
NEXT_PUBLIC_API_URL=https://api.example.com
```

---

## **6. Manage Deployment**

- View deployment logs in **Netlify Dashboard**.
- Set up **automatic deployments** for Git pushes.
- Configure **custom domains** via the **Domains** tab.

---

Your Next.js app is now live on Netlify! 🚀
