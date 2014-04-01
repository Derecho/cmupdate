PACKAGES = org.fdroid.fdroid.apk org.mozilla.firefox.apk

.PHONY: all clean 

all: apps
	@echo "Done!"

clean:
	@rm -rf root index.xml apps $(PACKAGES)
	@echo "Directory has been cleaned"

root:
	@echo "Creating directory layout..."
	@mkdir -p root/data/app

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
