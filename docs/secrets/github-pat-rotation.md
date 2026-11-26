# PLATFORM_GH_TOKEN rotation

`PLATFORM_GH_TOKEN` is a fine-grained GitHub PAT stored as an org secret. It is used by OpenTofu workflows to manage GitHub org resources — creating repositories, configuring branch and tag rulesets, adding environments, and granting repos access to org secrets.

There is no automated rotation. This is a manual process.

## When to rotate

- Before the token's expiry date
- Any time the token may have been exposed

## Creating a new token

1. Go to [**GitHub Settings → Developer Settings → Personal access tokens → Fine-grained tokens → Generate new token**](https://github.com/settings/personal-access-tokens)
2. Set the name to `arsdehnel-platform-github-token`
3. Set the expiry to 60 days
4. Set **Resource owner** to `arsdehnel`
5. Set **Repository access** to **All repositories** (required because the token is used to create new repos)
6. Grant the following permissions:

   **Repository permissions**

   | Permission     | Level          |
   | -------------- | -------------- |
   | Administration | Read and Write |

   **Organization permissions**

   | Permission | Level          |
   | ---------- | -------------- |
   | Members    | Read           |
   | Secrets    | Read and Write |

7. Generate and copy the token value

## Rolling an existing token

1. Go to [**GitHub Settings → Developer Settings → Personal access tokens → Fine-grained tokens**](https://github.com/settings/personal-access-tokens)
2. Click the existing `arsdehnel-platform-github-token` token in the list (if it does not exist see above for the process to create a new token)
3. Generate and copy the token value

## Updating the org secret

1. Go to [**GitHub → arsdehnel → Settings → Secrets and variables → Actions**](https://github.com/organizations/arsdehnel/settings/secrets/actions/PLATFORM_GH_TOKEN)
2. Find `PLATFORM_GH_TOKEN` and click **Update**
3. Paste the new token value and save
