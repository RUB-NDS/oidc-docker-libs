#!/bin/bash

CA_ROOT_CERT=${CA_DIR}/${CA_CERT}
CA_ROOT_KEY=${CA_DIR}/${CA_KEY}


function create_ssl_certificates {
    DNSNAME=$1
    SSL_DIR=${CA_DIR}/${DNSNAME}
    shift
    arr=("$@")

    if [ -e ${SSL_DIR}/${DNSNAME}.key ]; then
        echo "Domain key does already exist: ${DNSNAME}"
        return 0
    fi

    mkdir -p ${SSL_DIR}

    # generate private key
    openssl genrsa -out ${SSL_DIR}/${DNSNAME}.key ${SSL_KEY_SIZE}

    cat > ${SSL_DIR}/${DNSNAME}.cnf << EOF
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[req_distinguished_name]
C = DE
L = Bochum
O = RUB
OU = OICD TestLab
CN = professos

[ v3_req ]
# Extensions to add to a certificate request
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${DNSNAME}
EOF

    COUNTER=2
    for i in "${arr[@]}";
        do
            echo "DNS.$COUNTER = $i" >> ${SSL_DIR}/${DNSNAME}.cnf
            COUNTER=$[$COUNTER +1]
        done
    # create sign request
    openssl req -new -key ${SSL_DIR}/${DNSNAME}.key \
        -out ${SSL_DIR}/${DNSNAME}.csr \
        -config ${SSL_DIR}/${DNSNAME}.cnf

    # sign key
    openssl x509 -req -in ${SSL_DIR}/${DNSNAME}.csr \
        -CA ${CA_ROOT_CERT} \
        -CAkey ${CA_ROOT_KEY} \
        -CAcreateserial \
        -out ${SSL_DIR}/${DNSNAME}.crt \
        -days 1460 \
        -sha512 \
        -extfile ${SSL_DIR}/${DNSNAME}.cnf -extensions 'v3_req'
}

if [ -z ${CA_DIR} ]; then
    echo "Empty certification directory, stop processing!"
    exit 1
fi

if [ -e ${CA_ROOT_CERT} ]; then
    echo "ROOT CA Certificate already created!"
    echo "HINT: If you really want to create a new, delete files from CA directory!"
else
    echo "Generate new ROOT CA ${CA_ROOT_KEY}"
    # Create ROOT CA fo OICD testlab
    openssl req -x509 -new -nodes -extensions v3_ca \
        -newkey rsa:${SSL_KEY_SIZE} \
        -keyout ${CA_ROOT_KEY} \
        -days ${CA_EXPIRE} \
        -out ${CA_ROOT_CERT} \
        -sha512 \
        -subj '/CN=professos/O=PrOfESSOS OICD Test Lab./C=DE'
fi

for DOMAIN_NAME in $(env | grep _HOST= | cut -d "=" -f 2)
do
  create_ssl_certificates ${DOMAIN_NAME}
done
