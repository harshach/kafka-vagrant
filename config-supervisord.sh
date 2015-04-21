echo [program:kafka-broker] | sudo tee -a /etc/supervisor/conf.d/kafka-broker.conf
echo command=/usr/share/kafka/bin/kafka-server-start.sh /usr/share/kafka/config/server.properties | sudo tee -a /etc/supervisor/conf.d/kafka-broker.conf
echo directory=/home/kafka | sudo tee -a /etc/supervisor/conf.d/kafka-broker.conf
echo autorestart=true | sudo tee -a /etc/supervisor/conf.d/kafka-broker.conf
echo user=kafka | sudo tee -a /etc/supervisor/conf.d/kafka-broker.conf
