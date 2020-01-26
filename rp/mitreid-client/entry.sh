#!/bin/bash

service apache2 start

su jboss -s /bin/bash -c "/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0"
