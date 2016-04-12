### 0. Deploy rails app w/ sqlite3

```bash
# sudo password: dancing-red-workshop-ants

git clone git@github.com:boltmade/ansible-workshop-deploy.git
cd ansible-workshop-deploy
git checkout step-0
# modify playbooks/production to reference your <your-app-box-ip>
vagrant up --provider=virtualbox # OR: vagrant up --provider=parallels
vagrant ssh
ssh root@<your-app-box-ip> # verify your password works
exit
ansible-playbook playbooks/site.yml -i playbooks/production -e "git_branch=step-0" -k
# lightly explain what's here while we wait
```

Every step after this assumes you are running withing the vagrant guest.

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
