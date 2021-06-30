#!/usr/bin/env python3

import sys
from xml.dom.minidom import parse

assert len(sys.argv) >= 2, "usage: move-link-out-of-text.py <foo.svg>"

file = sys.argv[1]
with parse(file) as dom:
    for text in dom.getElementsByTagNameNS('http://www.w3.org/2000/svg', 'text'):
      text_children = text.childNodes
      if len(text_children) == 1 and text_children[0].nodeName == 'a':
            link = text_children[0]
            link_children = link.childNodes
            text.parentNode.replaceChild(link, text)
            for link_child in link_children:
                text.appendChild(link_child)
            link.appendChild(text)

    with open(file, 'w') as writer:
        dom.writexml(writer)
