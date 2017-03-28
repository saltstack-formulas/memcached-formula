{% from 'memcached/map.jinja' import memcached with context %}
      
memcached-uninstall:
  service.dead:
    - name: {{ memcached.service }}
    - enable: False
  pkg.removed:
    - pkgs:
      - {{ memcached.server }}
    - require:
      - service: memcached-uninstall
