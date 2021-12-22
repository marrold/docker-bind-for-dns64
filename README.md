
# Docker BIND for DNS64

*Docker BIND for NAT64* is a docker container for running BIND as a simple forwarder with DNS64 support.

It's available on Docker Hub [Here](https://hub.docker.com/repository/docker/marrold/docker-bind-for-dns64)

## Caveats

- There's currently no validation to ensure that environment variables are included and correct. This can result in a broken named.conf and BIND will refuse to start.
- I've not tested this in a high load, production type environment

## Usage

### docker-compose.yaml
    ---
    version: "2.1"

    services:
      bind-for-dns64:
        image: marrold/docker-bind-for-dns64:latest
        container_name: bind-for-dns64
        environment:
          - PUID=5000
          - PGID=5000
          - TZ=Europe/London
          - BIND_MAX_CACHE=128m
          - BIND_LISTEN_PORT=53
          - BIND_LISTEN_IPV4=any
          - BIND_LISTEN_IPV6=any
          - BIND_QUERY_ACL=10.0.0.0/8,172.16.0.0/12,192.168.0.0/16
          - BIND_NAT64_TRANSLATOR_ACL=127.0.0.1/32
          - BIND_FORWARDERS=1.1.1.1,1.0.0.1
          - BIND_NAT64_PREFIX=64:ff9b::/96
          - BIND_RNDC_KEY_ALGORITHM=hmac-sha256
          - BIND_RNDC_KEY_SECRET=u/ULUGT0p7GPnpXYEVkWztv3fKi5hURD9PyJnvqMhZQ=
        ports:
          - 53:53/tcp
          - 53:53/udp
        restart: unless-stopped

#### Environment Variables

 | **Var** | **Usage** | **Example** | **Optional**
 |-|-|-|-|
 | `PUID` | User ID to use inside the container | 5000 | Y |
 | `PGID` | Group ID to use inside the container | 5000 | Y |
 | `TZ` | Timezone to use inside the container | BIND_TRANSFER_KEY_SECRET | Y |
 | `BIND_MAX_CACHE` | Maximum size for cached DNS records | 128m |  Y |
 | `BIND_LISTEN_PORT` | Port to listen on | 53 | N |
 | `BIND_LISTEN_IPV4` | Interface to listen on | any | N |
 | `BIND_LISTEN_IPV6` | Interface to listen on | any |N |
 | `BIND_QUERY_ACL` | The subnet(s) to allow queries from. It should be a comma separated list without spaces. | 10.0.0.0/8,172.16.0.0/12,192.168.0.0/16 | N |
 | `BIND_NAT64_TRANSLATOR_ACL` | The subnet(s) containing NAT64 translators that we want to prevent from receiving DNS64 replies. It should be a comma separated list without spaces. | 10.0.0.0/8,172.16.0.0/12,192.168.0.0/16 | N |
 | `BIND_FORWARDERS` | The forwarder(s) to forward requests to. It should be a comma separated list without spaces.  | 1.1.1.1,1.0.0.1 | N |
 | `BIND_NAT64_PREFIX` | The IPv6 prefix you're using for NAT64 translation | 64:ff9b::/96 | N |
 | `BIND_RNDC_KEY_ALGORITHM` | The algorithm used for the RNDC key. (For adminstrating BIND with the rndc tool) | hmac-sha256 | Y |
 | `BIND_RNDC_KEY_SECRET` | The secret used for the RNDC key. (For adminstrating BIND with the rndc tool) | u/ULUGT0p7GPnpXYEVkWztv3fKi5hURD9PyJnvqMhZQ= | Y |


## License

This project is licensed is licensed under the terms of the _MIT license_. For other dependencies such as Docker, please see their relevant licenses.

