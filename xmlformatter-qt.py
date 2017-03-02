#!/usr/bin/env python3
# (c) Daniel Cordova A. <danesc87@gmail.com>, GPL v2
# Thanks to http://stackoverflow.com/questions/1140958/whats-a-quick-one-liner-to-remove-empty-lines-from-a-python-string
# Thanks to http://www.librebyte.net for the base script.
import os
import re
from html.parser import HTMLParser
import xml.dom.minidom as minidom
from xml.parsers.expat import ExpatError
import sys

class XMLParser(object):
    '''Class that tries to parse a xml file, using kdialog to display any error in process'''
    def __init__(self):
        self.file_name = None
        self.xml_to_be_parsed = None
            
    def get_file(self):
        try:
            self.file_name = sys.argv[1]
        except IndexError:
            os.system('kdialog --title "Error" --error "You must specify a file name!"')

    def parse_xml(self):
        if os.path.isfile(self.file_name) and os.access(self.file_name, os.R_OK):
            read_only_file = open(self.file_name, 'r')
            self.xml_to_be_parsed = HTMLParser().unescape(read_only_file.read())
            try:
                self.xml_to_be_parsed = minidom.parseString(self.xml_to_be_parsed).toprettyxml()
            except ExpatError as bad_xml:
                os.system('kdialog --title "Error Parsing File" --error "XML file %s"' % str(bad_xml))
            # Handle issue with CDATA section due minidom add extraspace
            #before/after CDATA
            self.xml_to_be_parsed = re.sub('>\s+<!', '><!', self.xml_to_be_parsed)
            self.xml_to_be_parsed = re.sub(']>\s+<', ']><', self.xml_to_be_parsed)
            writable_file = open(self.file_name,'w')
            writable_file.write("".join([s for s in self.xml_to_be_parsed.strip().splitlines(True) if s.strip()]))
            writable_file.close()
        else:
            os.system('kdialog --title "Error" --error "File is missing or is not readable!"')

def main():
    xml_parser = XMLParser()
    xml_parser.get_file()
    xml_parser.parse_xml()

if __name__ == '__main__':
    main()
