# -*- coding: utf-8 -*-
import csv
import sys
import os
from configparser import ConfigParser
import subprocess

import gitlab
from colored import fg, bg, attr, colored, stylize
import colored

from core import gitlabwrapper


def bash_shell(bash_command):
    """
    python 中执行 bash 命令
    :param bash_command:
    :return: bash 命令执行后的控制台输出
    """
    try:
        # res=os.popen(bash_command).read().strip()
        p = subprocess.Popen(bash_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        returncode = p.poll()
        while returncode is None:
            line = p.stdout.readline()
            returncode = p.poll()
            line = line.strip()
            print(line.decode('utf-8'))

        return returncode
    except Exception as e:
        print(e)
        return None


def read_config(ctx, param, value):
    cfg = ConfigParser()
    cfg.read('gitlab.cfg')
    dict = {}
    for item in cfg.sections():
        dict.setdefault(item, {})
        for key, value in cfg[item].items():
            # print(key,value)
            dict[item].setdefault(key, value)
    return dict


def create_gl(ctx, **kwargs):
    obj = ctx.obj
    # section = kwargs.get('section', 'global')
    section = obj.get('section', 'globbal')
    if section == 'global':
        default = obj['config']['global']['default']
        current = obj['config'][default]
        print_green('use default global')
    else:
        print_green(section)
        current = obj['config'].get(section, None)

    if current:
        url = current['url']
        token = current['private_token']
        _gl = gitlab.Gitlab(url, token)
        gl = gitlabwrapper.gitlabMgr(_gl)
        obj['gl'] = gl
        obj['current'] = current
        return obj
    else:
        print_red('no section')
        sys.exit(1)
        return None


def print_green(content):
    angry = colored.fg("green") + colored.attr("bold")
    print(stylize("%s" % (content), angry))


def print_red(content):
    angry = colored.fg("red") + colored.attr("bold")
    print(stylize("%s" % (content), angry))


def write_to_csv(dict, file_path='dump_lst.csv'):
    if not os.path.exists(file_path):
        with open(file_path, 'w') as myFile:
            writer = csv.DictWriter(myFile, fieldnames=dict.keys())
            writer.writeheader()
            writer.writerow(dict)
    else:
        with open(file_path, 'a') as myFile:
            writer = csv.DictWriter(myFile, fieldnames=dict.keys())
            writer.writerow(dict)
