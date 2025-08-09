# ExaBGP Flowspec Redirect-to-IP Test Environment (Docker Compose)

This repository provides a ready-to-use Docker Compose environment to test **BGP Flowspec Redirect-to-IP** functionality using [ExaBGP](https://github.com/Exa-Networks/exabgp).  
It supports both IPv4 and IPv6 Flowspec rules and demonstrates different Redirect-to-IP encoding formats (classic `redirect-to-nexthop` and `redirect-to-nexthop-ietf`).

---

## Features

- Runs multiple ExaBGP containers for Flowspec testing.
- Supports both **IPv4** and **IPv6** Flowspec NLRI.
- Demonstrates Redirect-to-IP using:
  - `redirect-to-nexthop` (classic)
  - `redirect-to-nexthop-ietf` (IETF draft format)
- Simple startup with `docker compose up -d`.

---

## Getting Started

### 1. Start the environment

```bash
docker compose up -d
```

This will launch multiple ExaBGP instances configured for Flowspec testing.

---

### 2. Check BGP session status

To confirm that BGP sessions are established:

```bash
docker exec -it exabgp_flowspec_redirect-exabgp2-1 exabgp-cli show neighbor summary
```

Example output:

```
Peer            AS     up/down state       |   #sent  #recvd
192.0.2.1       65000  0:02:57 established |       1       3
2001:db8:1:1::1 65000  0:02:57 established |       1       3
```

---

### 3. View received Flowspec routes

To inspect the Adj-RIB-In:

```bash
docker exec exabgp_flowspec_redirect-exabgp2-1 exabgp-cli show adj-rib in extensive
```

Example output:

```
neighbor 192.0.2.1 local-ip 192.0.2.2 local-as 65000 peer-as 65000 router-id 192.0.2.2 family-allowed in-open ipv4 flow flow destination-ipv4 198.51.100.0/25 next-hop 192.0.2.100 origin igp local-preference 100 extended-community redirect-to-nexthop
neighbor 192.0.2.1 local-ip 192.0.2.2 local-as 65000 peer-as 65000 router-id 192.0.2.2 family-allowed in-open ipv4 flow flow destination-ipv4 198.51.100.128/25 origin igp local-preference 100 extended-community redirect-to-nexthop-ietf 192.0.2.100
neighbor 2001:db8:1:1::1 local-ip 2001:db8:1:1::2 local-as 65000 peer-as 65000 router-id 192.0.2.2 family-allowed in-open ipv6 flow flow destination-ipv6 2001:db8:2:1::/64/0 next-hop 2001:db8:1:1::100 origin igp local-preference 100 extended-community redirect-to-nexthop
neighbor 2001:db8:1:1::1 local-ip 2001:db8:1:1::2 local-as 65000 peer-as 65000 router-id 192.0.2.2 family-allowed in-open ipv6 flow flow destination-ipv6 2001:db8:2:2::/64/0 origin igp local-preference 100 attribute [ 0x19 0xC0 redirect-to-nexthop-ietf 2001:db8:1:1::100 ]
```

---

## How It Works

- **Flowspec rules** are advertised from one ExaBGP container to another over established BGP sessions.
- Extended Communities are used to signal **Redirect-to-IP** actions.
- Both traditional and IETF draft encodings are demonstrated for compatibility testing.

---

## Requirements

- Docker
- Docker Compose

---

## References

- [RFC 8955 – Dissemination of Flow Specification Rules](https://datatracker.ietf.org/doc/html/rfc8955)
- [IETF Draft – Redirect-to-IP Action for BGP Flowspec](https://datatracker.ietf.org/doc/draft-ietf-idr-flowspec-redirect-ip/)
- [ExaBGP Documentation](https://github.com/Exa-Networks/exabgp)

---

## License

This project is licensed under the MIT License.
