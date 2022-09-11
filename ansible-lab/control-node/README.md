# Ansible Instalation

* Windows not suport `NFS`. Run command below:

```sh
vagrant plugin install vagrant-winnfsd
```

### Easy Notes API Test

* Ensure correctly running using curl command:

```curl

curl -X POST http://app01:8080/api/notes -H 'Content-Type: application/json' -d @note.json

```

* Need be executed in `/vagrant` directory inside `control-node` virtual machine 

