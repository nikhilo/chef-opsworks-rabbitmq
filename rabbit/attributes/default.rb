override['rabbitmq']['web_console_ssl'] = true
override['rabbitmq']['web_console_ssl_port'] = 8080

override['rabbitmq']['ssl'] = true
override['rabbitmq']['ssl_cacert'] = '/etc/rabbitmq/ssl/cacert.pem'
override['rabbitmq']['ssl_cert'] = '/etc/rabbitmq/ssl/cert.pem'
override['rabbitmq']['ssl_key'] = '/etc/rabbitmq/ssl/key.pem'
override['rabbitmq']['ssl_verify'] = 'verify_none'
override['rabbitmq']['ssl_fail_if_no_peer_cert'] = false
