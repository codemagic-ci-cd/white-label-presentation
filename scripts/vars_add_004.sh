##
APP_ID=codemagicappid

## Client 004

CLIENT=004
PRIVATE_KEY=$(awk 1 ORS='\\n' client_001/ios_dist_key_001)
AUTH_KEY=$(awk 1 ORS='\\n' client_001/auth_key_001.p8)

## FONT_FAMILY
echo
echo "Adding FONT_FAMILY: client_$CLIENT"
curl -XPOST \
    -H "x-auth-token: $CM_API_KEY" \
    -H "Content-type: application/json" \
    -d '{
        "key": "FONT_FAMILY",
        "value": "OpenSans",
        "group": "client_'${CLIENT}'",
        "secure": false
    }' \
    "https://api.codemagic.io/apps/$APP_ID/variables"
echo

## APP_NAME
echo
echo "Adding APP_NAME: client_$CLIENT"
curl -XPOST \
    -H "x-auth-token: $CM_API_KEY" \
    -H "Content-type: application/json" \
    -d '{
        "key": "APP_NAME",
        "value": "WL-004",
        "group": "client_'${CLIENT}'",
        "secure": false
    }' \
    "https://api.codemagic.io/apps/$APP_ID/variables"
echo

## BUNDLE_ID
echo
echo "Adding BUNDLE_ID: client_$CLIENT"
curl -XPOST \
    -H "x-auth-token: $CM_API_KEY" \
    -H "Content-type: application/json" \
    -d '{
        "key": "BUNDLE_ID",
        "value": "bundle_id",
        "group": "client_'${CLIENT}'",
        "secure": false
    }' \
    "https://api.codemagic.io/apps/$APP_ID/variables"
echo

## APP_STORE_ID
echo
echo "Adding APP_STORE_ID: client_$CLIENT"
curl -XPOST \
    -H "x-auth-token: $CM_API_KEY" \
    -H "Content-type: application/json" \
    -d '{
        "key": "APP_STORE_ID",
        "value": "app_store_id",
        "group": "client_'${CLIENT}'",
        "secure": false
    }' \
    "https://api.codemagic.io/apps/$APP_ID/variables"
echo


## APP_STORE_CONNECT_ISSUER_ID
echo
echo "Adding APP_STORE_CONNECT_ISSUER_ID: client_$CLIENT"
curl -XPOST \
    -H "x-auth-token: $CM_API_KEY" \
    -H "Content-type: application/json" \
    -d '{
        "key": "APP_STORE_CONNECT_ISSUER_ID",
        "value": "isuer id",
        "group": "client_'${CLIENT}'",
        "secure": true
    }' \
    "https://api.codemagic.io/apps/$APP_ID/variables"
echo

## APP_STORE_CONNECT_KEY_IDENTIFIER
echo
echo "Adding APP_STORE_CONNECT_KEY_IDENTIFIER: client_$CLIENT"
curl -XPOST \
-H "x-auth-token: $CM_API_KEY" \
-H "Content-type: application/json" \
-d '{
    "key": "APP_STORE_CONNECT_KEY_IDENTIFIER",
    "value": "Key Identifier goes",
    "group": "client_'${CLIENT}'",
    "secure": true
}' \
"https://api.codemagic.io/apps/$APP_ID/variables"
echo

## APP_STORE_CONNECT_PRIVATE_KEY
echo
echo "Adding APP_STORE_CONNECT_PRIVATE_KEY: client_$CLIENT"
curl -XPOST \
    -H "x-auth-token: $CM_API_KEY" \
    -H 'Content-Type: application/json;charset=utf-8' \
    -d "{
    \"key\":\"APP_STORE_CONNECT_PRIVATE_KEY\",
    \"value\":\"$AUTH_KEY\", 
    \"group\":\"client_$CLIENT\", 
    \"secure\": true
    }" \
    "https://api.codemagic.io/apps/$APP_ID/variables"
echo

## CERTIFICATE_PRIVATE_KEY
echo
echo "Adding CERTIFICATE_PRIVATE_KEY: client_$CLIENT"
curl -XPOST -H "x-auth-token: $CM_API_KEY" \
    -H 'Content-Type: application/json;charset=utf-8' \
    -d "{
    \"key\":\"CERTIFICATE_PRIVATE_KEY\",
    \"value\":\"$PRIVATE_KEY\", 
    \"group\":\"client_$CLIENT\", 
    \"secure\": true
    }" \
    "https://api.codemagic.io/apps/$APP_ID/variables"
echo


