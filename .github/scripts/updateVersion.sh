# Extract Version from pubspec.yaml
appVersionName=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f1)
appVersionCode=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f2)

# Bump Version
newAppVersionName=$1
echo "Bump Version: $appVersionName+$appVersionCode >> $newAppVersionName+$appVersionCode"

old="version: $appVersionName+$appVersionCode"
new="version: $newAppVersionName+$appVersionCode"
#echo "$old > $new"

# Replace Version in pubspec.yaml
sed -i "s/$old/$new/g" pubspec.yaml
# --> MacOS
# sed -i '' "s/$old/$new/g" pubspec.yaml
git add pubspec.yaml