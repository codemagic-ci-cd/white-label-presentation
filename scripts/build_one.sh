CLIENT=001
curl -H "Content-Type: application/json" -H "x-auth-token: $CM_API_KEY" \
      --data '{
          "appId": "66223a303e0f7a4f6aee2380", 
          "workflowId": "ios-client-release",
          "branch": "main",
          "environment": { 
              "variables": { 
                  "CLIENT_ID": "'${CLIENT}'"
              },
              "groups": [
                  "client_'${CLIENT}'"
              ]
          },
          "sshAccessEnabled": true
        }' \
       https://api.codemagic.io/builds



