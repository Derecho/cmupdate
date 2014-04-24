# cmupdate

Update.zip generator for applying changes to CyanogenMod 10.2 according to personal preference.

## Disclaimer
This small project has been created for personal use to make it easy to create an update.zip file that you can apply to your device after fresh rom.
I will not provide support for this project, use it at your own risk.
Tested with CyanogenMod 10.2 on the Motorola Photon Q (xt897).

## Instructions
Adjust apps to be included at the top of the Makefile, and run `make`.
You can use the -j flag to speed up the download process (apps will be simultanously downloaded).

## Other info
`fdroidurl.py` fetches the latest apk files for a given app hosted on F-Droid.
There is no device compatibility check whatsoever like in F-Droid itself.
Should you however find that an incompatible app version has been downloaded, you'll be able to replace the app from within F-Droid on the phone.

The `update-binary` file in the res dir has been copied from my CyanogenMod build tree.
