path "{{ vault_secret_path }}/crypto/ordererOrganizations/{{ component_name }}/*" {
    capabilities = ["read", "list","create", "update"]
}
path "{{ vault_secret_path }}/*" {
    capabilities = ["list","create", "read", "update"]
}
path "{{ vault_secret_path }}/crypto/peerOrganizations/*" {
    capabilities = ["deny"]
}
path "{{ vault_secret_path }}/credentials/{{ component_name }}/*" {
    capabilities = ["read", "list","create", "update"]
}
