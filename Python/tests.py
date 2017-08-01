#!/usr/bin/env python3
# Warning! Testing can be very resource intensive.

import unittest
from BKKCrypt import BKKCrypt
import urllib.request
import os
from multiprocessing import Process, Pool

class TestEncodeStrings(unittest.TestCase):

    def test_simple_strings(self):
        self.assertEqual(BKKCrypt('adminadmin'), 'adminadmin')
        self.assertEqual(BKKCrypt('hunter2'), 'hunter2')
        self.assertEqual(BKKCrypt('password'), 'password')

    def test_PIN_numbers(self):
        self.assertEqual(BKKCrypt(1234), 1234)
        self.assertEqual(BKKCrypt('1234'), '1234')
        self.assertEqual(BKKCrypt(6969), 6969)
        self.assertEqual(BKKCrypt('6969'), '6969')
     
    def test_empty_passwords(self):
        self.assertEqual(BKKCrypt(''), '')


class TestBLNS(unittest.TestCase):
    """Test strings from https://github.com/minimaxir/big-list-of-naughty-strings/"""

    blns_request = urllib.request.urlretrieve("https://raw.githubusercontent.com/minimaxir/big-list-of-naughty-strings/master/blns.txt")
    with open(blns_request[0]) as blns_file:
        blns = blns_file.readlines()
        blns = list(map(lambda x: x.strip(), blns))

    def test_blns_lines(self):
        for line in self.blns:
            with self.subTest(line=line):
                self.assertEqual(BKKCrypt(line), line)

##########################
#    Helper functions    #
##########################
# Must be outside so they are pickleable

def get_lines_from_url(url):
     """Return cached file lines as a list if exists, else grab it, cache it, and return file lines."""
     # Being lazy until we can handle special cases
     if not url.endswith('.txt') or 'withcount' in url:
         return []

     filename = url.split('/')[-1]
     if os.path.exists(filename):
         try:
             with open(filename, 'r') as f:
                 lines = [x.strip() for x in f.readlines()]
         except UnicodeDecodeError:
             with open(filename, 'r', encoding='ISO-8859-1') as f:
                 lines = [x.strip() for x in f.readlines()]
         return lines

     with urllib.request.urlopen(url) as pw_file:
         pw_read = pw_file.read()
         with open(filename, 'w') as f:
             try:
                 pw_decode = pw_read.decode('utf-8')
             except UnicodeDecodeError:
                 pw_decode = pw_read.decode('ISO-8859-1')
             f.write(pw_decode)

         return [x.strip() for x in pw_decode.split('\n')]

def test_passwords(filename):
    base = "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/"
    lines = get_lines_from_url(base+filename)
    any_bad = any([BKKCrypt(line) != line for line in lines])

    # So python prints something instead of appearing to hang
    print("Tested {} passwords from {}".format(len(lines), filename))
    return any_bad

############################
#   End Helper Functions   #
############################

class TestSecListsPasswords(unittest.TestCase):
    """Test passwords from https://github.com/danielmiessler/SecLists/tree/master/Passwords
       This way we can make sure BKKCrypt works with all common passwords.
    """
    # Where we store files once downloaded, in case multiple test runs are desired
    pw_cache_dir = 'pw_cache'
    if not os.path.isdir(pw_cache_dir):
        os.mkdir(pw_cache_dir)
    os.chdir(pw_cache_dir)

    def test_all_files(self):
        #TODO make this list dynamically loaded from the page
        #TODO handle special cases line singles.org.txt and scandapass.csv and .tar.gz files
        pw_files = ["000webhost.txt", "10_million_password_list_top_100.txt", "10_million_password_list_top_1000.txt", "10_million_password_list_top_10000.txt", "10_million_password_list_top_100000.txt", "10_million_password_list_top_1000000.txt", "10_million_password_list_top_500.txt", "10k_most_common.txt", "1337speak.txt", "500-worst-passwords.txt", "Ashley_Madison.txt", "Basic_Spanish_List.txt", "KeyboardCombinations.txt", "Lizard_Squad.txt", "MostPopularLetterPasses.txt", "SplashData-2015.txt", "Sucuri_Top_Wordpress_Passwords.txt", "UserPassJay.txt", "adobe100.txt", "alleged-gmail-passwords.txt", "best1050.txt", "best110.txt", "best15.txt", "bible-withcount.txt", "bible.txt", "bt4-password.txt", "cain.txt", "carders.cc.txt", "common-passwords-win.txt", "conficker.txt", "darkc0de.txt", "default-passwords.csv", "elitehacker-withcount.txt", "elitehacker.txt", "english.txt", "faithwriters-withcount.txt", "faithwriters.txt", "german.txt", "hak5-withcount.txt", "hak5.txt", "honeynet-nocount.txt", "honeynet-withcount.txt", "honeynet.txt", "hotmail.txt", "john.txt", "korelogic-password.txt", "md5decryptor.uk.txt", "medical_devices.txt", "mil-dic.txt", "mirai_botnet.txt", "mubix_izmy.txt", "muslimMatch-withCount.txt", "muslimMatch.txt", "myspace-withcount.txt", "myspace.txt", "openwall_all.txt", "password-permutations.txt", "passwords_clarkson_82.txt", "passwords_john.txt", "passwords_youporn2012.txt", "passwords_youporn2012_raw.txt", "phpbb-nocount.txt", "phpbb-withcount.txt", "phpbb.txt", "porn-unknown-withcount.txt", "porn-unknown.txt", "rockyou-10.txt", "rockyou-15.txt", "rockyou-20.txt", "rockyou-25.txt", "rockyou-30.txt", "rockyou-35.txt", "rockyou-40.txt", "rockyou-45.txt", "rockyou-5.txt", "rockyou-50.txt", "rockyou-55.txt", "rockyou-60.txt", "rockyou-65.txt", "rockyou-70.txt", "rockyou-75.txt", "rockyou-withcount.txt.tar.gz", "rockyou.txt.tar.gz", "scadapass.csv", "singles.org-withcount.txt", "singles.org.txt", "splashdata_2014.txt", "splashdata_2015.txt", "top-20-common-SSH-passwords", "top_shortlist.txt", "tuscl.txt", "twitter-banned.txt", "wordpress_attacks_july2014.txt"]

        # Without multiprocessing, program runs unbearably slow and crashes due to using 2+ gigs RAM
        # With multiprocessing, program runs in ~20 seconds
        # Use multiprocessing.
        with Pool(processes=4) as pool:
            result = pool.map(test_passwords, pw_files)
            self.assertFalse(any(result))


if __name__ == '__main__':
    unittest.main()
