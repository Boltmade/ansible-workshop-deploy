### 3. SSH Keys!

So typing your sudo password everytime is pretty annoying. Let's up our
security and make life happier. There are a few steps:

1. Generate yourself an ssh key in your vagrant machine. [GitHub][ssh-key]
   has a great resource if you've never done this before! I would suggest
   for this workshop to not use a passphrase, to keep life simple.
2. Copy your new `<id_rsa>.pub` into a new folder `playbooks/public_keys`.
   Update `playbooks/site.yml` to setup an authorized key for root.
3. Disallow password auth. Generally, you'll need to modify
   `/etc/ssh/sshd_config` to replace any line around `PasswordAuthentication`
   with `PasswordAuthentication no`.
4. Restart the `ssh` service.

#### Hints

- checkout the [`authorized_key`][authorized_key] module, noting `with_file`
- checkout the [`lineinfile`][lineinfile] module, noting `regexp` option
  module
- checkout the [`service`][service] module

#### Deploy

```bash
# sudo password: dancing-red-workshop-ants

ansible-playbook playbooks/site.yml -i playbooks/production -e "git_branch=step-1-to-7" -k
ssh root@<your-app-box-ip> # should login with no password prompt!
```

You no longer need to type the `-k` option! Yay!

[apt]: https://docs.ansible.com/ansible/apt_module.html
[become]: https://docs.ansible.com/ansible/become.html
[authorized_key]: https://docs.ansible.com/ansible/authorized_key_module.html
[copy]: https://docs.ansible.com/ansible/copy_module.html
[failed_when]: https://docs.ansible.com/ansible/playbooks_error_handling.html
[file]: https://docs.ansible.com/ansible/file_module.html
[handler]: https://docs.ansible.com/ansible/glossary.html#term-handlers
[lineinfile]: https://docs.ansible.com/ansible/lineinfile_module.html
[postgresql_db]: https://docs.ansible.com/ansible/postgresql_db_module.html
[postgresql_user]: https://docs.ansible.com/ansible/postgresql_user_module.html
[register]: https://docs.ansible.com/ansible/playbooks_conditionals.html#register-variables
[service]: https://docs.ansible.com/ansible/service_module.html
[ssh-key]: https://help.github.com/articles/generating-an-ssh-key/
[template]: https://docs.ansible.com/ansible/template_module.html
