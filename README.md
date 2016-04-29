# shellscriptsigning
Mac Application bundle and associated signing script to demo possible bug in OS X 10.11


To run:

./sign_app.sh "Developer ID Application: My Id"

To verify:

codesign -vv target/apps/shell-script/HelloWorld.app/
codesign -vv target/apps/objective-c/HelloWorld.app/

It should say:

HelloWorld.app: valid on disk
HelloWorld.app: satisfies its Designated Requirement

But in the bad case says:

HelloWorld.app: invalid signature (code or signature have been modified)