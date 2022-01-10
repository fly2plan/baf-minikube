ui = true
storage "file" {
   path    = "vault"
}
listener "tcp" {
   address     = "0.0.0.0:8200"
   tls_disable = 1
}
max_lease_ttl = "100h"
default_lease_ttl = "100h"