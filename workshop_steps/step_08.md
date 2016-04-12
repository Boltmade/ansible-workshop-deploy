### 8. Setup nginx and passenger

This is a beefy step, but well worth the switch. Running our app through
`systemd` and `puma` was acceptable, but not _great_. There are several steps:

1. We're going to lean on a galaxy role to get everything started. Add
   `abtris.nginx-passenger` to `playbooks/requirements.txt` and run:

   ```bash
   sudo ansible-galaxy install -r /ansible/playbooks/requirements.txt
   ```
2. Now take advantage of this role: update your `site.yml` to include it
3. Next, configure nginx. Create `/etc/nginx/conf.d/passenger.conf` similar to:

   ```conf
   passenger_app_env        production;
   passenger_default_user   root;
   passenger_default_group  www-data;
   passenger_root           /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
   passenger_ruby           <path-to-rvm-ruby-2.3.0>;
   ```
4. That ruby path: I'm going to give you a nice little `shell` command to
   extract this, since it can be painful to deduce:

   ```bash
   `which passenger-config` --ruby-command | \  # command from passenger to get ruby info
      grep -e Command | \                        # reduce data to just the "Command" line
      sed -n -e 's/^.*Command: //p'              # Drop the start of the line, so we're left with the ruby path
   ```

   You'll need to run this in the right place (for you to figure out!) and
   [`register`][register] the value for use in the previous config.
5. More NGINX configuration. This time, we need to tell it about our rails
   environment variables. You need to modify `/etc/default/nginx` to include
   `source /etc/profile.d/rails_env.sh`.
6. Now install a "site" definition into `/etc/nginx/sites-available/` for our
   rails app. Your `app.conf` will look close to:

   ```conf
   server {
       listen                   80;
       listen                   [::]:80;
       server_name              <your-app-ip>;
       root                     <rails-source>/public;
       passenger_enabled        on;
       passenger_ruby           <path-to-rvm-ruby-2.3.0>;
       passenger_min_instances  5;
   }

   passenger_pre_start http://localhost/ping;
   ```
7. Now to get this running. You need to delete the default nginx site
   `/etc/nginx/sites-enabled/default`. You will also need to make a symlink
   between `/etc/nginx/sites-available/app.conf` and
   `/etc/nginx/sites-enabled/site.conf`
8. A bit of cleanup. We no longer need our `.foreman` file and we need to stop
   our previous `systemd` app task. Keep in mind ansible needs to work on a
   fresh box that may not have this command in existence, so we need to _manage
   failure_ when disabling this `service`.

#### Hints

- checkout the [`template`][template], [`register`][register],
  [`service`][service], and [`file`][file] module
- checkout [`failed_when`][failed_when] to control when a task should fail
- we have a `rails_env` variable!
- remember, whenever you modify anything with nginx, you'll need to restart
  the nginx service
- you will also need to restart nginx whenever you update rails dependencies,
  assets, or run a database migration: `register` is your friend

#### Deploy

```bash
ansible-playbook playbooks/site.yml -i playbooks/production -e "git_branch=step-8"
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
