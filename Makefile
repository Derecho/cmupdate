.PHONY: all clean root

all: apps
	@echo "Done!"

clean:
	@rm -rf root fdroid firefox index.xml apps
	@echo "Directory has been cleaned"

root:
	@echo "Creating directory layout..."
	@mkdir -p root/data/app

index.xml:
	@echo "Retrieving F-Droid repository index..."
	@wget -q https://f-droid.org/repo/index.xml

apps: fdroid firefox
	@echo "Completed retrieving apps"
	@touch $@

fdroid: root
	@echo "Retrieving F-Droid..."
	@wget -q https://f-droid.org/FDroid.apk -O root/data/app/org.fdroid.fdroid.apk
	@touch $@

# Do some list magic like with SRCS, one target for all packages (including fdroid?)
firefox: root index.xml
	@echo "Retrieving Firefox..."
	@wget -q `./fdroidurl.py org.mozilla.firefox` -O root/data/app/org.mozilla.firefox.apk
	@touch $@
