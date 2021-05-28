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

## Зашиваем
```
sudo dd if=br_external/output/raspberrypi3_ya_p1/images/sdcard.img of=/dev/YYY bs=1M conv=fsync
```
YYY - SD-карта и может быть представлена на хосте в виде: `/dev/mmcblk0`, `/dev/sde` или аналогично.
Внимание! Не промахнтесь с выбором параметра `of=` иначе затрёте что-нибудь важное.

## Проверяем

### Звук
Изменить громкости воспроизведения и записи:
```
alsamixer -c0
alsamixer -c1
```

Воспроизвести тестовый звук:
```
speaker-test -twav -c2 -l2
```

Воспроизвести wav-файл:
```
aplay /etc/play_test.wav
mpg123 /etc/play_test.mp3
```

Озвучить текст
```
espeak --stdout "hello world" | aplay
```

Проверить михрофоны
```
speaker-test -f1000 -c1 -tsin 1>/dev/null | arecord -fdat -c4 /tmp/test.wav
```

### LED-кольцо
Проверить работу интерфейса `spidev`
```
python /usr/bin/check_spidev.py
```

Запустить тестовую анимацию
```
python /usr/bin/check_leds.py
```

### Bluetooth стриминг
Подключиться к устройству по bluetooth по имени `rpi3_ya_streams` и воспроивести музыку.
