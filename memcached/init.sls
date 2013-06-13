memcached:
  pkg:
    - instaled
  service:
    - running
    - enable: True
    - require:
      - pkg: memcached
