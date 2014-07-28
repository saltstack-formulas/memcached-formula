{% from 'memcached/map.jinja' import memcached with context %}
include:
  - memcached

python-memcached:
  pkg:
    - installed
    - name: {{ memcached.python }}
    - require:
      - pkg: memcached
