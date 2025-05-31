#!/bin/env python3


import sys
import os
import re

import pdb

# Regular expressions


archive_name = r"Archive name:\s{1}(\S*)"
archive_fingerprint = r"Archive fingerprint:\s{1}(\S*)"
hostname = r"Hostname:\s{1}(\S*)"
username = r"Username:\s{1}(\S*)"
#this_archive_sizes = r"This archive:\s*(\d*.\d* [EPTGM]B)\s*(\d*.\d* [EPTGM]B)\s*(\d*.\d* [EPTGM]B)"

#this_archive_sizes_original = r"This archive:\s*(\d*.\d*) [TGM]B\s*(\d*.\d*) [TGM]B\s*(\d*.\d*)"

this_archive_sizes = r"This archive:\s*(\d*.\d* [PTGMmk]?B)\s*(\d*.\d* [PTGMmk]?B)\s*(\d*.\d* [PTGMmk]?B)" 


get_archive_name = lambda info_str: re.compile(archive_name).findall(info_str)
get_archive_fingerprint = lambda info_str: re.compile(archive_fingerprint).findall(info_str)
get_hostname = lambda info_str: re.compile(hostname).findall(info_str)
get_username = lambda info_str: re.compile(username).findall(info_str)
get_archive_sizes = lambda info_str: re.compile(this_archive_sizes).findall(info_str)





def run_borg_info(borg_repo_path: str):
    """
    runs sudo borg info -a "*" $borg_repo_path
    """
    import subprocess

    if type(borg_repo_path) is not str:
        raise ValueError("get_borg_info_all_as_string expects a repository path as a string")

    command = 'borg info -a "*" {0}'.format(borg_repo_path)

    sys.stderr.write("Running borg info command: \n\n\n{0}\n\n\n".format(command))
    sys.stderr.write("Warning: Running borg info may require sudo access and your repository passkey...\n")

    
    results = subprocess.run(command, capture_output=True, text=True, shell=True)


    stdout_string = results.stdout

    if results.returncode != 0:
        raise RuntimeError("Unsuccessful exit code on 'borg info -a'")

    #print(stdout_string)
    #sys.exit(1)
    
    stdout_list = list(map(lambda s: "Archive name:" + s, stdout_string.split("Archive name:")))[1:]

    
    # Print header
    print("\t".join(("Archive_name", "fingerprint", "hostname", "username", "original_size", "compressed_size", "deduplicated_size", )))

    
    for archive_stdout_details in stdout_list:
        
        name=get_archive_name(archive_stdout_details)
        fingerprint=get_archive_fingerprint(archive_stdout_details)
        hostname=get_hostname(archive_stdout_details)
        username=get_username(archive_stdout_details)
        archive_sizes = get_archive_sizes(archive_stdout_details)

        if len(name) != 1:
            print(name)
            raise ValueError("expects 1 'archive name' per archive.")
        elif len(fingerprint) != 1:
            print(fingerprint)
            raise ValueError("expects 1 'fingerprint' per archive.")
        elif len(hostname) != 1:
            print(hostname)
            raise ValueError("expects 1 'hostname' per archive.")
        elif len(username) != 1:
            print(username)
            raise ValueError("expects 1 'username' per archive.")


        # print(archive_stdout_details)
        # print(name)
        # print(fingerprint)
        # print(hostname)
        # print(username)
        # print(archive_sizes)

        
        
        archive_sizes = archive_sizes[0]
        # Make sure there are 3 archive size strings
        assert type(archive_sizes) is tuple and len(archive_sizes) == 3, "Could not process 'borg info -a '*' $repo' archive sizes."

        
        orig_size, compressed_size, dedup_size = archive_sizes

        print("\t".join((name[0], fingerprint[0], hostname[0], username[0], orig_size, compressed_size, dedup_size,)))



def main():

    print("Do not run as sudo")
    print("Usage:\n\n\nlist_borg_info_by_size.py BORG_REPO_PATH")
    
    if len(sys.argv) != 2:
        print(sys.argv)
        raise ValueError("Invalid arguments supplied. 1 positional argument required: borg repo filepath.\n\nUsage: list_borg_archive_info_by_size.py BORG_REPO_PATH")

    
    elif not os.path.isdir(sys.argv[1]):

        
        
        raise ValueError("Listing borg repository and archive info requires a borg repository filepath that exists on the filesystem.")

    
    run_borg_info(sys.argv[1])

    sys.stderr.write("\n\nDone...\n\n")


if __name__ == '__main__':
    main()
    
