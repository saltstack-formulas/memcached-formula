memcached
=========

Install and start the memcached service on GNU/Linux and FreeBSD

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``memcached``
-------------

Installs and starts memcached service

``memcached.config``
--------------------

Memcached configuration file

``memcached.python_memcached``
------------------------------

Installs ``python-memcached`` package for RedHat/CentOS and ``python-memcache`` package for Debian

``memcached.libmemcached``
--------------------

Installs libmemcached development files to install ``pylibmc`` as python driver

``memcached.uninstall``
-------------

Stops the memcached service and uninstalls the package.

Instructions
============

1.  Add this repository as a `GitFS backend`_ in your Salt master config.

2.  Determine which minions will run memcached and ``include`` the
    ``memcached`` state.

    One possible example is to run memcached on each server that is also
    running your web application. The following contrived example uses a Django
    web app deployed from an internal Git repository::

        include:
          - memcached
          - memcached.python_memcached

        python-django:
          pkg:
            - installed

        https://internal-repos/mydjangoapp.git:
          git.latest:
            - target: /var/www/mydjangoapp
            - require:
              - pkg: python-django
              - pkg: python-memcached

3.  (Optional) Use Salt Mine to maintain a live list of currently running
    memcached instances in your web application config.

    The following example assumes all web application servers have a hostname
    that starts with "web".

    1.  Configure your Pillar top file (``/srv/pillar/top.sls``)::

            base:
              'web*':
                - application_server

    2.  Configure Salt Mine in ``/srv/pillar/application_server.sls``::

            mine_functions:
              network.interfaces: [eth0]

    3.  Add the IP addresses to your web application config.

        Building on the Django example above, add the following states::

            /var/www/mydjangoapp/config.py:
              file:
                - managed
                - source: salt://mydjangoapp/config.py
                - template: jinja
                - require:
                  - git: https://internal-repos/mydjangoapp.git

        Edit the ``/srv/salt/mydjangoapp/config.py`` template to add the
        memcached server addresses (only relevant portions of ``config.py`` are
        shown)::

            CACHES = {
                'default': {
                    'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
                    'LOCATION': [
                        {% for server,ip in salt['mine.get']('web*', 'network.interfaces', ['eth0']).items() %}
                        '{{ ip }}:11211`,
                        {% endfor %}
                    ]
                }
            }

.. _`GitFS backend`: http://docs.saltstack.com/topics/tutorials/gitfs.html
