set -e

FLUTTER="$HOME/.local/opt/flutter/bin/flutter"
AURORA_PSDK="$HOME/AuroraPlatformSDK/sdks/aurora_psdk/sdk-chroot"
APP_NAME=com.qwert2603.marks_counter
APP_VERSION="0.1.0-1"
APP_FILE="$APP_NAME-$APP_VERSION.armv7hl.rpm"
DEVICE_USER=defaultuser
DEVICE_HOST=192.168.2.16
KEY_FILE="$HOME/AuroraPlatformSDK/regular_key.pem"
CERT_FILE="$HOME/AuroraPlatformSDK/regular_cert.pem"
PASSWORD=<ADD_HERE>

$FLUTTER --version
$FLUTTER build aurora --release

cd ./build/aurora/aurora-arm/release/RPMS/

$AURORA_PSDK rpmsign-external sign --key $KEY_FILE --cert $CERT_FILE $APP_FILE

scp $APP_FILE "$DEVICE_USER@$DEVICE_HOST:~/Downloads"

ssh "$DEVICE_USER@$DEVICE_HOST" "echo $PASSWORD | devel-su rpm -ih --force ~/Downloads/$APP_FILE"
ssh "$DEVICE_USER@$DEVICE_HOST" "rm ~/Downloads/$APP_FILE"
ssh "$DEVICE_USER@$DEVICE_HOST" "/usr/bin/$APP_NAME"