.. _configuration:

Configuration
=============

.. contents::
    :local:
    :depth: 2

Edit custom.yml
---------------

You need to customize the Ansible_ deployment configuration to install your Twitcher service.
Create a ``custom.yml`` configuration and overwrite any of the variables found in ``group_vars/all``.
There are some prepared sample configurations ``etc/sample-*.yml`` for specific deployments.
Copy one of those to get started.

Use sqlite Database
-------------------

You can use a SQLite_ database with the following settings::

  db_install_postgresql: false
  db_install_sqlite: true

Use PostgreSQL Database installed by playbook
---------------------------------------------

By default the playbook will install a PostgreSQL_ database.
You can customize the installation. For example you can configure a database user::

  db_user: dbuser
  db_password: dbuser

.. warning::

  When you change the database user for an existing database
  the table owners will not be updated.

Use external PostgreSQL Database
--------------------------------

If you want to use an existing database you can skip the database installation by setting the variable::

  db_install_postgresql: false

You need to configure then the database connection string to your external database::

  twitcher_database: "postgresql+psycopg2://user:password@host:5432/twitcher"

Use HTTPS with Nginx
--------------------

You can enable HTTPS for the Nginx service by setting the variable::

  twitcher_enable_https: true

By default it generates a *self-signed* certificate automatically.

You can also provide your own certificate by setting the following variables::

  ssl_certs_local_privkey_path: '/path/to/example.com.key'
  ssl_certs_local_cert_path: '/path/to/example.com.pem'

Read the `ssl-certs role <https://galaxy.ansible.com/jdauphant/ssl-certs>`_ documentation for details.

Use HTTPS with client certificate validation
--------------------------------------------

When HTTPS is enabled (see above) then *optional* client certificate validation for ESGF certificates
is also activated.

Edit the following variables to change the behaviour::

  ssl_certs_enable_verify_client: true
  ssl_certs_verify_client: "optional"
  ssl_certs_cacert_url: "https://github.com/ESGF/esgf-dist/raw/master/installer/certs/esgf-ca-bundle.crt"
