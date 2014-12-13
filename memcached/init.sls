{% from 'memcached/map.jinja' import memcached with context %}

memcached:
  pkg.installed:
    - name: {{ memcached.server }}
  service.running:
    - enable: True
    - name: {{ memcached.service }}
    - require:
      - pkg: memcached
