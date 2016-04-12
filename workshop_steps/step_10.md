### 10. Introduce secrets and ansible vault

This is about keeping our secrets, secret. It allows you to store encrypted
files in your source, that ansible knows how to decrypt.

To take advantage of ansible vault:

1. Make a new file `playbooks/vault_pass` that contains a reasonably complex
   password. This is what will be used to encrypt/decrypt your files! Make
   sure you also add this file to your `.gitignore`
2. Split out values you want encrypted. I suggest making a file for your db
   password, and your rails secret key. For an example, let's split out the
   rails secret key base.
   - create a file `playbooks/group_vars/all/vaulted_secret_key_base` which
     contains:

     ```yml
     ---
     vaulted_secret_key_base: <my-secret-key-base>
     ```
   - modify `playbooks/group_vars/all/main.yml` to instead include:

     ```yml
     secret_key_base: "{{ vaulted_secret_key_base }}"
     ```
   - rinse and repeat until you've split out all of your secrets!
   - now to encrypt them:

     ```bash
     ansible-vault [encrypt|view|edit] playbooks/path/to/secret_file --vault-password-file playbooks/vault_pass
     ```

#### Deploy

Deploys will now always need to include
`--vault-password-file playbooks/vault_pass` to decrypt our secrets!

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
