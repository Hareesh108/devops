# Deploying Next.js Application to GitHub Pages

## **1. Install Dependencies**

Ensure you have `next`, `react`, and `react-dom` installed, then install `gh-pages`:

```sh
npm install gh-pages --save-dev
```

---

## **2. Update `next.config.js`**

Modify your `next.config.js` to set the `basePath` and `assetPrefix`:

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

## **3. Add Deployment Scripts**

Modify `package.json` to include deploy scripts:

```json
"scripts": {
  "build": "next build && next export",
  "deploy": "npm run build && gh-pages -d out"
}
```

---

## **4. Build and Deploy**

Run the following command to deploy your app:

```sh
npm run deploy
```

This will push the exported files to the `gh-pages` branch of your repository.

---

## **5. Enable GitHub Pages**

1. Go to your GitHub repository.
2. Navigate to **Settings** → **Pages**.
3. Select `gh-pages` as the source.
4. Save and wait for the deployment to go live.

---

## **6. Access Your Deployed Site**

Your site will be available at:

```
https://your-username.github.io/your-repo-name/
```

Replace `your-username` and `your-repo-name` accordingly.

---

Your Next.js app is now live on GitHub Pages! 🚀
