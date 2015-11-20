#!/bin/bash
cd ssl_keystores
#Step 1
/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/bin/keytool -keystore server.keystore.jks -alias kafka1.witzend.com -validity 365 -genkey

#Step 2
openssl req -new -x509 -keyout ca-key -out ca-cert -days 365
/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/bin/keytool -keystore server.truststore.jks -alias CARoot -import -file ca-cert
/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/bin/keytool -keystore client.truststore.jks -alias CARoot -import -file ca-cert

#Step 3
/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/bin/keytool -keystore server.keystore.jks -alias kafka1.witzend.com -certreq -file cert-file
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:test1234
/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/bin/keytool -keystore server.keystore.jks -alias CARoot -import -file ca-cert
/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/bin/keytool -keystore server.keystore.jks -alias kafka1.witzend.com -import -file cert-signed
