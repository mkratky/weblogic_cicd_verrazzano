#!/usr/bin/python
import os, sys
readTemplate('$HOME/u01/app/oracle/middleware/wlserver/common/templates/wls/wls.jar')
cd('/Security/base_domain/User/weblogic')
cmo.setPassword('Welcome1')
cd('/Server/AdminServer')
cmo.setName('AdminServer')
cmo.setListenPort(7001)
writeDomain('$HOME/u01/app/oracle/middleware/wlserver/user_projects/domains/vtest/')
closeTemplate()
exit()
