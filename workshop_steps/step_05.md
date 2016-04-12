### 5. Create templates for foreman config

So far, we've been using `lineinfile` to manage config files. This can be great,
but more often, what we actually want is a `template` or a `file`.

Let's cleanup how we're preparing files for foreman:

1. move creation of `.env` into a template in our `app_web_server` role
2. move creation of `.foreman` into a file in our `app_web_server` role

#### Hints

- checkout the [`template`][template] and [`copy`][copy] module

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
