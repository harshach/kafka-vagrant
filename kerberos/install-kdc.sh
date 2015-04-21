cp /vagrant/kerberos/krb5.conf /etc/
mkdir /etc/krb5kdc
cp /vagrant/kerberos/kdc.conf /etc/krb5kdc/


cp /vagrant/kerberos/70-disable-random-entropy-estimation.rules /etc/udev/rules.d/70-disable-random-entropy-estimation.rules
udevadm control --reload-rules
udevadm trigger

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq krb5-kdc krb5-admin-server

sh /vagrant/kerberos/new_realm.sh


# Zookeeper (Will need one of these for each box in teh Zk ensamble)
sudo /usr/sbin/kadmin.local -q 'addprinc -randkey zookeeper/zookeeper.witzend.com@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q "ktadd -k /tmp/zk.keytab  zookeeper/zookeeper.witzend.com@WITZEND.COM"

# Kafka brokers
sudo /usr/sbin/kadmin.local -q 'addprinc -randkey kafka/kafka1.witzend.com@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q "ktadd -k /tmp/kafka1.keytab kafka/kafka1.witzend.com@WITZEND.COM"

sudo /usr/sbin/kadmin.local -q 'addprinc -randkey kafka/kafka2.witzend.com@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q "ktadd -k /tmp/kafka2.keytab kafka/kafka2.witzend.com@WITZEND.COM"

sudo /usr/sbin/kadmin.local -q 'addprinc -randkey kafka/kafka3.witzend.com@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q "ktadd -k /tmp/kafka3.keytab kafka/kafka3.witzend.com@WITZEND.COM"

# user to produce/consumer
sudo /usr/sbin/kadmin.local -q 'addprinc -randkey testuser1/kafka1.witzend.com@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q "ktadd -k /tmp/testuser1.keytab testuser1/kafka1.witzend.com@WITZEND.COM"

sudo /usr/sbin/kadmin.local -q 'addprinc -randkey testuser2/kafka1.witzend.com@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q "ktadd -k /tmp/testuser2.keytab testuser2/kafka1.witzend.com@WITZEND.COM"

mkdir /vagrant/keytabs
cp /tmp/kafka*.keytab /vagrant/keytabs/
cp /tmp/zk.keytab /vagrant/keytabs/
cp /tmp/testuser1.keytab /vagrant/keytabs/
cp /tmp/testuser2.keytab /vagrant/keytabs/
