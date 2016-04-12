### 9. Change DB to postgresql

So far, our rails app was using `sqlite3`. It's finally been updated to take
advantage of a production friendly database: `postgresql`!

There are two primary components: (1) installing and configuring the db itself,
and (2) updating our app setup to consume this db.

The first step requires a new role `db_setup` which:

1. installs db dependencies `postgresql`, `libpq-dev`, and `python-psycopg2`.
2. starts and enables the `postgresql` service
3. initializes the app databases (`workshop_app`, `workshop_app_dev`, and
   `workshop_app_test`), on your chosen port. You will need to execute these
   commands as the `postgres` user.
4. setup a postgresql user for rails, specifying username, password, and port.
   The user also needs role attribute flags of `CREATEDB,NOSUPERUSER`. Again,
   you will need to execute these commands as the `postgres` user.

The second step is a bit simpler:

1. We need to load a `database.yml` configuration into
   `/opt/ansible-workshop-app/config/`:

   ```rb
   #
   # PostgreSql

   default: &default
     adapter: postgresql
     encoding: utf8
     username: <db-rails-user-name>
     password: <db-rails-user-password>
     pool: 5
     timeout: 5000
     host: localhost
     port: <db-port>

   development:
     <<: *default
     database: workshop_app_dev

   test:
     <<: *default
     database: workshop_app_test

   production:
     <<: *default
     database: workshop_app
   ```

#### Hints

- checkout the [`apt`][apt], [`become`][become],
  [`postgresql_db`][postgresql_db], and
  [`postgresql_user`][postgresql_user] module
- you will need to restart the `postgresql` service after any changes to the db
- you likely want variables to manage all of these new values that are popping
  up so it's easy to change and to reduce typing errors

#### Deploy

```bash
ansible-playbook playbooks/site.yml -i playbooks/production -e "git_branch=step-9-plus"
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
