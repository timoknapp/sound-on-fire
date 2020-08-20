# Extract Version from pubspec.yaml
appVersionName=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f1)
appVersionCode=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f2)
fileType=".apk"
archiveName="SoundOnFire-v$appVersionName+$appVersionCode-$1$fileType"
path="build/app/outputs/apk/release"

echo "Build .apk as artifact-type: $1 | $archiveName"

# TODO: replace keystore pw and alias in android/key.properties
ksPw="${{ secrets.KEYSTORE_PASSWORD }}"
keyPW="${{ secrets.KEY_PASSWORD }}"
keyAlias="${{ secrets.KEY_ALIAS }}"
sed -i "s/KEYSTORE_PASSWORD/$ksPw/g" android/key.properties
sed -i "s/KEY_PASSWORD/$keyPW/g" android/key.properties
sed -i "s/KEY_ALIAS/$keyAlias/g" android/key.properties

# Build .apk with flutter command
flutter pub get
flutter build apk
fileName=$path/$archiveName

# Rename artifact
mv -f "$path/app-release.apk" "$fileName"
echo "Moved: $fileName"
echo $fileName > tmp_artifact_path.txt
echo $archiveName > tmp_artifact_name.txt
