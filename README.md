# Investa

Investa is a Rails marketplace where founders publish startup funding listings and investors submit proposals. It uses PostgreSQL, Devise, Pundit, Active Admin, Solid Queue, Solid Cache, and Kamal.

## Requirements

- Ruby 3.3.6 (see `.ruby-version`)
- PostgreSQL
- Node.js and Yarn for frontend assets

## Local setup

1. Install dependencies with `bundle install` and `yarn install`.
2. Create and migrate the local database with `bin/rails db:prepare`.
3. Start the app and asset watcher with `bin/dev`.

The app is available at `http://localhost:3000`. Create an account and choose Founder or Investor; the app directs new accounts to create the corresponding profile.

## Verification

- Run the full test suite with `bin/rails test test:system`.
- Run the Ruby security scan with `bin/brakeman --no-pager`.
- Run the JavaScript dependency audit with `bin/importmap audit`.
- Run lint with `bin/rubocop`.

GitHub Actions runs these checks for pull requests and pushes to `main`.

## Production deployment

The Docker image is configured for production and Kamal is the deployment tool. Before deploying, configure the real server address and public hostname in `config/deploy.yml`, set the image registry account, and provide `RAILS_MASTER_KEY`, `KAMAL_REGISTRY_PASSWORD`, and `INVESTA_DATABASE_PASSWORD` through the deployment secret manager. Configure a reachable PostgreSQL service and mail delivery settings. The current deploy file contains sample host, registry, and server values and must be replaced for the target environment.

Use persistent, backed-up storage for Active Storage uploads. Configure database, upload, and secret backups and test a restore before accepting customer data. Monitor `/up`, application errors, background jobs, database capacity, and email delivery.

## Scope and launch requirements

Investa currently supports listings and proposals; it does not move money, verify investor accreditation or identity, issue securities, or provide transaction documents. Before using it for live securities offerings, have qualified counsel define the jurisdictions and operating model, and implement the required compliance, identity checks, disclosures, payment/custody, audit trail, and investor protections. Proposal acceptance is an allocation record in the app, not a completed or legally binding investment transaction.
