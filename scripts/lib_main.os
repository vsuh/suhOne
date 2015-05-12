﻿Перем мНастройки Экспорт;
Перем iCaller;

Процедура СообщениеСборки(Знач Сообщение) Экспорт

	iCaller.СообщениеСборки(Сообщение);

КонецПроцедуры

Функция ПолучитьЗначениеВПопытке(хОбъект, хРеквизит) Экспорт
    Попытка
        Возврат хОбъект[хРеквизит];
    Исключение
        Возврат Неопределено;
    КонецПопытки;
    Возврат Неопределено;
КонецФункции

Функция ПреобразоватьЗначениеВДатуВремя(Значение) Экспорт
    Попытка
        Возврат Дата(Лев(Значение,14));
    Исключение
        Возврат Дата("00010101");
    КонецПопытки;
    Возврат Дата("00010101");
КонецФункции

Функция ПреобразоватьЗначениеВЧисло(Значение) Экспорт
    Попытка
        Возврат Число(Значение);
    Исключение
        Возврат 0;
    КонецПопытки;
    Возврат 0;
КонецФункции

Процедура УдалитьПоследнийСимволВСтроке(Текст, ЧислоСимволов) Экспорт

    Текст = Лев(Текст, СтрДлина(Текст) - ЧислоСимволов);

КонецПроцедуры

