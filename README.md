# Kafka Vagrant Setup - Kerberos

## Hosts
  1. zookeeper.witzend.com ( runs zookeeper & kerberos)
  2. kafka[1-3].witzend.com
  
 
## Kafka Location
  installed under /usr/share/kafka
  Kafka is started by supervisord
  to stop or start use
  sudo supervisorctl
  stop kafka-broker
  
## Run producer 
   kinit -k -t /vagrant/keytabs/testuser1.keytab testuser1/kafka1.witzend.com
   ./bin/kafka-console-producer.sh --broker-list kafka1.witzend.com:9093 --producer-property "security.protocol=PLAINTEXTSASL" --topic test --new-producer
   
## Run Consumer
   ./bin/kafka-console-consumer.sh --bootstrap-server kafka1.witzend.com:9093 --topic test --from-beginning --new-consumer --consumer.config /tmp/consumer.properties 
   
   /tmp/consumer.properties contains security.protocol=PLAINTEXTSASL
