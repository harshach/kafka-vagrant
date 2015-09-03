echo "127.0.0.1	localhost" > /etc/hosts
echo "127.0.1.1	$3 $4" >> /etc/hosts
cp /vagrant/kerberos/krb5.conf /etc/

cp /vagrant/resolvconf_base.txt /etc/resolvconf/resolv.conf.d/base
cp /vagrant/dhclient.conf /etc/dhcp/
resolvconf -u
cp /vagrant/configs/hosts /etc/hosts
/etc/init.d/networking restart


apt-get install -y supervisor unzip openjdk-7-jdk krb5-user

/etc/init.d/supervisor stop

groupadd kafka
useradd --gid kafka --home-dir /home/kafka --create-home --shell /bin/bash kafka
useradd --gid kafka --home-dir /home/testuser1 --create-home --shell /bin/bash testuser1
useradd --gid kafka --home-dir /home/testuser2 --create-home --shell /bin/bash testuser2

tar zxvf /vagrant/$1.tgz -C /usr/share/
chown -R kafka:kafka /usr/share/$1
ln -s /usr/share/$1 /usr/share/kafka

mkdir /etc/kafka
chown kafka:kafka /etc/kafka

cp /vagrant/configs/server$5.properties /usr/share/kafka/config/server.properties
cp /vagrant/configs/kafka_jaas$5.conf /usr/share/kafka/config/kafka_jaas.conf
cp /vagrant/configs/kafka-run-class.sh /usr/share/kafka/bin/

echo "export KAFKA_KERBEROS_PARAMS=\"-Djava.security.auth.login.config=/usr/share/kafka/config/kafka_jaas.conf\"" >> /usr/share/kafka/config/kafka-env.sh
chown kafka:kafka /usr/share/kafka/config/kafka-env.sh

mkdir /var/log/kafka
chown kafka:kafka /var/log/kafka
