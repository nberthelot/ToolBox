set -e
if [ -z "$1" ] ; then
	echo "missing version parameter"
	exit 1
fi

VERSION="$1"
PODSPECS=( *.podspec )
POD_SPEC="${PODSPECS[0]}"

if [ ! -f "$POD_SPEC" ] ; then
  echo "missing podspec file"
  exit 2
fi

sed -i '' "s/s.version[ ]*=[ ]*'[0-9]*.[0-9]*.[0-9]*'/s.version          = \'$VERSION\'/g" $POD_SPEC

pod lib lint 
git add -A && git commit -m "Release $VERSION."
git tag $VERSION
git push --tags
git push
pod trunk push $POD_SPEC
