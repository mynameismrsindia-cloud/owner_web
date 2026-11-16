# Owner Web

Independent Flutter Web application copied from the Owner Desktop app. It
retains the existing Owner UI, screens, API calls, authentication flow,
inventory and seller-order logic, and invoice generation. The Windows Desktop
project remains separate and unchanged.

## Run locally

Install Flutter, then from this directory run:

```sh
flutter pub get
flutter run -d chrome --dart-define=API_BASE_URL=https://wholesellerbackend-production.up.railway.app/api/v1
```

Chrome and Edge can be used as browser targets. To build production assets:

```sh
flutter build web --release --dart-define=API_BASE_URL=https://wholesellerbackend-production.up.railway.app/api/v1
```

Deploy the contents of `build/web` to an HTTPS static host such as Cloudflare
Pages. The `Build owner Web` GitHub Actions workflow also builds and uploads
these files as the `owner-web` artifact. Set the repository variable
`PRODUCTION_API_BASE_URL` to override the default API URL.

## API CORS setup

The API already supports an exact-origin CORS allowlist through the
`CORS_ORIGINS` Railway service variable. After deploying this site, set it to
the site's origin, for example `https://your-project.pages.dev` (scheme and
host only; no path or trailing slash), then redeploy the API. For multiple
trusted web apps, use comma-separated origins. Do not use `*`. No backend code
or business logic was changed for this web app.

## Browser session security

The app does not write passwords or refresh tokens to localStorage,
sessionStorage, cookies, or IndexedDB. They remain in volatile memory only.
This avoids persistent bearer credentials in browser storage, but means a
page reload, browser restart, or new tab requires signing in again. The
existing “Remember password” option lasts only until that page is reloaded or
closed. Serve the app only over HTTPS (localhost is suitable for development).

Persistent browser sessions require a backend change to issue and rotate
refresh tokens in `HttpOnly`, `Secure`, `SameSite` cookies with narrowly
configured credentialed CORS and CSRF protections. That change is intentionally
not included; the API currently returns refresh tokens in JSON and uses
credential-free CORS.

## Validation and manual checks

Run `flutter pub get`, `flutter analyze`, `flutter test`, and the production
web build command above. Verify login, product add/edit/restock, seller orders,
quantities, date sorting, order approval, invoice PDF download, logout, and
session expiry against the deployed API in both Chrome and Edge. Cross-origin
requests require the deployed site's exact origin in Railway `CORS_ORIGINS`.
