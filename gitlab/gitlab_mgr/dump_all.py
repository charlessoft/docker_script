# -*- coding: utf-8 -*-
import sys

#reload(sys)
#sys.setdefaultencoding('utf-8')
import click

from core.utils import *
import traceback


def __get_valid_dstfile(dstfile, idx=0):
    # fileext = os.path.splitext(dstfile)
    if os.path.exists(dstfile):

        dstfile = dstfile[:-7] + "_" + str(idx) + '.tar.gz'
        idx += 1
        return __get_valid_dstfile(dstfile, idx)
    else:
        return dstfile


@click.group(invoke_without_command=False)
@click.option('-c', '--config', callback=read_config, type=click.File('r'),
              help='default gitlab.cfg')
@click.option('-s', '--section', type=str, default="global", help='use default global section')
@click.option('--force/--no-force', default=True, help='是否覆盖')
@click.pass_context
def cli(ctx, **kwargs):
    ctx.obj = {}
    ctx.obj.update(kwargs)
    if ctx.invoked_subcommand is None and not ctx.obj.get('testing_mode'):
        ctx.invoke(all)
    return ctx


def geterate_git_url(git_url, private_token=''):
    if git_url[:3] == 'ssh':
        return git_url
    else:
        # return 'http'
        return 'http://gitlab-ci-token:%s@%s' % (private_token, git_url[7:])


@cli.command()
@click.pass_context
def dump_all_projects(ctx, **kwargs):
    obj = create_gl(ctx, **kwargs)
    gl = obj['gl']
    section = obj['current']
    projects = gl.get_project_list()

    for index, prj in enumerate(projects):
        try:
            str = """
    total:%d, index: %s
    prj id: %s
    prj name: %s
    prj ssh_url_to_repo: %s
    prj http_url_to_repo: %s
            """
            print_green(str % (len(projects), index, prj.id, prj.name, prj.ssh_url_to_repo, prj.http_url_to_repo))
            # auth_http_url_to_repo = 'http://%s:%s@%s' % (Config.src_user, Config.src_pwd, prj.http_url_to_repo[7:])
            git_url = geterate_git_url(prj.http_url_to_repo, section['private_token'])
            # prj.attributes['name_with_namespace']
            dump_info = {
                'id': prj.attributes['id'],
                'name': prj.attributes['name'],
                'name_with_namespace': prj.attributes['name_with_namespace'],
                'created_at': prj.attributes['created_at'],
                'description': prj.attributes['description'],
                'status': 'known'
            }
            print(git_url)
            # git clone https://gitlab-ci-token:<private token>@git.example.com/myuser/myrepo.git
            # auth_http_url_to_repo = 'http://gitlab-ci-token:%s@%s' % (section['private_token'],prj.http_url_to_repo[7:])

            # print(git_url)
            namespace = os.path.join(section['data_folder'], prj.namespace['name'])

            tar_file = '%s.git.tar.gz' % (prj.name)
            bare_file = '%s.git' % (prj.name)
            # sys.exit(1)

            bash_shell('mkdir -p %s ' % (namespace))
            res = bash_shell('git clone %s' % (git_url))
            if res == 0:

                bash_shell('git clone --bare %s %s' % (prj.name, bare_file))
                bash_shell('tar zcvf %s %s' % (tar_file, bare_file))
                bash_shell('rm -fr %s' % (prj.name))
                bash_shell('rm -fr %s' % (bare_file))
                dstfile = os.path.join(namespace, tar_file)

                # dstfile = __get_valid_dstfile(dstfile, 0)

                print('move %s %s' % (tar_file, dstfile))
                bash_shell('mv %s %s' % (tar_file, dstfile))
                dump_info['status'] = 'success'
            else:
                dump_info['status'] = 'fail'
            write_to_csv(dump_info)
            print_green('=' * 50)
        except Exception as e:
            print(traceback.format_exc())
            print_red(e)

    print('end')


if __name__ == '__main__':
    cli()
    # dump_all_prjects()
