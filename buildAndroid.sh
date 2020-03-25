# Extract Version from pubspec.yaml
appVersionName=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f1)
appVersionCode=$(cat pubspec.yaml | grep "version: " | cut -d ' ' -f2 | cut -d '+' -f2)
archiveName="SoundOnFire-v$appVersionName+$appVersionCode"
fileType=".apk"
path="build/app/outputs/apk"

echo "Build .apk as artifact-type: $1 | $archiveName"

# Build .apk with flutter command
path="$path/$1"
flutter build apk "--$1"
fileName=$path/$archiveName-$1$fileType
# Rename artifact
mv -f "$path/app-$1.apk" "$fileName"
echo "Moved: $fileName"
echo $fileName > tmp_artifact_path.txt
