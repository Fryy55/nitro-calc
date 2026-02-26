# SIPS_BINARY PNG_PATH GEN_PATH ICONUTIL_BINARY
SIPS_BINARY=$1
PNG_PATH=$2
GEN_PATH=$3
ICONUTIL_BINARY=$4

echo "-- Generating icon.icns"

iconset="$GEN_PATH/icon.iconset"

mkdir $iconset
echo "-- icon.iconset created - $iconset"

for i in 16 32 128 256 512; do
    name="icon_${i}x${i}"

    $SIPS_BINARY -z $i $i $PNG_PATH -o "$iconset/$name.png" > /dev/null
    echo "-- $iconset/$name.png created"
    $SIPS_BINARY -z $((i * 2)) $((i * 2)) $PNG_PATH -o "$iconset/$name@2x.png" > /dev/null
    echo "-- $iconset/$name@2x.png created"
done

echo "-- Packing into icon.icns"
$ICONUTIL_BINARY -c icns $iconset

echo "-- Removing icon.iconset"
rm -rf $iconset

echo "-- icon.icns generated - $GEN_PATH/icon.icns"