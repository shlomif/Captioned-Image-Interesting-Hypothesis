SVG = interesting-hypothesis.svg
PNG = $(SVG).png
JPEG = $(SVG).jpg
WEBP = $(SVG).webp

PHOTO_BASE = vlcsnap-2021-02-17-16h13m33s998.png
PHOTO_DEST = $(PHOTO_BASE)

WIDTH = 600

all: $(PNG) $(JPEG) $(WEBP) $(PHOTO_DEST)

$(PNG): $(SVG) $(PHOTO_DEST)
	inkscape --export-type=png --export-filename=$@ --export-width=$(WIDTH) $<
	optipng $@

$(WEBP): $(PNG)
	gm convert $< $@

$(JPEG): $(PNG)
	gm convert $< $@

$(THIRD_PERSON_PNG): $(THIRD_PERSON_SVG) $(PHOTO_DEST)
	inkscape --export-png=$@ --export-width=$(WIDTH) $<
	optipng $@

$(THIRD_PERSON_WEBP): $(THIRD_PERSON_PNG)
	gm convert $< $@

$(THIRD_PERSON_JPEG): $(THIRD_PERSON_PNG)
	gm convert $< $@

$(NOBRANDING_PERSON_PNG): $(NOBRANDING_PERSON_SVG) $(PHOTO_DEST)
	inkscape --export-png=$@ --export-width=$(WIDTH) $<
	optipng $@

$(NOBRANDING_PERSON_WEBP): $(NOBRANDING_PERSON_PNG)
	gm convert $< $@

$(NOBRANDING_PERSON_JPEG): $(NOBRANDING_PERSON_PNG)
	gm convert $< $@

$(PHOTO_INTERIM1): $(PHOTO_BASE).jpg
	gm convert -crop 2560x1177 $< $@


clean:
	rm -f emma-*.png emma-*.jpg emma-*.webp

# upload: all
#	rsync --progress -v -a --inplace human-hacking-field-guide-logo.svg hhfg-ad.svg hhfg-ad.svg.png $(__HOMEPAGE_REMOTE_PATH)/hhfg-graphics-demo/
