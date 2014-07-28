{% from 'memcached/map.jinja' import memcached with context %}

python-memcached:
  pkg:
    - installed
    - name: {{ memcached.python }}
