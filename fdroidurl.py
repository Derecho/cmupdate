#!/usr/bin/env python
# Simple script that returns an fdroid repository url for a given package name.
# Beware, not user-friendly!

import sys
import xml.etree.ElementTree as ET

tree = ET.parse('index.xml')
root = tree.getroot()

app = root.find("./application/[@id='{}']".format(sys.argv[1]))
marketvercode = app.find('marketvercode').text
apkname = None

for package in app.findall('package'):
    if package.find('versioncode').text == marketvercode:
        apkname = package.find('apkname').text
        break
if apkname == None:
    highestvercode = 0;
    for package in app.findall('package'):
        vercode = package.find('versioncode').text 
        if vercode > highestvercode:
            highestvercode = vercode
            apkname = package.find('apkname').text

print("https://f-droid.org/repo/{}".format(apkname))
