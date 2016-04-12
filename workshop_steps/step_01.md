### 1. Remove `therubyracer`

Our rails app has stopped using a gem callled `therubyracer`. Update
`playbooks/site.yml` to:

1. install `nodejs`
2. create a symbolic link from `/usr/bin/nodejs` to `/usr/bin/node` (a quirk
   of using debian)

#### Hints

- checkout the [`apt`][apt] and [`file`][file] modules

#### Deploy

```bash
# sudo password: dancing-red-workshop-ants

ansible-playbook playbooks/site.yml -i playbooks/production -e "git_branch=step-1-to-7" -k
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
