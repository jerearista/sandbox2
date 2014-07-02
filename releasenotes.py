#!/usr/bin/python
# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4

"""Release Note collector
Created on 01 July 2014
@author: Jere Julian
"""

#from jsonrpclib import Server
import requests
import json
import pprint

def get_release_note(comments):
    """Parse issue comments (json) and return the Release Note section."""
    release_note = ""
    i = 0
    for comment in comments:
        #pprint.pprint(comment)
        #print "**** Comment-{0}: {1}".format(i, comment['body'])
        #print "\tURL: {0}".format(comment['html_url'])
        #comment['body'].index('Changed make')
        if comment['body'].lower().find('changed make') >= 0:
            #print "Found 'Release Note'"
            release_note = comment['body']
        #else:
            #print "No 'Release Note' found"

        i += 1
        # print "----------------------------------------------------------\n"
    return release_note



if __name__ == '__main__':
    r = requests.get(
     'https://api.github.com/repos/arista-eosplus/ztpserver/issues/10/comments')
    if not r.ok:
        print "Request failed: {0}".format(r.status_code)
    else:
        #repoItem = json.loads(r.text or r.content)
        #pprint.pprint(repoItem)
        #print "Comments[0]: " + repoItem[0]['body'] + "\n\n"

        comments = r.json()
        

        # If enhancement, append to Changelog
        print "Final Release Note - {0}".format(get_release_note(comments))

        # else, if bug and not pre-release, add to Release Notes
        print "Final Release Note - {0}".format(get_release_note(comments))

