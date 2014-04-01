PACKAGES = org.fdroid.fdroid.apk org.mozilla.firefox.apk \
		   com.duckduckgo.mobile.android.apk \
		   ch.blinkenlights.android.vanilla.apk org.telegram.messenger.apk \
		   sk.vx.connectbot.apk

.PHONY: all clean 

all: update.zip
	@echo "Done!"

clean:
	@rm -rf root index.xml apps $(PACKAGES) update.zip
	@echo "Directory has been cleaned"

root:
	@echo "Creating directory layout..."
	@mkdir -p root/data/app
	@mkdir -p root/META-INF/com/google/android

index.xml:
	@echo "Retrieving F-Droid repository index..."
	@wget -q https://f-droid.org/repo/index.xml

apps: $(PACKAGES)
	@echo "Completed retrieving apps"
	@touch $@

$(PACKAGES): %.apk: root index.xml
	@echo "Retrieving $*..."
	@wget -q `./fdroidurl.py $*` -O root/data/app/$@
	@touch $@

update.zip: apps root
	@echo "Creating update.zip..."
	@cp res/updater-script root/META-INF/com/google/android/
	@cp res/update-binary root/META-INF/com/google/android/
	@cd root/ && zip ../update.zip -rq *
