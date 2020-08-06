appVersionName=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f1)
appVersionCode=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f2)

oldVersionName=$(cat app-update-changelog.json | grep \"latestVersion\": | cut -d ':' -f2)
oldVersionCode=$(cat app-update-changelog.json | grep \"latestVersionCode\": | cut -d ':' -f2)
oldURL=$(cat app-update-changelog.json | grep \"url\":)

newVersionName=" \"v$appVersionName\","
newVersionCode=" $appVersionCode,"
newURL="    \"url\": \"$1\","
echo "Update Changelog:"
echo "$oldVersionName >> $newVersionName"
echo "$oldVersionCode >> $newVersionCode"
echo "$oldURL >> $newURL"

# Replace Version in pubspec.yaml
sed -i "s/$oldVersionName/$newVersionName/g" app-update-changelog.json
sed -i "s/$oldVersionCode/$newVersionCode/g" app-update-changelog.json
sed -i "s#$oldURL#$newURL#g" app-update-changelog.json
## --> MacOS
#sed -i '' "s/$oldVersionName/$newVersionName/g" app-update-changelog.json
#sed -i '' "s/$oldVersionCode/$newVersionCode/g" app-update-changelog.json
#sed -i '' "s#$oldURL#$newURL#g" app-update-changelog.json
git add app-update-changelog.json