# -*- coding: utf-8 -*-
import codecs

import click
from prettytable import PrettyTable

from config import Config

import jenkins

server = jenkins.Jenkins(Config.jenkins_url, username=Config.jenkins_user, password=Config.jenkins_password)
params = {'Branch': 'oriin/master', 'host': 'node1.huawei'}

print()


@click.group(invoke_without_command=True)
@click.pass_context
def cli(ctx, **kwargs):
    ctx.obj = {}
    ctx.obj.update(kwargs)
    if ctx.invoked_subcommand is None and not ctx.obj.get('testing_mode'):
        ctx.invoke(all)
    return ctx


@cli.command()
@click.pass_context
def jobs_count(ctx):
    try:
        print('任务数: %d' % (server.jobs_count()))
    except Exception as e:
        print("获取失败, %s" % (e))


@cli.command()
@click.pass_context
def jobs_list(ctx):
    try:
        x = PrettyTable(['name', 'url'])
        x.align['name'] = 'l'
        x.align['url'] = 'l'
        all_jobs_li = server.get_all_jobs()
        for item in all_jobs_li:
            x.add_row([item['name'], item['url']])
        print(x)
        # print('name: %s' % item['name'], 'URL: ', item['url'])
    except Exception as e:
        print(e)


@cli.command()
@click.pass_context
@click.option('--gitlab_url', type=str, help="ssh://git@gitlab.basin.server:10023/base/helloworld.git")
@click.option('--name', type=str, help="job_name")
def job_create(ctx, name, gitlab_url):
    try:
        content = codecs.open('./template/jenkins_xml_config.xml', 'rb', 'utf-8').read()
        content=content.replace('TEMPLATE_GITLAB_URL', gitlab_url)
        content=content.replace('TEMPLATE_CREDENTIALSID', Config.gitlab_api_token)
        print(server.create_job(name, content))
    except Exception as e:
        print(e)


@cli.command()
@click.pass_context
@click.option('--name', type=str, help="job_name")
def job_delete(ctx, name):
    try:
        server.delete_job(name)
    except Exception as e:
        print(e)


# mytestaaa11112

if __name__ == '__main__':
    cli()
