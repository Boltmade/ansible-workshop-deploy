### 12. Split DB onto separate server

Splitting services across multiple boxes is often a painful process in "simpler"
deploy setups. Ansible is very easy! Most of the difficulty comes in configuring
the services themselves to accept remote connections correctly.

Diving in:

1. Update your inventory file (`playbooks/production`) to include a new group:

   ```
   [db_servers]
   <your-db-box-ip>
   ```

   Make sure you update the `production` group to include this group as well!
2. You'll want two global variables to track your `<main-web-ip>` and
   `<main-db-ip>`. In our case, we only have one of each, but this is still
   necessary.
3. Over in `db_setup`, we need to tweak a few more postgresql settings:

   You need to ensure `/etc/postgresql/9.4/main/pg_hba.conf` contains
   `host all <db-rails-user-name> <main-web-ip>/32 md5`

   You also need to ensure the postgresql config is setup to allow remote
   connections. Ensure `/etc/postgresql/9.4/main/postgresql.conf` contains
   `listen_addresses = '*'`.
4. Now you need to update your `app_setup` to point to the new server location,
   updating the `host` in your `database.yml`.
5. Also, now that your web boxes are no longer running `postgresql`, you need
   to install `libpq-dev`.
6. After all this, you will likely need to tweak your `site.yml` to be in the
   correct order for everything to work.

#### Hints

- checkout the [`lineinfile`][lineinfile] module
- you will need to restart the `postgresql` service after any changes to the db

#### Deploy

```bash
ansible-playbook playbooks/site.yml -i playbooks/production --vault-password-file playbooks/vault_pass -e "git_branch=step-9-plus"
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
