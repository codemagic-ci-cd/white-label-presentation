APP_ID=Codemagicappid

VARS=$(curl -XGET \
    -H "X-Auth-Token: $CM_API_KEY" \
    -H "Content-type: application/json" \
    "https://api.codemagic.io/apps/$APP_ID/variables")




IDS=$(echo "$VARS" | jq -r '.[].id')


for ID in $IDS; do
    echo "Deleting variable with id: $ID"
    
    curl -XDELETE \
       -H "X-Auth-Token: $CM_API_KEY" \
       -H "Content-type: application/json" \
       "https://api.codemagic.io/apps/$APP_ID/variables/$ID"
    
    echo # New line for readability
done
