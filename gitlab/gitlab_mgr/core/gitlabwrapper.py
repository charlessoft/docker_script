# -*- coding: utf-8 -*-

class gitlabMgr(object):
    def __init__(self,gl):
        self.gl=gl
        self.namespace_lst=[]
        pass

    def get_namespace_list(self):
        self.namespace_lst=self.gl.namespaces.list(all=True)
        return self.namespace_lst

    def del_namespace_by(self,name):
        pass

    def create_namespce(self,name):
        return '登录网页创建'
        pass

    def create_project(self,namespace,projname):
        bflag=False
        namespace_id = -1
        if len(self.namespace_lst)==0:
            self.get_namespace_list()

        for item in self.namespace_lst:
            if item.name == namespace:
                namespace_id = item.id
                bflag = True
                break
        if bflag:
            return self.gl.projects.create({'namespace_id': namespace_id, 'name': projname})
        else:
            raise Exception("未找到该命名空间,如果是新命名空间,需要手动登录gitlab网址创建")

    def del_project_by_id(self,id):
        return self.gl.projects.delete(id)

    def del_project_by_name(self,projname):
        pass

    def get_project_list(self):
        lst=self.gl.projects.list(all=True)
        return lst[::-1]

    def search_project_by_name(self, projname):
        return self.gl.projects.search({'search':"mytestaaa11112"})
        pass