Функция ПреобразоватьСтрокуВМассив(ИсхСтрока, Разделитель = ",") Экспорт
	Результат = Новый Массив;
	Позиция = Найти(ИсхСтрока, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(ИсхСтрока, Позиция - 1);
		Если Не ПустаяСтрока(Подстрока) Тогда
			Результат.Добавить(Подстрока);
		КонецЕсли;
		ИсхСтрока = Сред(ИсхСтрока, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(ИсхСтрока, Разделитель);
	КонецЦикла;

	Если Не ПустаяСтрока(ИсхСтрока) Тогда
		Результат.Добавить(ИсхСтрока);
	КонецЕсли;

	Возврат Результат;
КонецФункции

Процедура ИнициализацияСкриптШелла() Экспорт
	Попытка
        объШелл = Новый COMОбъект("Wscript.Shell");
    Исключение
    КонецПопытки;

КонецПроцедуры

Процедура Пауза(Сек) Экспорт
   Попытка
      xPing = "ping -n 1 -w "+Формат(1000*Сек, "ЧГ=0")+" 127.255.255.255";
      WshShell = Новый COMОбъект("WScript.Shell");
      WshShell.Run(xPing, 0, -1);
   Исключение
   КонецПопытки;

КонецПроцедуры

Функция ПолучитьСоединениеСИБ(ИБимя, Сервер, Пользователь, Пароль) Экспорт
   	КОМ = Новый COMОбъект("V82.COMConnector");
	Попытка
		комСоединение = КОМ.Connect("Srvr="+Сервер+";Ref="+ИБимя+";Usr="+Пользователь+";Pwd="+Пароль+";");
		Возврат комСоединение;
	Исключение
		Сообщить("Не удалось соединиться с ИБ "+ИБимя+Символы.ПС+ОписаниеОшибки());
		Возврат Неопределено;
	КонецПопытки;

КонецФункции

Процедура ЗагрузитьДТ(номИБ, ДТ) Экспорт
	Сообщить("Загрузка файла "+ ДТ +" в ИБ " + мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))]);

	ИсполняемыйФайл1С = """"+мНастройки[ПреобразоватьИмяНастройки("param_v8.executable")]+"""";
	КоманднаяСтрокаРабочейБазы =
	мНастройки[ПреобразоватьИмяНастройки("param_server.host")] + "\" +
	мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))];
	ПараметрыСвязиСБазой = Новый Массив;
	ПараметрыСвязиСБазой.Добавить(ИсполняемыйФайл1С);
	ПараметрыСвязиСБазой.Добавить("DESIGNER");
	ПараметрыСвязиСБазой.Добавить("/S """ + КоманднаяСтрокаРабочейБазы + """");
	Если Не ПустаяСтрока(мНастройки[ПреобразоватьИмяНастройки("ib_user."+СокрЛП(номИБ))]) Тогда
		ПараметрыСвязиСБазой.Добавить("/N""" + мНастройки[ПреобразоватьИмяНастройки("ib_user."+СокрЛП(номИБ))] + """");
	КонецЕсли;
	Если Не ПустаяСтрока(мНастройки[ПреобразоватьИмяНастройки("ib_password."+СокрЛП(номИБ))]) Тогда
		ПараметрыСвязиСБазой.Добавить("/P""" + мНастройки[ПреобразоватьИмяНастройки("ib_password."+СокрЛП(номИБ))] + """");
	КонецЕсли;
	ПараметрыСвязиСБазой.Добавить("/WA+");
	ПараметрыСвязиСБазой.Добавить("/UC """ + мНастройки[ПреобразоватьИмяНастройки("param_ib.lock.code")] + """");

	ПараметрыСвязиСБазой.Добавить("/RestoreIB """+ДТ+"""");

	ПараметрыСвязиСБазой.Добавить("/Out """+мНастройки[ПреобразоватьИмяНастройки("param_log")]+"\indt_"+мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))]+".log"+"""");

	КодВозврата = ЗапуститьИПодождать(ПараметрыСвязиСБазой);
	Если КодВозврата = 0 Тогда
	КонецЕсли;

КонецПроцедуры

Процедура ЗагрузитьCF(номИБ, CF) Экспорт
	Сообщить("Загрузка файла конфигурации "+ CF +" в ИБ " + мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))]);

	ИсполняемыйФайл1С = """"+мНастройки[ПреобразоватьИмяНастройки("param_v8.executable")]+"""";
	КоманднаяСтрокаРабочейБазы =
	мНастройки[ПреобразоватьИмяНастройки("param_server.host")] + "\" +
	мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))];
	ПараметрыСвязиСБазой = Новый Массив;
	ПараметрыСвязиСБазой.Добавить(ИсполняемыйФайл1С);
	ПараметрыСвязиСБазой.Добавить("DESIGNER");
	ПараметрыСвязиСБазой.Добавить("/S """ + КоманднаяСтрокаРабочейБазы + """");
	Если Не ПустаяСтрока(мНастройки[ПреобразоватьИмяНастройки("ib_user."+СокрЛП(номИБ))]) Тогда
		ПараметрыСвязиСБазой.Добавить("/N""" + мНастройки[ПреобразоватьИмяНастройки("ib_user."+СокрЛП(номИБ))] + """");
	КонецЕсли;
	Если Не ПустаяСтрока(мНастройки[ПреобразоватьИмяНастройки("ib_password."+СокрЛП(номИБ))]) Тогда
		ПараметрыСвязиСБазой.Добавить("/P""" + мНастройки[ПреобразоватьИмяНастройки("ib_password."+СокрЛП(номИБ))] + """");
	КонецЕсли;
	ПараметрыСвязиСБазой.Добавить("/WA+");
	ПараметрыСвязиСБазой.Добавить("/UC """ + мНастройки[ПреобразоватьИмяНастройки("param_ib.lock.code")] + """");

	ПараметрыСвязиСБазой.Добавить("/LoadCfg  """+CF+"""");

	ПараметрыСвязиСБазой.Добавить("/Out """+мНастройки[ПреобразоватьИмяНастройки("param_log")]+"\incf_"+мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))]+".log"+"""");

	КодВозврата = ЗапуститьИПодождать(ПараметрыСвязиСБазой);
	Если КодВозврата = 0 Тогда
	КонецЕсли;

КонецПроцедуры

Процедура ВыгрузитьCF(номИБ, CF) Экспорт
	Сообщить("Сохраниение конфигурации ИБ " + мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))]+" в файл "+CF);

	ИсполняемыйФайл1С = """"+мНастройки[ПреобразоватьИмяНастройки("param_v8.executable")]+"""";
	КоманднаяСтрокаРабочейБазы =
	мНастройки[ПреобразоватьИмяНастройки("param_server.host")] + "\" +
	мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))];
	ПараметрыСвязиСБазой = Новый Массив;
	ПараметрыСвязиСБазой.Добавить(ИсполняемыйФайл1С);
	ПараметрыСвязиСБазой.Добавить("DESIGNER");
	ПараметрыСвязиСБазой.Добавить("/S """ + КоманднаяСтрокаРабочейБазы + """");
	Если Не ПустаяСтрока(мНастройки[ПреобразоватьИмяНастройки("ib_user."+СокрЛП(номИБ))]) Тогда
		ПараметрыСвязиСБазой.Добавить("/N""" + мНастройки[ПреобразоватьИмяНастройки("ib_user."+СокрЛП(номИБ))] + """");
	КонецЕсли;
	Если Не ПустаяСтрока(мНастройки[ПреобразоватьИмяНастройки("ib_password."+СокрЛП(номИБ))]) Тогда
		ПараметрыСвязиСБазой.Добавить("/P""" + мНастройки[ПреобразоватьИмяНастройки("ib_password."+СокрЛП(номИБ))] + """");
	КонецЕсли;
	ПараметрыСвязиСБазой.Добавить("/WA+");
	ПараметрыСвязиСБазой.Добавить("/UC """ + мНастройки[ПреобразоватьИмяНастройки("param_ib.lock.code")] + """");

	ПараметрыСвязиСБазой.Добавить("/DumpCfg  """+CF+"""");

	ПараметрыСвязиСБазой.Добавить("/Out """+мНастройки[ПреобразоватьИмяНастройки("param_log")]+"\outcf_"+мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))]+".log"+"""");

	КодВозврата = ЗапуститьИПодождать(ПараметрыСвязиСБазой);
	Если КодВозврата = 0 Тогда
	КонецЕсли;

КонецПроцедуры

Процедура ВыгрузитьДТ(номИБ, ДТ) Экспорт
	Сообщить("Выгрузка файла "+ ДТ +" из ИБ " + мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))]);

	ИсполняемыйФайл1С = """"+мНастройки[ПреобразоватьИмяНастройки("param_v8.executable")]+"""";
	КоманднаяСтрокаРабочейБазы =
	мНастройки[ПреобразоватьИмяНастройки("param_server.host")] + "\" +
	мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))];
	ПараметрыСвязиСБазой = Новый Массив;
	ПараметрыСвязиСБазой.Добавить(ИсполняемыйФайл1С);
	ПараметрыСвязиСБазой.Добавить("DESIGNER");
	ПараметрыСвязиСБазой.Добавить("/S """ + КоманднаяСтрокаРабочейБазы + """");
	Если Не ПустаяСтрока(мНастройки[ПреобразоватьИмяНастройки("ib_user."+СокрЛП(номИБ))]) Тогда
		ПараметрыСвязиСБазой.Добавить("/N""" + мНастройки[ПреобразоватьИмяНастройки("ib_user."+СокрЛП(номИБ))] + """");
	КонецЕсли;
	Если Не ПустаяСтрока(мНастройки[ПреобразоватьИмяНастройки("ib_password."+СокрЛП(номИБ))]) Тогда
		ПараметрыСвязиСБазой.Добавить("/P""" + мНастройки[ПреобразоватьИмяНастройки("ib_password."+СокрЛП(номИБ))] + """");
	КонецЕсли;
	ПараметрыСвязиСБазой.Добавить("/WA+");
	ПараметрыСвязиСБазой.Добавить("/UC """ + мНастройки[ПреобразоватьИмяНастройки("param_ib.lock.code")] + """");

	ПараметрыСвязиСБазой.Добавить("/DumpIB """+ДТ+"""");

	ПараметрыСвязиСБазой.Добавить("/Out """+мНастройки[ПреобразоватьИмяНастройки("param_log")]+"\outdt_"+мНастройки[ПреобразоватьИмяНастройки("ib_ib."+СокрЛП(номИБ))]+".log"+"""");

	КодВозврата = ЗапуститьИПодождать(ПараметрыСвязиСБазой);
	Если КодВозврата = 0 Тогда
	КонецЕсли;

КонецПроцедуры

Функция ЗапуститьИПодождать(Знач Параметры) Экспорт

	СтрокаЗапуска = "";
	СтрокаДляЛога = "";
	Для Каждого Параметр Из Параметры Цикл
		СтрокаЗапуска = СтрокаЗапуска + " " + Параметр;
	КонецЦикла;
	КодВозврата = 0;
	Если Не ПустаяСтрока(мНастройки[ПреобразоватьИмяНастройки("param_debug")]) Тогда
		Сообщить("Строка запуска: "+СтрокаЗапуска);
	КонецЕсли;

	ЗапуститьПриложение(СтрокаЗапуска, , Истина, КодВозврата);

	Возврат КодВозврата;

КонецФункции

Процедура Инициализировать(ОсновнойСкрипт) Экспорт
	Перем ТекущаяСтрока, ТекущийПуть;
	iCaller = ОсновнойСкрипт;
	мНастройки = ОсновнойСкрипт.Настройки();
	тзАтрибуты = Новый ТаблицаЗначений;
	тзАтрибуты.Колонки.Добавить("Атрибут");
	тзАтрибуты.Колонки.Добавить("Значение");
	// в настройках "name" это имя настройки "value" - её значение
	//////////////////////////////////////////////
	Уровень = 0;

	Файл = Новый ЧтениеXML();
	Файл.ОткрытьФайл(ОсновнойСкрипт.БазовыйКаталог+"\config.xml");
	Пока Файл.Прочитать() Цикл
		Если Файл.ТипУзла = ТипУзлаXML.НачалоЭлемента Тогда
			Уровень = Уровень + 1;
			тАтрибутыУзла = Неопределено;
			мИмя = Неопределено;
			мЗнч = Неопределено;
			Если Файл.КоличествоАтрибутов() > 0 Тогда
				тАтрибутыУзла = тзАтрибуты.Скопировать();
				Для нн = 0 По Файл.КоличествоАтрибутов() - 1 Цикл
					Если Файл.ИмяАтрибута(нн) = "name" Тогда
						мИмя = Файл.ЗначениеАтрибута(нн);
					ИначеЕсли Файл.ИмяАтрибута(нн) = "value" Тогда
						мЗнч = Файл.ЗначениеАтрибута(нн);
					Иначе
						стр = тАтрибутыУзла.Добавить();
						стр.Атрибут = Файл.ИмяАтрибута(нн);
						стр.Значение = Файл.ЗначениеАтрибута(нн);
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;
			мПуть = ПреобразоватьИмяНастройки(Файл.Имя+"_"+мИмя);

			мНастройки.Вставить(мПуть, мЗнч);
		ИначеЕсли Файл.ТипУзла = ТипУзлаXML.КонецЭлемента Тогда
			Уровень = Уровень - 1;
		ИначеЕсли Файл.ТипУзла = ТипУзлаXML.Текст Тогда
			Сообщить(""+Файл.Значение);
		КонецЕсли;
	КонецЦикла;

	//////////////////////////////////////////////
	ОсновнойСкрипт.мНастройки = мНастройки;

	//Сообщить(мНастройки.Количество());
КонецПроцедуры

Функция ПреобразоватьИмяНастройки(Знач Параметр) Экспорт
	Перем Взвр;
	Если Найти(Параметр, "-")+Найти(Параметр, ".") > 0 Тогда
		Взвр = СтрЗаменить(Параметр, ".", "ё");
		Взвр = СтрЗаменить(Взвр, "-", "ъ");
		Взвр = СтрЗаменить(Взвр, "_", "Ж");
	ИначеЕсли Найти(Параметр, "ё")+Найти(Параметр, "ъ") > 0 Тогда
		Взвр = СтрЗаменить(Параметр, "ё", ".");
		Взвр = СтрЗаменить(Взвр, "ъ", "-");
		Взвр = СтрЗаменить(Взвр, "Ж", "_");
	Иначе
		Взвр = Параметр;
	КонецЕсли;
	Возврат Взвр;
КонецФункции

Функция Энкоде13(Текст) Экспорт
	ТекБуква = 0;
	ВзврТекст = "";
	ДлинаТхт = СтрДлина(Текст);
	Для нн = 1 По ДлинаТхт Цикл
		Смвл = Сред(Текст, нн, 1);
		КС = КодСимвола(Смвл);
		ВзврТекст = ВзврТекст +  Символ(КС-13);
	КонецЦикла;
	Возврат ВзврТекст;
КонецФункции

Функция Декоде13(Текст) Экспорт
	ТекБуква = 0;
	ВзврТекст = "";
	ДлинаТхт = СтрДлина(Текст);
	Для нн = 1 По ДлинаТхт Цикл
		Смвл = Сред(Текст, нн, 1);
		КС = КодСимвола(Смвл);
		ВзврТекст = ВзврТекст + Символ(КС+13);
	КонецЦикла;
	Возврат ВзврТекст;
КонецФункции

Функция Настройки() Экспорт
	Возврат мНастройки;
КонецФункции

Функция ОтключитьСеансы(НомерБазы=0) Экспорт
	Перем Кластер;
	ФайлСкрипта = Новый Файл(ТекущийСценарий().Источник);
	БазовыйКаталог = ФайлСкрипта.Путь+"..";
	ПодключитьСценарий(БазовыйКаталог+"\scripts\cluster_manager.os", "МенеджерКластера");
	Кластер = Новый МенеджерКластера();
	Кластер.НомерИБ = НомерБазы;

	Кластер.Инициализировать(ЭтотОбъект);
	СеансыОтключены = Ложь;

	 Попытка
		Дескриптор = Кластер.ДескрипторУправленияСеансамиБазы();
	Исключение
		Сообщить("@: "+ОписаниеОшибки());
		Возврат СеансыОтключены;
	КонецПопытки;
	Попытка
		Кластер.ЗаблокироватьСоединенияСБазой(Дескриптор);
		ИнтервалОтключения = 15;
		МаксимальноеЧислоПопыток = 2;
		ЧислоПопыток = 0;
		Пока ЧислоПопыток < МаксимальноеЧислоПопыток Цикл
			Если Кластер.ЕстьРаботающиеСеансы(Дескриптор, Истина) Тогда
				ЧислоПопыток = ЧислоПопыток + 1;
				Сообщить("Есть работающие сеансы. Ждем " + ИнтервалОтключения + " секунд. Попытка №" + Строка(ЧислоПопыток));
				Приостановить(ИнтервалОтключения*1000);
			Иначе
				Прервать;
			КонецЕсли;
		КонецЦикла;
		Если Кластер.ЕстьРаботающиеСеансы(Дескриптор, Истина, Ложь) Тогда
			Кластер.ПрекратитьСуществующиеСеансы(Дескриптор);
		КонецЕсли;

		Если Кластер.ЕстьРаботающиеСеансы(Дескриптор, Истина, Ложь) Тогда
			ВызватьИсключение "Критичный сбой: Сеансы все равно не отключены!";
		КонецЕсли;

		СеансыОтключены = Истина;
	Исключение
	КонецПопытки;

	Кластер.ЗакрытьДескриптор(Дескриптор);
	Если СеансыОтключены Тогда
		//СообщениеСборки("Соединения с базой " + Кластер.Опция("ИмяБазы") + " успешно отключены");
		Сообщить("Соединения с базой " + Кластер.Опция("ИмяБазы") + " успешно отключены");
	КонецЕсли;

	Возврат СеансыОтключены;
КонецФункции

