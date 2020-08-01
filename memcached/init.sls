{% from 'memcached/map.jinja' import memcached with context %}

memcached:
        {%- if grains.os_family in ('FreeBSD',) %}
  cmd.run:
    - names:
      - portsnap fetch
      - portsnap extract
      - cd /usr/ports/distfiles
      - curl -LO https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz
      - cd /usr/ports/databases/memcached && make deinstall && make install clean
    - env:
      - BATCH: 'yes'
  sysrc.managed:
    - name: memcached_enable
    - value: YES
    - require:
      - cmd: memcached
        {%- else %}
  pkg.installed:
    - name: {{ memcached.server }}
    - runas: {{ memcached.rootuser }}
        {%- endif %}
    - require_in:
      - service: memcached
  service.running:
    - enable: True
    - name: {{ memcached.service }}
