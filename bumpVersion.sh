# Extract Version from pubspec.yaml
appVersionName=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f1)
appVersionCode=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f2)

# Bump Version
newAppVersionName=$appVersionName
newAppVersionCode=$(expr $appVersionCode + 1)
echo "Bump Version: $appVersionName+$appVersionCode >> $newAppVersionName+$newAppVersionCode"

old="version: $appVersionName+$appVersionCode"
new="version: $newAppVersionName+$newAppVersionCode"
#echo "$old > $new"

# Replace Version in pubspec.yaml
sed -i '' "s/$old/$new/g" pubspec.yaml