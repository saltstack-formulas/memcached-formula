include:
  - memcached

/etc/memcached.conf:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://memcached/templates/memcached.conf
    - watch_in:
      - service: memcached
