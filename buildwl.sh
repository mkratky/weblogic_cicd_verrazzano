export HOME=${PWD}
export tag=$(($(date +%s%N)/1000000))
cd $HOME

cd vtest
mvn package

cd $HOME
wget -q $jdk_preauth
wget -q $wls_preauth
mkdir -p $HOME/u01/app/oracle/middleware
mkdir -p $HOME/u01/app/oracle/config/domains
mkdir -p $HOME/u01/app/oracle/config/applications
export MW_HOME=$HOME/u01/app/oracle/middleware
export WLS_HOME=$MW_HOME/wlserver
export WL_HOME=$WLS_HOME

mkdir -p $HOME/u01/software/
cp fmw_12.2.1.4.0_wls_lite_generic.jar $HOME/u01/software/

printf "inventory_loc=$HOME/u01/app/oraInventory\ninst_group=builder" > $HOME/u01/software/oraInst.loc

printf "[ENGINE]\nResponse File Version=1.0.0.0.0\n[GENERIC]\nORACLE_HOME=$HOME/u01/app/oracle/middleware\nINSTALL_TYPE=WebLogic Server\nMYORACLESUPPORT_USERNAME=\nMYORACLESUPPORT_PASSWORD=\nDECLINE_SECURITY_UPDATES=true\nSECURITY_UPDATES_VIA_MYORACLESUPPORT=false\nPROXY_HOST=\nPROXY_PORT=\nPROXY_USER=\nPROXY_PWD=\nCOLLECTOR_SUPPORTHUB_URL=" > $HOME/u01/software/wls.rsp

java -Xmx1024m -jar $HOME/u01/software/fmw_12.2.1.4.0_wls_lite_generic.jar -silent -responseFile $HOME/u01/software/wls.rsp -invPtrLoc $HOME/u01/software/oraInst.loc
. $WLS_HOME/server/bin/setWLSEnv.sh 
java weblogic.version

mkdir -p $WLS_HOME/user_projects/domains/

cd $HOME
java weblogic.WLST create_domain.py

cd $WLS_HOME/user_projects/domains/vtest
./startWebLogic.sh &
sleep 1m

cd $HOME/vtest/target/
java weblogic.Deployer -adminurl 127.0.0.1:7001 -username weblogic -password Welcome1 -deploy -name vtest vtest.war
sleep 1m

cd $HOME
cp weblogic-deploy.zip $MW_HOME
cd $MW_HOME
unzip weblogic-deploy.zip

cd $HOME
cp imagetool.zip $MW_HOME
cd $MW_HOME
unzip imagetool.zip

export WDT_HOME=$MW_HOME/weblogic-deploy
export WIT_HOME=$MW_HOME/imagetool

cd $HOME
mkdir v8o
$WDT_HOME/bin/discoverDomain.sh \
-oracle_home $MW_HOME \
-domain_home $WLS_HOME/user_projects/domains/vtest \
-model_file ./v8o/wdt-model.yaml \
-archive_file ./v8o/wdt-archive.zip \
-target vz \
-output_dir v8o

cd v8o
$WIT_HOME/bin/imagetool.sh cache addInstaller --path $HOME/jdk-8u311-linux-x64.tar.gz type jdk --version 8u311 --force
$WIT_HOME/bin/imagetool.sh cache addInstaller --path $HOME/fmw_12.2.1.4.0_wls_lite_generic.jar --type wls --version 12.2.1.4.0 --force
$WIT_HOME/bin/imagetool.sh cache addInstaller --path $HOME/weblogic-deploy.zip --type wdt --version latest --force
$WIT_HOME/bin/imagetool.sh create --tag fra.ocir.io/fr9qm01oq44x/mkratky/wls/vtest:$tag --version 12.2.1.4.0 --jdkVersion 8u311 --wdtModel ./wdt-model.yaml --wdtArchive ./wdt-archive.zip --wdtVariables ./vz_variable.properties --resourceTemplates ./application.yaml --wdtModelOnly

docker login -u $DOCKER_USER -p $DOCKER_PASSWORD fra.ocir.io
docker push fra.ocir.io/fr9qm01oq44x/mkratky/wls/vtest:$tag

cd $HOME
sed -i "s/vtest:.*#TAG/vtest:$tag #TAG/g" vtest-components.yaml
cat vtest-components.yaml
git config --global user.email "marek.kratky@oracle.com"
git config --global user.name "Marek Kratky"
git add vtest-components.yaml
git commit -m "vtest image changed to $tag"
#git push origin main
