# -*- coding: utf-8 -*-
import click
import gitlab
import os
import sys

from core import utils

# 需要切换到jenkins权限
from core.utils import read_config, create_gl, print_red

# gl = gitlab.Gitlab(Config.src_url, Config.src_token)
# gl_dest = gitlab.Gitlab(Config.dest_url, Config.dest_token)
gl = None
namespace_map = {}


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


def __create_gl(ctx, **kwargs):
    gl = create_gl(ctx, **kwargs)
    return gl


def __init_namespace(obj):
    gl = obj['gl']
    for item in gl.get_namespace_list():
        namespace_map[item.name] = item.id


def get_auth_url(url, user):
    auth_http_url_to_repo = 'http://gitlab-ci-token:%s@%s' % (user, url[7:])
    print(auth_http_url_to_repo)
    return auth_http_url_to_repo


# @cli.command()
# @click.pass_context
def import_project(obj, tar_file_path, namespace, **kwargs):
    gl = obj['gl']
    tar_file_name = os.path.basename(tar_file_path)
    bare_name = tar_file_name[:-7]  # basin-spider.git
    prj_name = bare_name[:-4]  ## basin-spider
    # 解压
    utils.bash_shell('tar zxvf %s' % (tar_file_path))
    # print(gl_dest.projects.list())

    try:
        if not namespace in namespace_map:
            print("需要从网页打开手动创建命名空间: %s" % (namespace))
            sys.exit(1)
        # project = gl.create_project({'name': prj_name, 'namespace_id': namespace_map[namespace]})
        project = gl.create_project(namespace, prj_name)

        auth_http_url_to_repo = get_auth_url(project.http_url_to_repo, obj['current']['private_token'])

        utils.bash_shell(
            'cd %s;git remote rm origin;git remote add origin %s;git push origin master;git push origin --tags' % (
                bare_name, auth_http_url_to_repo))
        utils.bash_shell('rm -fr %s' %(bare_name))
        print("import %s success!" % (prj_name))
        # print(project)
        # sys.exit(1)
    except Exception as e:
        print_red("create prject fail %s,%s" % (prj_name,e))
        # utils.bash_shell('rm -fr %s' %(bare_name))
    finally:
        utils.bash_shell('rm -fr %s' %(bare_name))


def _import_all_project(obj, folder):
    """this is a statement"""
    parents = os.listdir(folder)

    for parent in parents:
        child = os.path.join(folder, parent)
        # print(child)

        if os.path.isdir(child):
            namespace = parent
            # print(child)
            # import_all_project(ctx, child)
            _import_all_project(obj, child)
            # print(child)
        else:
            namespace = os.path.dirname(child)
            namespace = namespace.split('/')[-1]

            # print(path)
            # print(namespace)
            # print(child)
            import_project(obj, child, namespace)


def __check_need_namespace(folder):
    # print(parents)
    bflag = False
    for parent in os.listdir(folder):
        if parent not in namespace_map:
            print("需要从网页打开手动创建命名空间: %s" % (parent))
            bflag = True
    if bflag:
        sys.exit(1)
    pass


@cli.command()
@click.pass_context
@click.option('-f', '--folder', type=str, default="./gitrepo", help='repo folder')
def import_all_projects(ctx, folder, **kwargs):
    obj = __create_gl(ctx, **kwargs)
    __init_namespace(obj)
    __check_need_namespace(folder)
    _import_all_project(obj, folder)
    print("import git repo end")


if __name__ == '__main__':
    cli()
    # __init_namespace()
    # gci(Config.data_folder, '')
