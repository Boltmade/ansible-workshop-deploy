Ansible Workshop Deploy
=======================

Requirements
------------

This application is developed with `Vagrant 1.8.0` and `Ansible 2.0` for a `Debian 8` environment.

Setup
-----

To run the application within a Vagrant environment, ensure that you have [Vagrant][1] and
[VirtualBox][2] (or [Parallels][3] on OS X) installed.

### Initial Setup

#### Git Repositories

You will need to clone this repository: `git clone git@github.com:boltmade/ansible-workshop-deploy.git`

You may also want to checkout the application being deployed:
[`boltmade/ansible-workshop-app`][4].

#### Initial Machine Setup

Thanks to the magic of Vagrant, this is dead simple:

```bash
cd ansible-workshop-deploy
vagrant up --provider=virtualbox # OR: vagrant up --provider=parallels
```

You can stop the application and halt the machine by running `vagrant halt` or suspend the machine
by running `vagrant suspend`.

#### Working with the Machine

If you need to apply any updates to your vagrant machine:

```bash
vagrant provision
```

To access the machine:

```bash
vagrant ssh
```

To verify everything is okay:

```bash
ansible-playbook --version # => 2.0.1.4
```

[1]: https://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads
[3]: http://www.parallels.com/products/desktop/
[4]: https://github.com/Boltmade/ansible-workshop-app
