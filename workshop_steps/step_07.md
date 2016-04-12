### 7. Export rails environment variables

We've been using a mix of the `environment` option in tasks, and a `.env`
file for foreman. This can be tempormental, so let's expose all of our rails
environment variables as part of user login, and source this file when
necessary.

You'll need to create a new file, `/etc/profile.d/rails_env.sh` that looks
similar to:

```bash
export RAILS_ENV=production
export RACK_ENV=production
export SECRET_KEY_BASE=<my-secret>
export RAILS_SERVE_STATIC_FILES=yes
```

Once this file exists, you'll need to load it before you migrate the rails
database. This can be done by prepending `. /etc/profile.d/rails_env.sh && ` to
the existing command.

Having these values exist in our environment also removes our need of creating
the `.env` file, so we can remove that task!

#### Hints

- checkout the [`template`][template] module
- we have a `rails_env` and `secret_key_base` variable!

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
