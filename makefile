SHELL := /usr/bin/env bash

pandocArgs = --atx-headers --wrap=none -M 'title: Advanced Bash-Scripting Guide—An in-depth exploration of the art of shell scripting' -M 'author: Mendel Cooper' --pdf-engine=lualatex
outputFormats = docx pdf epub html
outFiles = $(foreach format,$(outputFormats),abs-guide.$(format))

all: $(outFiles)

clean:
	rm -f $(outFiles)

# # this is for normalizing some empty codeblock by writing to md and read from md first
# abs-guide-original.md: abs-guide.html
# 	pandoc $(pandocArgs) -o $@ <(iconv -f ISO-8859-1 -t utf-8 $<) -f html
# abs-guide.md: abs-guide-original.md
# 	pandoc $(pandocArgs) -o $@ $< -F ./codeblock_add_sh_class.py

define OUTPUT
abs-guide.$(1): abs-guide-original.html
	pandoc $(pandocArgs) -s -o $$@ <(iconv -f ISO-8859-1 -t utf-8 $$<) -f html -F ./codeblock_add_sh_class.py
endef

$(foreach format,$(outputFormats),$(eval $(call OUTPUT,$(format))))


print-%:
	$(info $* = $($*))
