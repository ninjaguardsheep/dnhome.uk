SRCDIR := src
BUILDDIR := _site
WEBSVR := srv-01
WEBDEST := /var/www/www.dnhome.uk/

.PHONY: build
build: clean
	mkdir ${BUILDDIR}
	cp -r ${SRCDIR}/* ${BUILDDIR}/
	rm ${BUILDDIR}/assets/img/_*
	minify --verbose --output ${BUILDDIR}/ --recursive ${BUILDDIR}/

.PHONY: upload
upload:
	printf "cd ${WEBDEST}\nmput ${BUILDDIR}/*\nbye" | sftp -r ${WEBSVR}

.PHONY: clean
clean:
	rm -vrf ${BUILDDIR}

.PHONY: push
push: build upload
