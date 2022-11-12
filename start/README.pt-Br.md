# Iniciando hbmshell automaticamente

## Windows

### Criando tarefas no agendador

````
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc onstart
````

[Fonte: Microsoft](https://learn.microsoft.com/pt-BR/windows/win32/taskschd/task-scheduler-start-page)


## Linux

### Criando um serviço


[Fonte: Tecnobyte](https://tecnobyte.com.br/124613668/Linux/Como-executar-um-script-na-inicializacao-do-Ubuntu-Linux)
