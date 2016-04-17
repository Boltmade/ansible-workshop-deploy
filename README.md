Ansible Workshop Deploy
=======================

Requirements
------------

This application is developed with `Vagrant 1.8.0` and `Ansible 2.0` for a `Debian 8` environment.

Setup
-----

To run the application within a Vagrant environment, ensure that you have [Vagrant][vagrant] and
[VirtualBox][virtualbox] (or [Parallels][parallels] on OS X) installed.

### Initial Setup

#### Git Repositories

You will need to clone this repository: `git clone git@github.com:boltmade/ansible-workshop-deploy.git`

You may also want to checkout the application being deployed:
[`boltmade/ansible-workshop-app`][app].

#### Initial Machine Setup

You need to acquire the vault password from someone on the team, which we'll refer to as
`VAULT_PASS`. Then:

```bash
cd ansible-workshop-deploy
echo "VAULT_PASS" | tee -a playbooks/vault_pass
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
ansible-playbook --version # => 2.0.1.0
```

### Working with Secrets

We are taking advantage of [Ansible Vault][vault]
to store secrets in our source code. Deploy steps will automatically decrypt our secrets files, but
if you wish to encrypt a new file or view/edit any existing files:

```
ansible-vault [encrypt|view|edit] playbooks/path/to/secret_file --vault-password-file playbooks/vault_pass
```

Deployment
----------

We use [Ansible][ansible] to manage our deployments. The vagrant machine comes with this installed.

### Setup

#### Galaxy Roles

If ansible complains about a missing galaxy role, simply run:

```bash
ansible-galaxy install -r playbooks/requirements.txt
```

These are automatically installed during `vagrant provision` and within the vagrant environment on
machine setup.

### Production

Run inside the Vagrant VM:

```bash
ansible-playbook playbooks/site.yml -i playbooks/production --vault-password-file playbooks/vault_pass
```

If you want to refresh the database, append `--extra-vars "should_seed=true"`

### Dry Run

If you wish to view what would happen without making changes you can perform a trial run and,
optionally, request a diff to see the changes, simply append:

```bash
--check [--diff]
```

[vagrant]: https://www.vagrantup.com/downloads.html
[virtualbox]: https://www.virtualbox.org/wiki/Downloads
[parallels]: http://www.parallels.com/products/desktop/
[app]: https://github.com/Boltmade/ansible-workshop-app
[ansible]: http://www.ansible.com/
[vault]: https://docs.ansible.com/ansible/playbooks_vault.html
