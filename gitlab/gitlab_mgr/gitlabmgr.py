# -*- coding: utf-8 -*-
import click
import gitlab
from colored import fg, bg, attr

from core import gitlabwrapper
from config import Config

from configparser import ConfigParser

from core.utils import read_config, print_green, print_red, create_gl

g_namespace_lst = {}
from prettytable import PrettyTable


# def read_config(ctx, param, value):
#     cfg = ConfigParser()
#     cfg.read('gitlab.cfg')
#     dict = {}
#     for item in cfg.sections():
#         dict.setdefault(item, {})
#         for key, value in cfg[item].items():
#             # print(key,value)
#             dict[item].setdefault(key, value)
#     return dict


@click.group(invoke_without_command=False)
@click.option('-c', '--config', callback=read_config, type=click.File('r'),
              help='default gitlab.cfg')
@click.option('-s', '--section', type=str, default="global", help='use default global section')
@click.pass_context
def cli(ctx, **kwargs):
    ctx.obj = {}
    ctx.obj.update(kwargs)
    if ctx.invoked_subcommand is None and not ctx.obj.get('testing_mode'):
        ctx.invoke(all)
    return ctx


@cli.command()
@click.pass_context
def namespace_list(ctx, **kwargs):
    # gl = create_gl(ctx, **{"section": section})
    gl = create_gl(ctx, **kwargs)
    x = PrettyTable(['id', 'namespace'])
    x.align["namespace"] = "l"  # Left align city names
    if gl:
        for item in gl.get_namespace_list():
            x.add_row([item.id, item.name])
        print_green(x)
    else:
        print_red("not subtaks")

@cli.command()
@click.pass_context
def project_list(ctx, **kwargs):
    gl = create_gl(ctx, **kwargs)
    x = PrettyTable(['id', 'name'])
    x.align["name"] = "l"  # Left align city names
    for item in gl.get_project_list():
        x.add_row([item.id, item.name])
    print(x)


@cli.command()
@click.option('--namespace', type=str)
@click.option('--name', type=str)
@click.pass_context
def project_create(ctx, namespace, name, **kwargs):
    try:
        gl = create_gl(ctx, **kwargs)
        print('创建工程')
        x = PrettyTable(['id', 'name_with_namespace', 'ssh_url_to_repo', 'http_url_to_repo'])
        res = gl.create_project(namespace, name)
        x.align['name_with_namespace'] = 'l'
        x.add_row([res.id, res.name_with_namespace, res.ssh_url_to_repo, res.http_url_to_repo])
        print(x)
    except Exception as e:
        print("创建失败, %s" % (e))


@cli.command()
@click.option('--id', type=str)
@click.pass_context
def project_remove(ctx, id, **kwargs):
    try:
        print('删除工程')
        gl = create_gl(ctx, **kwargs)
        res = gl.del_project_by_id(id)
        print("删除成功")
    except Exception as e:
        print("删除失败, %s" % (e))


# mytestaaa11112

if __name__ == '__main__':
    cli()

    # 创建命名空间
    # 获取命名空间

    # 创建工程
    # 删除工程

    # 创建用户
