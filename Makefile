PACKAGES = org.fdroid.fdroid.apk org.mozilla.firefox.apk \
		   com.duckduckgo.mobile.android.apk \
		   ch.blinkenlights.android.vanilla.apk org.telegram.messenger.apk \
		   sk.vx.connectbot.apk

.PHONY: all clean 

all: update.zip
	@echo "Done!"

clean:
	@rm -rf root index.xml apps $(PACKAGES) update-script update.zip
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

update-script: root
	@echo "Creating update-script..."
	@echo "show_progress 0.1 0" >> root/META-INF/com/google/android/update-script
	@echo "copy_dir PACKAGE:data DATA:" >> root/META-INF/com/google/android/update-script
	@echo "show_progress 0.1 10" >> root/META-INF/com/google/android/update-script
	@touch $@

update.zip: apps update-script
	@echo "Creating update.zip..."
	@cd root/ && zip ../update.zip -rq *
