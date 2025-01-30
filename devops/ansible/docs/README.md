# Loki Stack + PostgreSQL/PgAdmin + Ansible

### Требования для запуска автоматизации
Для запуска необходим установленный 'ansible', в частности 'ansible-playbook'.

[Документация](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
### Первый запуск
1. Создайте конфигурационный файл 'inventory.ini'
2. Внесите в него необходимые данные.
Пример: 
```ini
[raspberrypi]
server-ip ansible_user=server-user ansible_ssh_private_key_file=/путь/до/ssh/ключа
```
[Документация](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ini_inventory.html)

3. Запуск автоматизации:
```
ansible-playbook -i inventory.ini playbook.yml
```

### Повторный запуск
Если ansible запускаеться не в первые на машине, тогда нужно перед этим удалить старые контенеры: 
```bash
sudo docker rm -v -f $(sudo docker ps -qa)
```

### Задачи
- TODO: Перейти на Grafana, Loki и Promtail
- FIX: Решить проблему с памятью Redpanda 
- FIX: Исправить автоматическое отключение старых конейнеров