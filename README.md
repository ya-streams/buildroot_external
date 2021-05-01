# Как собрать прошивку
Итак, исходный код загружен из репозиториев, причем имеет следующую структуру:
```
+-- src/
    +-- br_external/   - каталог с этой инструкцией
    +-- buildroot/     - каталог с исходниками buildroot-а
```
Все дальнейшие действия выполняются из каталога `src`.
Перед сборкой прошивки необходимо доустановить некоторые пакеты, какие именно, зависит от используемого дистрибутива.

Для упрощения этого процесса предлагается собрать docker-образ и собирать прошивку уже внутри контейнера.

## Собираем и запускаем Docker-контейнер (опционально)
Установить Docker:

    см. https://docs.docker.com/engine/install/

Собрать образ:

    ./br_external/docker_setup.sh build

Запустить контейнер:

    ./br_external/docker_setup.sh run

Все описанные ниже действия выполняются из консоли контейнера.

## Собираем прошивку 
Вся разработки над прошивкой велась вне исходного кода Buildroot. Поэтому для сборки используется механизм `br2-external`. Подробнее про него можно прочитать [тут](https://buildroot.org/downloads/manual/manual.html#outside-br-custom). Для более удобного использования этого механизма написан скрипт `env_setup.sh`.

Итого, для сборки нужно подключить скрипт:

    source br_external/env_setup.sh

Выбрать цель сборки:
    
    set_target raspberrypi3_ya_p1
    # или так:
    set_target default

    # эти команды аналогичны 
    # make ..._defconfig

Запустить сборку:

    m all

Результат сборки:
```
+-- src/
    +-- br_external/
        +-- downloads               - архивы с исходниками пакетов
        +-- output                  - каталог, в котором выполняется сборка
            +-- raspberrypi3_ya_p1  - для цели `raspberrypi3_ya_p1`
            +-- ...                 - для других целей
            
```

Синоним `m` аналогичен запуску `make` внутри дерева Buildroot. Т.е. так тоже будет работать:

    # справка
    m help

    # список целей
    m list-defconfigs

    # настроить конфигурацию сборки
    m menuconfig

    # пересобрать всё
    m clean all

