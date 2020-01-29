.. _testing:

Testing
=======

.. contents::
    :local:
    :depth: 2

Test Ansible with Vagrant
-------------------------

Install Vagrant
+++++++++++++++

You need to install Vagrant_. See the following links for details:

* https://docs.ansible.com/ansible/latest/scenario_guides/guide_vagrant.html
* https://www.vagrantup.com/intro/getting-started/index.html
* https://blog.scriptmyjob.com/creating-an-ansible-testing-environment-using-vagrant-on-macos/

In short, you can install Vagrant on macOS with `Homebrew <https://brew.sh/>`_
(and `Homebrew Cask <https://caskroom.github.io/>`_):

.. code-block:: sh

  $ brew cask install virtualbox
  $ brew cask install vagrant

You need Ansible locally installed:

.. code-block:: sh

  $ conda install -c conda-forge ansible
  OR
  $ brew install ansible # macOS only
  $ export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # workaround needed on macOS

Install Ansible roles:

.. code-block:: sh

  $ ansible-galaxy install -p roles -r requirements.yml --ignore-errors

Run Vagrant
+++++++++++

Use Vagrant config:

.. code-block:: sh

  $ ln -s etc/sample-vagrant.yml custom.yml

Initial setup:

.. code-block:: sh

  $ vagrant up

Provision with Ansible again:

.. code-block:: sh

  $ vagrant provision

Login with SSH:

.. code-block:: sh

  $ vagrant ssh

Run Ansible manually:

.. code-block:: sh

  $ ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory playbook.yml

Remove VMs:

.. code-block:: sh

  $ vagrant destroy -f

Try Twitcher
++++++++++++++++

Run a Twitcher request::

    http://192.168.128.100:8000/

Try other OS
++++++++++++

Configure ``Vagrantfile`` with another `Bento Box <https://app.vagrantup.com/bento>`_::

  twitcher.vm.box = "bento/ubuntu-18.04"

Alternative: use Vagrant without provisioning
---------------------------------------------

Use Vagrant without provisioning and just to setup a new VM::

  $ vagrant destroy -f  # remove previous VM
  $ vagrant up --no-provision  # setup new VM
  $ vagrant ssh  # ssh into VM

Run the installation manually now::

  vagrant> sudo yum install git
  vagrant> git clone https://github.com/bird-house/ansible-twitcher-playbook.git
  vagrant> cd ansible-twitcher-playbook
  vagrant> ./bootstrap.sh
  vagrant> ln -s etc/sample-vagrant.yml custom.yml
  vagrant> ansible-galaxy install -r requirements.yml
  vagrant> ansible-playbook -c local playbook.yml

Test Ansible in a Docker container
----------------------------------

.. warning:: The Nignx and Supervisor services are not automatically started in Docker.
  You need to do this manually. This will be fixed in a later release.

Start an Ubuntu Docker container with mounted local source:

.. code-block:: sh

    $ ./run_docker.sh

Update the configuration:

.. code-block:: sh

    $ ln -s etc/sample-emu.yml custom.yml

Run the Ansible deployment:

.. code-block:: sh

    $ ./bootstrap.sh
    $ make play

Check if application is started (Supervisor_):

.. code-block:: sh

    $ service supervisord status

Check also nginx ... might not start automatically in Docker:

.. code-block:: sh

     $ service nginx status
     $ service nginx start # if not already started

Run a Twitcher request::

    http://192.168.128.100:8000/

Check log files:

.. code-block:: sh

    $ supervisorctl tail -f twitcher
