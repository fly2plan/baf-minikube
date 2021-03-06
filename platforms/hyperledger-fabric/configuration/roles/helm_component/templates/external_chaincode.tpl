apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: {{ component_name }}
  namespace: {{ component_ns }}
  annotations:
    fluxcd.io/automated: "false"
spec:
  releaseName: {{ component_name }}
  chart:
    git: {{ git_url }}
    ref: {{ git_branch }}
    path: {{ charts_dir }}/external_chaincode    
  values:
    metadata:
      name: {{ component_name }}
      namespace: {{ component_ns }}
      images:
        external_chaincode: {{ extcc_image }}
        alpineutils: {{ alpine_image }}
      chaincode_ccid: {{ chaincode_ccid }}
    storage:
      storageclassname: {{ org_name }}sc
      storagesize: 512Mi
    service:
      servicetype: ClusterIP
      ports:
        chaincode:
          clusteripport: {{ peer.chaincode.port }}
{% if orderer.grpc.nodePort is defined %}
          nodeport: {{ peer.chaincode.nodePort }}
{% endif %}
    vault:
      role: vault-role
      address: {{ vault.url }}
      authpath: {{ network.env.type }}{{ component_ns }}-auth
      adminsecretprefix: {{ vault.secret_path | default('secret') }}/crypto/peerOrganizations/{{ component_ns }}/users/admin
      orderersecretprefix: {{ vault.secret_path | default('secret') }}/crypto/peerOrganizations/{{ component_ns }}/orderer
      serviceaccountname: vault-auth
      imagesecretname: regcred
      tls: false
    peer:
      name: {{ peer.name }}
      localmspid: {{ org.name | lower}}MSP
      tlsstatus: true
{% if network.env.proxy == 'none' %}
      address: {{ peer.name }}.{{ component_ns }}:7051
{% else %}
      address: {{ peer.peerAddress }}
{% endif %}
    orderer:
      address: {{ orderer.uri }}
    proxy:
      provider: {{ network.env.proxy }}
      external_url_suffix: {{ org.external_url_suffix }}