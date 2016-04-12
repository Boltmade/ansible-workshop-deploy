### 4. Split `site.yml` into roles

This step is all about cleanup. We need to reorganize our ansible playbook to
follow best practices! Our giant ball was great for starting out, but will soon
get in the way.

At the end of this step, `playbooks/site.yml` should have no `tasks`, only
`roles`. I would suggest the following:

1. `apply common configuration to all nodes`'s tasks become a `common` role
2. `install and run the rails app`'s tasks become two roles:
  - `app_setup`: all of our rails tasks
  - `app_web_server`: our `foreman` and `systemd` tasks

These specific roles will be useful in later steps, and fit nicely into a
common pattern I've seen across a few projects. Common setup I want regardless
of remote machine, app "building", and app "execution".

#### Hints

- checkout [best practices](https://docs.ansible.com/ansible/playbooks_best_practices.html)
  for a sample folder structure when building out your roles

#### Deploy

```bash
ansible-playbook playbooks/site.yml -i playbooks/production -e "git_branch=step-1-to-7"
```

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
