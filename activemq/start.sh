docker run -d --name activemq -p 61616:61616 -p 8161:8161 \
    -v ${PWD}/jetty.xml:/opt/apache-activemq-5.16.2/conf/jetty.xml  \
    -v ${PWD}/jetty-realm.properties:/opt/apache-activemq-5.16.2/conf/jetty-realm.properties \
    symptoma/activemq:5.16.2


