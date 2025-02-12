# Deploying Next.js Application to Surge

## **1. Install Surge**

First, install Surge globally if you haven't already:

```sh
npm install -g surge
```

---

## **2. Build Your Next.js App**

Since Surge only serves static files, export your Next.js app as static HTML:

```sh
npm run build
npm run export
```

This will generate a `out` directory containing the static files.

---

## **3. Deploy to Surge**

Run the following command in the terminal:

```sh
surge out
```

If you are using Surge for the first time, it will prompt you to create an account or log in.

---

## **4. Set a Custom Domain (Optional)**

If you want to use a custom domain, specify it during deployment:

```sh
surge out your-custom-domain.surge.sh
```

Or configure a custom domain via the **Surge Dashboard**.

---

## **5. Manage Your Deployment**

- View deployed projects: `surge list`
- Remove a deployment: `surge teardown your-custom-domain.surge.sh`

---

Your Next.js app is now live on Surge! 🚀
