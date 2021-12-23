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
    path: {{ charts_dir }}/fabric_cli    
  values:
    metadata:
      namespace: {{ component_ns }}
      images:
        fabrictools: {{ fabrictools_image }}
        alpineutils: {{ alpine_image }}
      network:
        version: {{ network_version }}
    storage:
      class: {{ storage_class }}
      size: 256Mi
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
{% if '2.' in network.version %}
    endorsers:
{% for org in channel.participants %}
{% if org.type == 'creator' %}
        creator: {{ component_ns }}
{% endif %}
{% endfor %}
        name: {% for name in channel.endorsers.name %} {{ name }} {% endfor %} 
        corepeeraddress: {% for address in channel.endorsers.corepeerAddress %} {{ address }} {% endfor %}
{% else %}
    endorsers:
        creator: {{ component_ns }}
        name: {{ peer_name }}
        corepeeraddress: {{ peer_address }}
{% endif %}
