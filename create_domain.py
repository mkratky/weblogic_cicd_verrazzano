#!/usr/bin/python
import os, sys

# Path
path_1 = '$HOME/u01/app/oracle/middleware/wlserver/common/templates/wls/wls.jar'
path_2 = '$HOME/u01/app/oracle/middleware/wlserver/user_projects/domains/vtest/'

exp_path_1 = os.path.expandvars(path_1)
exp_path_2 = os.path.expandvars(path_2)

readTemplate(exp_path_1)
cd('/Security/base_domain/User/weblogic')
cmo.setPassword('Welcome1')
cd('/Server/AdminServer')
cmo.setName('AdminServer')
cmo.setListenPort(7001)
writeDomain(exp_path_2)
closeTemplate()
exit()
