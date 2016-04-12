### 6. Create handlers

We have been manually restarting services as needed everytime we deploy, but
there's a better way! Handlers let you `notify` on a per task basis something
that needs to be done _eventually_, but not immediatly. If you have 2 tasks
that want `ssh` restarted, ansible can be smart only restart it once, after
both tasks have finished. It even knows if those tasks did anything, and can
skip the restart if it's not needed!

Let's add some handlers in:

1. for `common`, create a `restart ssh` handler
2. for `app_web_server`, create a `restart app` handler

#### Hints

- checkout the [`handler`][handler] module

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
