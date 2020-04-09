SITE_ROOT = $(error SITE_ROOT unspecified)
BLOG_TITLE = $(error BLOG_TITLE unspecified)
COPYRIGHT_YEAR = $(error COPYRIGHT_YEAR unspecified)
COPYRIGHT_HOLDER = $(error COPYRIGHT_HOLDER unspecified)

ENTRY_DIR = entries

SITE_ENTRY = $(SITE_ROOT)/$(ENTRY_DIR)

SRC_DIR = src
SRC_ENTRY_DIR = $(SRC_DIR)/$(ENTRY_DIR)

OUT_DIR = out
PUB_DIR = $(OUT_DIR)/public
PUB_ENTRY_DIR = $(PUB_DIR)/$(ENTRY_DIR)

SRC_ENTRIES = $(shell find $(SRC_ENTRY_DIR) -type f -name '*.md')
SRC_ENTRY_FILES = $(shell find $(SRC_ENTRY_DIR) -type f -not -name '*.md')

PUB_ENTRIES = $(patsubst $(SRC_ENTRY_DIR)/%.md,$(PUB_ENTRY_DIR)/%.html,$(SRC_ENTRIES))
PUB_ENTRY_FILES = $(patsubst $(SRC_ENTRY_DIR)/%,$(PUB_ENTRY_DIR)/%,$(SRC_ENTRY_FILES))

PANDOC_TEMPLATE = $(SRC_DIR)/template.html
PANDOC_FLAGS = -f markdown -t html5 -s \
	-M lang="ja" \
	--template=$(PANDOC_TEMPLATE) \
	-V site-root="$(SITE_ROOT)" \
	-V blog-title="$(BLOG_TITLE)" \
	-V copyright-year="$(COPYRIGHT_YEAR)" \
	-V copyright-holder="$(COPYRIGHT_HOLDER)" \
	--highlight-style kate \
	-c https://unpkg.com/ress/dist/ress.min.css \
	-c $(SITE_ROOT)/style.css \
	--mathjax

$(PUB_ENTRY_DIR)/%.html: $(SRC_ENTRY_DIR)/%.md $(PANDOC_TEMPLATE)
	@mkdir -p $(@D)
	pandoc $(PANDOC_FLAGS) -o $@ -V url=$(SITE_ENTRY)/$*.html $<

$(PUB_ENTRY_DIR)/%: $(SRC_ENTRY_DIR)/%
	cp $< $@

all: $(PUB_ENTRIES) $(PUB_ENTRY_FILES) $(PUB_DIR)/index.html $(PUB_ENTRY_DIR)/index.html $(PUB_DIR)/style.css

$(PUB_DIR)/index.html: $(OUT_DIR)/index.md $(PANDOC_TEMPLATE)
	@mkdir -p $(@D)
	pandoc $(PANDOC_FLAGS) -o $@ -V url=$(SITE_ROOT)/index.html $<

$(OUT_DIR)/index.md: $(SRC_DIR)/index_md.sh $(SRC_ENTRIES)
	@mkdir -p $(@D)
	$< $(SITE_ROOT) > $@

$(PUB_ENTRY_DIR)/index.html: $(SRC_DIR)/entries_index_html.sh
	@mkdir -p $(@D)
	$< $(SITE_ROOT) > $@

$(PUB_DIR)/style.css: $(SRC_DIR)/style.sass
	@mkdir -p $(@D)
	sassc -a $< $@

clean:
	$(RM) -r $(OUT_DIR)

.PHONY: all clean
