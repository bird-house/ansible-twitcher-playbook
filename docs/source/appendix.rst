Ansible Hints
=============

Show local variables and facts:

.. code-block:: sh

  $ ansible -m setup -c local localhost


Skip specific tasks for quick tests, for example skip ``conda`` tasks:

.. code-block:: sh

  $ ansible-playbook -c local --skip-tags=conda playbook.yml

Links
=====

.. contents::
    :local:
    :depth: 2


Roles/Recipes from Ansible Galaxy
---------------------------------

Used roles:

* miniconda: https://galaxy.ansible.com/andrewrothstein/miniconda/
* nginx: https://galaxy.ansible.com/geerlingguy/nginx
* supervisor: https://galaxy.ansible.com/geerlingguy/supervisor
* postgresql: https://galaxy.ansible.com/anxs/postgresql
* ssl-certs: https://galaxy.ansible.com/jdauphant/ssl-certs

Alternative roles:

* postgresql: https://galaxy.ansible.com/geerlingguy/postgresql
