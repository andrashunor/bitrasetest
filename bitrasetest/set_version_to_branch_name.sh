git=$(sh /etc/profile; which git)
branch_name=$("$git" rev-parse --abbrev-ref HEAD) #extract branch name of HEAD
version=${branch_name%.*} # String before last "." character
version=${version#*/v}  # String after first "/v" (cuts "release/v" from beginning)
build=${branch_name##*.} # String after last "." character

# Set values on Info.plist at path
plist_path="./bitrasetest/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $build" $plist_path
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $version" $plist_path

# Commit changes
commit_message="Increased build number"

if [ $build = 1 ]
then
    commit_message="Increased version number"
fi

git add "bitrasetest/Info.plist"
git commit -m $commit_message