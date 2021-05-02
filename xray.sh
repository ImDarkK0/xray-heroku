#!/bin/sh

#change localtime
#rm -rf /etc/localtime
#cp /usr/share/zoneinfo/Asia/Colombo /etc/localtime

# config xray
cat << EOF > /etc/config.json
{
  "inbounds":[
        {
            "port": $PORT,
            "listen": "127.0.0.1",
            "protocol": "$PROTOCOL",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID", 
                        "level": 0,
                        "email": "love@example.com"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true, 
                    "path": "/websocket"
                }
            }
        }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}	
EOF

# run xray
/usr/bin/xray run -config /etc/config.json
