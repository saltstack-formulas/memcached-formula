{% from 'memcached/map.jinja' import memcached with context %}
{% from 'memcached/macros.sls' import get_config_item with context -%}

include:
  - memcached
  
memcached_user:
  user.present:
    - name : {{ get_config_item('user') }}
    - createhome: False
    - shell: /sbin/nologin

{{ memcached.config_file }}:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    {% if grains['os_family'] == 'Debian' %}
    - source: salt://memcached/templates/memcached.conf
    {% elif grains['os_family'] == 'RedHat' %}
    - source: salt://memcached/templates/sysconfig/memcached
    {% elif grains['os_family'] == 'Gentoo' %}
    - source: salt://memcached/templates/conf.d/memcached
    {% elif grains['os_family'] == 'Arch' %}
    - source: salt://memcached/templates/empty
    {% endif %}
    - watch_in:
      - service: memcached
    - require:
      - user: memcached_user

