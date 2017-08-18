all: images

pngsources := $(shell find _source_images -type f -name '*.png')

pngdest_1x := $(addsuffix @1x.png,$(basename $(patsubst _source_images%,images%,$(pngsources))))
pngdest_2x := $(addsuffix @2x.png,$(basename $(patsubst _source_images%,images%,$(pngsources))))
pngdest_4x := $(addsuffix @4x.png,$(basename $(patsubst _source_images%,images%,$(pngsources))))

$(foreach s,$(pngsources),$(foreach o,$(filter %$(basename $(notdir $s))@1x.png,$(pngdest_1x)),$(eval $o: $s)))
$(foreach s,$(pngsources),$(foreach o,$(filter %$(basename $(notdir $s))@2x.png,$(pngdest_2x)),$(eval $o: $s)))
$(foreach s,$(pngsources),$(foreach o,$(filter %$(basename $(notdir $s))@4x.png,$(pngdest_4x)),$(eval $o: $s)))

$(pngdest_4x): ; $(if $(wildcard $(@D)),,mkdir -p $(@D) &&) QUANTIZED=$$(mktemp); pngquant --force -s1 --skip-if-larger -o "$$QUANTIZED" "$<" && optipng -o7 -strip all -out "$@" "$$QUANTIZED" && rm "$$QUANTIZED"
$(pngdest_2x): ; $(if $(wildcard $(@D)),,mkdir -p $(@D) &&) RESIZED=$$(mktemp); QUANTIZED=$$(mktemp); convert "$<" -filter Lanczos -resize 50% "$$RESIZED" && pngquant --force -s1 --skip-if-larger -o "$$QUANTIZED" "$$RESIZED" ; optipng -o7 -strip all -out "$@" "$$QUANTIZED"; rm "$$QUANTIZED" "$$RESIZED"
$(pngdest_1x): ; $(if $(wildcard $(@D)),,mkdir -p $(@D) &&) RESIZED=$$(mktemp); QUANTIZED=$$(mktemp); convert "$<" -filter Lanczos -resize 25% "$$RESIZED" && pngquant --force -s1 --skip-if-larger -o "$$QUANTIZED" "$$RESIZED" ; optipng -o7 -strip all -out "$@" "$$QUANTIZED"; rm "$$QUANTIZED" "$$RESIZED"

images: $(pngdest_1x) $(pngdest_2x) $(pngdest_4x)

.PHONY: all images
