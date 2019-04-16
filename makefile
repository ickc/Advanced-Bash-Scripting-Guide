pandocArgs = --atx-headers --wrap=none -M 'title: Advanced Bash-Scripting Guide—An in-depth exploration of the art of shell scripting' -M 'author: Mendel Cooper'
outputFormats = docx pdf epub html
outFiles = abs-guide.md $(foreach format,$(outputFormats),abs-guide.$(format))

all: abs-guide.md $(outFiles)

clean:
	rm -f abs-guide-original.md

Clean: clean
	rm -f abs-guide.md $(outFiles)

# this is for normalizing some empty codeblock by writing to md and read from md first
abs-guide-original.md: abs-guide.sgml
	pandoc $(pandocArgs) -o $@ $< -f docbook
abs-guide.md: abs-guide-original.md
	pandoc $(pandocArgs) -o $@ $< -F ./codeblock_add_sh_class.py

define OUTPUT
abs-guide.$(1): abs-guide.md
	pandoc $(pandocArgs) -s -o $$@ $$<
endef

$(foreach format,$(outputFormats),$(eval $(call OUTPUT,$(format))))


print-%:
	$(info $* = $($*))
