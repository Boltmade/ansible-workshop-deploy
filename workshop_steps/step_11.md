### 11. Introduce an `app_user`

You really don't want to be running everything (or anything, depending who you
ask) as `root`. Create a new user, set them up with your ssh keys, and take
advantage of the `become` module. This changes **lots** of files, but it's
reasonably straightforward.

Watch out for file permission issues! Since everything was previously owned
by root, you might run into cases where you need to clean ownership up.

Also be warned: the previous variant of this command was `sudo` and
`sudo_user`. If you see these commands while googling, remember to update them 
to `become` and `become_user` respectively.

#### Hints

- checkout the [`become`][become] module

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
