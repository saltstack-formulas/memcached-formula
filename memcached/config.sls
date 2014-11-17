{% from 'memcached/map.jinja' import memcached with context %}

include:
  - memcached

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
    {% endif %}
    - watch_in:
      - service: memcached
