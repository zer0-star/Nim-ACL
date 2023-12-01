#!/usr/bin/python3
# -*- coding: utf-8 -*-

import sys, subprocess, os, platform

args = sys.argv

file_name = args[1]
ext = os.path.splitext(file_name)[1]
combined_file_name = "combined" + ext
home_dir = "~/"

if ext == '.cpp':
    expander_path = home_dir + "/git/ac-library/expander.py"
    lib_path = home_dir + "/git/ac-library/"
elif ext == '.nim':
    expander_path = home_dir + "/git/Nim-ACL/expander.py"
    lib_path = home_dir + "/git/Nim-ACL/"
else:
    print("Undefined Extension")
    exit(1)

os.system("python3 {} {} -s --compress --directory --lib {}".format(expander_path, file_name, lib_path))
# ubuntu(linux)

s = platform.system()

if s == 'Linux':
    os.system("cat {} | xsel --clipboard --input".format(combined_file_name))
elif s == 'Darwin':
    os.system("cat {} | pbcopy".format(combined_file_name))
elif s == 'Windows':
    pass
else:
    print("不明なplatform")
os.system("rm {}".format(combined_file_name))
