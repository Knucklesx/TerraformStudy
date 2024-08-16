# Como fazer #

## 1. Cria o arquivo main.tf e coloca as informações
## 2. Após criar o arquivo main.tf já é possível rodar o comando para conectar com o Terraform
### 2.1. terraform plain e depois terraform apply
## 3. Vai ter sido criada uma máquina virtual no ec2
### 3.1 É possível conectar com a máquina (após criar o par de chaves de segurança)
## 4. Cria o arquivo hosts.yml e outro chamado playbook.yml
## 5. No arquivo hosts.yml coloca-se o nome que se quer chamar aquela conexão entre [], (ex.: [conexão 1]), e, abaixo, o endereço ip da instância do ec2
## 6. No arquivo playbook determina-se o que deve ser feito na instância após a conexão
### 6.1. A exemplo
```
- hosts: terraform-ansible
  tasks: 
  - name: criando o arquivo
    copy: 
      dest: /home/ubuntu/index.html
      content: <h1>Feito com Terraform e Ansible</h1>
  - name: criando o servidor
    shell: "nohup busybox httpd -f -p 8080 &"
  ```

  #### 6.1.1 hosts: é o nome que se deu à conexão no arquivo hosts.yml
  #### 6.1.2 tasks são as tarefas que se deseja serem cumpridas
  #### 6.1.3 copy é a forma de criar um arquivo
  #### 6.1.4 dest é onde o arquivo deve ser criado
  #### 6.1.5 content é o que o deve ser colocado dentro do arquivo
  #### 6.1.6 shell diz qual o comando shell deve ser rodado na instância


  ## 7. Depois disso é preciso fazer o comando "ansible-playbook <NOME_DO_PLAYBOOK> -u <NOME_DE_USUÁRIO_NA_INSTÂNCIA> --private-key <NOME_DA_PRIVATE_KEY> -i <NOME_DO_ARQUIVO_DO_HOSTS>"

  ### 7.1 No exemplo, o nome do playbook é playbook.yml
  ### 7.2 o nome do usuário na instância é ubuntu
  ### 7.3 o nome da private-key é gustavo-nort-virginia.pem
  ### 7.4 o nome do arquivo do hosts é hosts.yml

  ## 8. Depois disso, rodado o comando, deve ter sido criado o que se implementou no playbook na instância




### COMO INSTALAR UM PACOTE NA INSTÂNCIA ###

1.  ```
- hosts: terraform-ansible
  tasks: 
  - name: instalando Python 3 e o virtual env
    apt:
      pkg: 
      - python3
      - virtualenv
      update_cache: yes
    become: yes

  - name: Instalando dependências com pip (Django e DjangoREST)
    pip:
      virtualenv: /home/ubuntu/tcc/venv
      name: 
        - django
        - djangorestframework
      ```

# O argumento become:yes serve para se tornar um super usuário
# O argumento update_cache: yes serve para fazer update no apt



### OUTROS COMANDOS ###

terraform destroy : Destrói a máquina atualmente em atividade

Entrar na VENV = . venv/bin/activate
Ver pacotes instalados na venv = pip freeze
iniciar projeto django = django-admin startproject <NOME_APLICAÇÃO> .
python dar start no arquivo manager = python manage.py runserver 0.0.0.0:8000

### Usando o Django ###
## 1. Depois de tudo instalado iniciado o projeto django e com o comando de start do arquivo manage, dá pra entrar no endereço de ip4 da máquina virtual na porta 8000 
### 1.1. Apesar de passar, no comando python, o endereço 0.0.0.0:8000 ele não vai funcionar nesse endereço, mas sim no endereço na máquina na porta 8000

## 2. Precisa autorizar a requisição no Django
### 2.1. Entra na pasta de setup do django
### 2.2. Com o comando "nano settings.py" é possível abrir o arquivo de settings em um editor de texto
### 2.3. No nano, procurar a linha com o seguinte dizer ALLOWED_HOSTS = [], e alterar para o seguinte ALLOWED_HOSTS = ['*'] e salva o arquivo (ctrl + o e ctrl + x para sair)

### AUTOMATIZANDO O INÍCIO DO PROJETO DJANGO ###

1. Altera o playbook com o seguinte valor
```
  - name: Iniciando o projeto 
    shell: '. /home/ubuntu/tcc/venv/bin/activate; django-admin startproject setup /home/ubuntu/tcc/'
  ```
1.1. Observar que o caminho do venv e da criação da pasta setup devem ser dado por completo, para garantir que não haja problemas

2. Alterando o arquivo settings.py
```
  - name: Alterando o hosts do arquivo settings.py
    lineinfile: 
      path: /home/ubuntu/tcc/setup/settings.py
      regexp: 'ALLOWED_HOSTS'
      line: 'ALLOWED_HOSTS = ["*"]'
      backrefs: yes
```
2.1 O backrefs:yes diz ao ansible que caso não seja encontrado aquela linha ele vai ignorar




