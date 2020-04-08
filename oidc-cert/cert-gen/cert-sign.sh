#!/bin/bash

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
OU = OIDC TestLab
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
