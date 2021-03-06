#! /bin/sh 

if [ "$#" -ne 1 ] ; then
  echo "Usage: $0 signing_identity" >&2
  exit 1
fi

signing_identity=$1
echo "Signing Identify set as: '$signing_identity'"

rm -Rf target/
mkdir target
cp -R apps target/
pushd target/
find . -name .DS_Store -delete
find . -name *~ -delete
popd

echo "Signing with developer id using provided Signing Identity"
export CODESIGN_ALLOCATE="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/codesign_allocate" 

# shell script
codesign -s "$signing_identity" -v target/apps/shell-script/HelloWorld.app/
OUT=$?

if [ $OUT -eq 0 ];then
    echo "developer id signing completed successfully."
else
    echo "developer id signing failed, failing build."
    exit $OUT
fi

# objective c
codesign -s "$signing_identity" -v target/apps/objective-c/HelloWorld.app/
OUT=$?

if [ $OUT -eq 0 ];then
    echo "developer id signing completed successfully."
else
    echo "developer id signing failed, failing build."
    exit $OUT
fi

