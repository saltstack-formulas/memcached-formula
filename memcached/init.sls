memcached:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: memcached
