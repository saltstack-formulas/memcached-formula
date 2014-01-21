memcached:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: memcached
    - watch: 
      - file: /etc/memcached.conf
  
/etc/memcached.conf:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://memcached/templates/memcached.conf
    - require:
      - pkg: memcached