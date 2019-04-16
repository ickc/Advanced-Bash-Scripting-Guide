#!/usr/bin/env python
"""
add class sh to any CodeBlock
"""

from panflute import *


def action(elem, doc):
    if isinstance(elem, CodeBlock):
        elem.classes += ['sh']
        return elem


def main(doc=None):
    return run_filter(action, doc=doc)


if __name__ == '__main__':
    main()
