{% from 'memcached/map.jinja' import memcached with context %}

libmemcached:
  pkg.installed:
    - name: {{ memcached.libmemcached }}
