# Deploying Next.js Application to Firebase

## **1. Install Firebase CLI**

First, install Firebase CLI globally if you haven't already:

```sh
npm install -g firebase-tools
```

Log in to Firebase:

```sh
firebase login
```

---

## **2. Initialize Firebase in Your Project**

Inside your Next.js project folder, run:

```sh
firebase init hosting
```

Select the following options:

- Choose your Firebase project or create a new one.
- Set the public directory to `out` (for static exports).
- Configure as a single-page app: `No`
- Set up automatic builds and deploys: `No`

---

## **3. Build and Export Your Next.js App**

Firebase only serves static files, so export your Next.js app:

```sh
npm run build
npm run export
```

This generates an `out` directory with static files.

---

## **4. Deploy to Firebase Hosting**

Deploy the exported files to Firebase:

```sh
firebase deploy
```

---

## **5. Access Your Deployed Site**

After deployment, Firebase will provide a URL where your site is hosted, typically:

```
https://your-project-id.web.app/
```

---

## **6. Configure Custom Domain (Optional)**

You can add a custom domain via Firebase Console under **Hosting → Custom Domains**.

---

Your Next.js app is now live on Firebase! 🚀
