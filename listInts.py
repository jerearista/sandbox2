#!/usr/bin/python

"""
Created on 10 June 2014
@author: Jere Julian
"""

from jsonrpclib import Server
import pprint
import Foo

if __name__ == '__main__':
    switch = Server( "https://arista:arista@10.10.10.11/command-api" )

    response = switch.runCmds( 1, ["show interfaces description"] )

    #print "The switch's system MAC addess is", response[0]["systemMacAddress"]

    #pp = pprint.PrettyPrinter()
    #pp.pprint(response[0])
    pprint.pprint(response[0])


    print "The switch's system Management description is '{0}' and it is {1}/{2}.".format(response[0]["interfaceDescriptions"]["Management1"]["description"], response[0]["interfaceDescriptions"]["Management1"]["interfaceStatus"], response[0]["interfaceDescriptions"]["Management1"]["lineProtocolStatus"])
