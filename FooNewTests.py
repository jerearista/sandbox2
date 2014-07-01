"""
Created on 26 June 2014
@author: Jere Julian
"""

import unittest
#import FooNew
# allows Foo.Foo()

from FooNew import Foo
# allows Foo()

class FooNewTests(unittest.TestCase):
    """Unittests for FooNew."""

    def testFoo1(self):
        self.assertTrue(True)

    def testFooSpam(self):
        #print Foo
        myfoo = Foo()
        self.assertEqual(myfoo.spam, 4)

    def testFooBaz(self):
        myfoo = Foo()
        self.assertEqual(myfoo.baz, 2)

    def testFooSpamSet(self):
        myfoo = Foo()
        myfoo.spam = 12
        self.assertEqual(myfoo.spam, 12)

def main():
    unittest.main()

if __name__ == '__main__':
    main()
