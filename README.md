# White label sample project for Flutter

This sample shows how to white-label your core version of a Flutter app without the need to create multiple workflows.

## Overview of white labeling with Codemagic

When you white-label your app with Codemagic you can use a single workflow to build different versions of your app. Each build is started with the Codemagic REST API which allows you to provide the unique variables required for each version.

To get an overview of how you can white-label your mobile apps with Codemagic, please refer to the overview provided in the documentation [here](https://docs.codemagic.io/knowledge-white-label/white-label-apps-overview/).

The majority of white label automation is done using shell scripts to perform tasks such as downloading assets, copying files such as logos, images, fonts, etc. to a new location, or changing string values in projects. Please refer to the white labeling scripts samples in the Codemagic documentation [here](https://docs.codemagic.io/knowledge-white-label/white-label-scripts/).

Let's assume that you have the following:

- A zip archive for each customer that contains their unique assets and uses a unique identifier in the file name for each customer, e.g. `assets_001.zip` for client `001`.
- All the customers’ archive files are saved in a secure environemt e.g.(S3/GCP bucket, or headless CMS). 
- Each customer zip archive has the following files with this naming convention:
    - **`ios_assets/`**. This folder contains the iOS icons from `/ios/Runner/Assets.xcassets/AppIcon.appiconset/`.
    - **`android_assets/`**. This folder contains the Android icons from `/android/app/src/main/res/`.

## Adding clients' environment variables
You need to create a separate environment variable group for each of your clients with a unique name e.g. **`WL_CLIENT_ID`**.

This group might contain the following environment variables:
- Android app name. `APP_NAME`.
- Android package name. `PACKAGE_NAME`.
- Android Keystore information. `CM_KEYSTORE` (base64 encoded), `CM_KEY_ALIAS`, `CM_KEY_PASSWORD`, `CM_KEYSTORE_PASSWORD`, `CM_KEYSTORE_PATH`.
- The content of the Google Cloud service JSON file to publish to Play Store. `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS`.
- iOS app details. `APP_STORE_ID`, `BUNDLE_ID`.
- App Store Connect credentials. `APP_STORE_CONNECT_KEY_IDENTIFIER`, `APP_STORE_CONNECT_ISSUER_ID`, `APP_STORE_CONNECT_PRIVATE_KEY`, `CERTIFICATE_PRIVATE_KEY`.
- **.env** file if your app uses some secrets at runtime. `DOTENV` (base64 encoded).

To add these values you can either use the [Codemagic UI](https://docs.codemagic.io/yaml-basic-configuration/configuring-environment-variables/#configuring-environment-variables) or use the Codemagic [REST API](https://docs.codemagic.io/rest-api/codemagic-rest-api/) to do it if you have a huge number of customers.

### Request endpoint
The requested URL for dealing with apps variables is: `https://api.codemagic.io/apps/<app-id>/variables`.

To get the appId, open your Codemagic application, open its settings, and copy the **application id** from the browser address bar - `https://codemagic.io/app/<APP_ID>/settings`.
### Request headers
To authorize your request you need to pass the `API access token`, which is available in the Codemagic UI under **Teams > Personal Account > Integrations > Codemagic API > Show**. 
```bash
{
    "x-auth-token: <your-auth-token>"
}
```
### Request body
In the request body you need to pass the following:
1. `appId`. Once you have added your app in Codemagic, open its settings and copy the **application id** from the browser address bar - `https://codemagic.io/app/<APP_ID>/settings`
2. `workflowId`. The name of the workflow in your `codemagic.yaml` file.
3. `branch`. The name of the branch you want Codemagic to build from.
4. `environment`. This object holds the `variables` object which has the `variables` you need to pass to the workflow. In our example, it's required to pass the `client Id` so our workflow can identify the client we're building for.
```bash
{
    "key": "<variable-name>",
    "value": "<variable-value>"
    "group": "<client-unique-group-name>",
    "secure": true
}
```

### Using cURL
This is the cURL command to add a simple variable:
```bash
curl -XPOST \
    -H 'x-auth-token: <API-TOKEN>' \
    -H "Content-type: application/json" \
    -d '{
        "key": "FOO",
        "value": "foobar",
        "group": "production",
        "secure": true
    }' \
    'https://api.codemagic.io/apps/<app-id>/variables'
```

### Uploading the encoded Android keystore
This is the cURL command to base64 encode a file and then upload its value e.g. uploading the android keystore:
```bash
curl -XPOST -H 'x-auth-token: <API-TOKEN>' \
     -H 'Content-Type: application/json;charset=utf-8' \
     -d "{
         \"key\": \"CM_KEYSTORE\",
     \"value\": \"$(cat whitelabel001.keystore | base64)\",
     \"group\":\"WL_CLIENT_001\",
     \"secure\": true
     }" \
     'https://api.codemagic.io/apps/<app-id>/variables'
```
### Uploading the content of GCloud JSON file
This is the cURL command to upload the content of the Google Cloud service JSON file.
```bash
curl -XPOST -H 'x-auth-token: <API-KEY>' \
     -H 'Content-Type: application/json;charset=utf-8' \
     -d "{
     \"key\": \"GCLOUD_SERVICE_ACCOUNT_CREDENTIALS\",
     \"value\": \"$(cat gcloud.json | tr -d '\n' | sed -e 's/\\n/\\\\n\\\\n/g' -e 's/\"/\\\"/g' )\",
     \"group\":\"WL_CLIENT_001\",
     \"secure\": true
     }" \
     'https://api.codemagic.io/apps/<app-id>/variables'
```


## Triggering builds
The Codemagic [REST API](https://docs.codemagic.io/rest-api/codemagic-rest-api/) is used in a white-label workflow to trigger builds for each unique client version you need to build, and the unique client environment group name that holds all the client secrets. 

### Request endpoint
The requested URL for dealing with the builds is: `https://api.codemagic.io/builds`
### Request headers
To authorize your request you need to pass the `API access token`, which is available in the Codemagic UI under **Teams > Personal Account > Integrations > Codemagic API > Show**. 
```bash
{
    "x-auth-token: <your-auth-token>"
}
```
### Request body
In the request body you need to pass the following:
1. `appId`. Once you have added your app in Codemagic, open its settings and copy the **application id** from the browser address bar - `https://codemagic.io/app/<APP_ID>/settings`
2. `workflowId`. The name of the workflow in your `codemagic.yaml` file.
3. `branch`. The name of the branch you want Codemagic to build from.
4. `environment`. This object holds the `variables` object which has the variables you need to pass to the workflow, and `groups` list which has the environment variable group name you want to use in this build.
In our example, it's required to pass the `client Id` and `group name` so our workflow can identify the client we're building for and use the correct credentials.



```bash
{
    "appId": "<your-codemagic-app-id>", 
    "workflowId": "<your-codemagic-workflow-id>",
    "branch": "<branch-name>",
    "environment": { 
        "variables": { 
            "CLIENT_ID": "<your-client-id>"
        },
        "groups": [
            "<your-client-group-name>"
        ]
    }
}
```

### Using cURL
This is the cURL command to trigger a new build:
```jsx
curl -H "Content-Type: application/json" -H "x-auth-token: <your-auth-token>" \
      --data '{
          "appId": "<your-codemagic-app-id>", 
          "workflowId": "<your-codemagic-workflow-id>",
          "branch": "<branch-name>",
          "environment": { 
              "variables": { 
                  "CLIENT_ID": "<your-client-id>"
              },
              "groups": [
                  "<your-client-group-name>"
              ]
          }
        }' \
       https://api.codemagic.io/builds
```

## Branching and workflow strategies

There are many approaches to white labeling and setting up workflows. If you haven't already decided on your strategy, you can use our suggested approach which can be found in the documentation [here](https://docs.codemagic.io/knowledge-white-label/white-label-branching-strategies/).

## Definitions and anchors
Check out [this](https://github.com/codemagic-ci-cd/white-label-demo-project/tree/anchors) branch to see how you can use anchors in your `codemagic.yaml` file if you have multiple workflows and you want to avoid repetitions.