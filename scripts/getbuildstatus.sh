  curl -H "Content-Type: application/json" \
       -H "x-auth-token: $CM_API_KEY" \
       --request GET "https://api.codemagic.io/builds/$BUILD_ID"
