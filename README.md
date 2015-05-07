

scripts\main.os

Скриптом используется файл cfg.bin в качестве файла конфигурации. 

Чтобы сформировать этот файл, нужно в копии файла config.xml.md заполнить свои
параметры и закодировать его командой

oscript scripts\main.os encode config.xml cfg.bin

обратная операция выполняется командой

oscript scripts\main.os decode cfg.bin config.xml

