FROM jboss/wildfly:14.0.1.Final
#FROM jboss/wildfly:15.0.0.Final


USER root

# copy demo RP to deployment folder
COPY ./eLearningSSO/oidc/sp_webapp/target/oidc_sp.war /opt/jboss/wildfly/standalone/deployments/oidc_sp.war

# copy demo OP to deployment folder
COPY ./eLearningSSO/oidc/idp_webapp/target/oidc_idp.war /opt/jboss/wildfly/standalone/deployments/oidc_idp.war


# add wildfly config (adjusted to serve static files)
COPY ./conf/wildfly/wildfly.config /opt/jboss/wildfly/standalone/configuration/standalone.xml
# add static files
COPY ./conf/wildfly/testportal.html /opt/jboss/wildfly/static/sp_portal.html
COPY ./conf/wildfly/static-professos.txt /opt/jboss/wildfly/static/static-professos.txt
RUN chown jboss:jboss -R /opt/jboss/wildfly/static/

# add keys (currently not needed as https is disabled for debugging and HoK is not
# yet supported)
#COPY ./eLearningSSO/build/single-sign-on/keys /opt/jboss/wildfly/standalone/configuration/

# hotfix faulty JAXB package
#RUN rm /opt/jboss/wildfly/modules/system/layers/base/javax/xml/bind/api/main/*
#COPY ./eLearningSSO/build/single-sign-on/main/ /opt/jboss/wildfly/modules/system/layers/base/javax/xml/bind/api/main

RUN /opt/jboss/wildfly/bin/add-user.sh -g projectWorker -a attacker 123456 \
  && /opt/jboss/wildfly/bin/add-user.sh -g projectWorker -a victim 123456

#USER jboss

# Expose the ports we're interested in
EXPOSE 8080 8787 80 443 

# uncomment below, if you need to acces the management interface
# EXPOSE 9990
# RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "--debug"]
