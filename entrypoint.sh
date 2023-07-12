var="./${crud_firebase}/build/outputs/apk/release/*-release.apk"
local="$(find  -wholename $var)"
echo $local
curl -F "file=@$local" \
        -F "uKey=${uKey}" \
        -F "_api_key=${apiKey}" \
        https://www.pgyer.com/apiv1/app/upload