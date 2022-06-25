# Extract Version from pubspec.yaml
appVersionName=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f1)
appVersionCode=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f2)
fileType=".apk"
archiveName="SoundOnFire-v$appVersionName+$appVersionCode-$1$fileType"
archiveNameLatest="SoundOnFire-latest.apk"
path="build/app/outputs/apk/release"

echo "Build .apk as artifact-type: $1 | $archiveName"

ksPw="$2"  
keyPW="$3"
keyAlias="$4"
appCenterSecret="$5"
sed -i "s/KEYSTORE_PASSWORD/$ksPw/g" android/key.properties
sed -i "s/KEY_PASSWORD/$keyPW/g" android/key.properties
sed -i "s/KEY_ALIAS/$keyAlias/g" android/key.properties
sed -i "s/APP_CENTER_SECRET/$appCenterSecret/g" android/app/src/main/kotlin/com/example/sound_on_fire/MainActivity.kt

# Build .apk with flutter command
flutter pub get --ignore-deprecation
flutter build apk --ignore-deprecation
fileName=$path/$archiveName

# Rename artifact
cp "$path/app-release.apk" "$path/$archiveNameLatest"
mv -f "$path/app-release.apk" "$fileName"
echo "Moved: $fileName"
echo $fileName > tmp_artifact_path.txt
echo $archiveName > tmp_artifact_name.txt
echo "$path/$archiveNameLatest" > tmp_artifact_path_latest.txt
echo $archiveNameLatest > tmp_artifact_name_latest.txt
