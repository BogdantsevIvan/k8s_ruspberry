# k8s_ruspberry
---

# Разворачивание виртуальных машин в облаке Яндекс при помощи Terraform

Этот репозиторий содержит конфигурацию Terraform, которая позволяет развернуть несколько виртуальных машин в облаке Яндекс. Установить Terraform можно по этой [инструкции](https://cloud.yandex.ru/ru/docs/ydb/terraform/install)

## Начало работы

Для старта ВМ вам потребуется выполнить следующие шаги:

1. Из директории terraform выполнить:
   ```bash
   cp meta.txt-example meta.txt
   ```
   
2. Внести публичную часть вашего ключа в созданный файл meta.txt

3. Из директории terraform выполнить:
   ```bash
   cp my-variables.tfvars-example my-variables.tfvars
   ```

4. Изменить значения переменных в файле my-variables.tfvars на свои

5. Из директории terraform выполнить:
   ```bash
   terraform init
   terraform plan -var-file="./my-variables.tfvars"
   terraform apply -auto-approve -var-file="./my-variables.tfvars"
   ```

6. Для удаления выполнить:
 ```bash
   terraform destroy -auto-approve -var-file="./my-variables.tfvars"
   ```

## Запуск создания кластера k8s
1. Из директории ansible выполнить:
   ```bash
   ansible-playbook -i inventory make_cluster.yml
   ```

## Сборка образа mplc
1. Из директории x64 выполнить:
   ```bash
   docker build -t mplc ./
   ```
2. Создать тег для образа
   ```bash
   docker tag mplc <remote repo and tag>
   ```
   
3. Загрузить образ в удаленное хранилище
   ```bash
   docker push <remote repo and tag>
   ```

## Запуск mplc в k8s
1. В файле manifests/app1.yml заменить название образа и ip адрес балансировщикаы
2. Из директории manifests выполнить:
   ```bash
   kubectl apply -f app1.yml
   ```
---