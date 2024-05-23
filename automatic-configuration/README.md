


```shell
ansible -i node_list all -become=yes-method=sudo -m shell -a "netstat -ntpl" --ask-become-pass --ask-pass
```

```shell
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_DEPRECATION_WARNINGS=False
```
