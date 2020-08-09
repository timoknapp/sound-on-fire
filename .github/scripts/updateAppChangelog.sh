appVersionName=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f1)
appVersionCode=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f2)

oldVersionName=$(cat app-update-changelog.json | grep \"latestVersion\": | cut -d ':' -f2 | sed 's/\,//g' | sed 's/\"//g' | sed 's/\ //g' )
oldVersionCode=$(cat app-update-changelog.json | grep \"latestVersionCode\": | cut -d ':' -f2 | sed 's/\,//g' | sed 's/\ //g' )
# oldURL=$(cat app-update-changelog.json | grep \"url\":)
# oldVersionEncoded="$oldVersionName%2B$oldVersionCode"

newVersionName="v$appVersionName"
newVersionCode="$appVersionCode"
# newVersionEncoded="v$appVersionName%2B$appVersionCode"
# newURL=$($oldURL | sed 's#$oldVersionEncoded')

echo "Update Changelog:"
echo "$oldVersionName >> $newVersionName"
echo "$oldVersionCode >> $newVersionCode"

# Replace Version in pubspec.yaml
sed -i "s/$oldVersionName/$newVersionName/g" app-update-changelog.json
sed -i "s/$oldVersionCode/$newVersionCode/g" app-update-changelog.json
## sed -i "s#$oldURL#$newURL#g" app-update-changelog.json
## --> MacOS
# sed -i '' "s/$oldVersionName/$newVersionName/g" app-update-changelog.json
# sed -i '' "s/$oldVersionCode/$newVersionCode/g" app-update-changelog.json
## sed -i '' "s#$oldURL#$newURL#g" app-update-changelog.json
git add app-update-changelog.json