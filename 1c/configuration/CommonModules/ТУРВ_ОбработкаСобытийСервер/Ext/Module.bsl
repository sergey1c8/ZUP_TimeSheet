﻿#Область ПрограммныйИнтерфейс

Процедура ЗарегистрироватьЗаписьСсылочногоОбъекта(Объект, ЭтоНовый = Ложь) Экспорт
	
	Если Не (Справочники.ТипВсеСсылки().СодержитТип(ТипЗнч(Объект)) Или Документы.ТипВсеСсылки().СодержитТип(ТипЗнч(Объект)))
			И Объект.ДополнительныеСвойства.Свойство("НеРегистрироватьВОбмене") Тогда
		Возврат;
	КонецЕсли;	

	УстановитьПривилегированныйРежим(Истина);
	
	Если Не ЗначениеЗаполнено(ТУРВ_РаботаСФункциямиКлиентСервер.Результат(ТУРВ_ОбменДаннымиПовтИсп.НастройкиСервиса()).АдресСервера) Тогда
		Возврат;
	КонецЕсли; 
	
	Если ЭтоНовый = Неопределено И Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		ЭтоНовый = Истина;
		УстановитьПривилегированныйРежим(Ложь);
		Возврат
		
	ИначеЕсли ЭтоНовый = Истина Тогда	
		РегистрыСведений.ТУРВ_ОчередьОбменаСсылочнымиДанными.ЗарегистрироватьДобавлениеОбъекта(Объект.Ссылка);	
	Иначе
		РегистрыСведений.ТУРВ_ОчередьОбменаСсылочнымиДанными.ЗарегистрироватьИзменениеОбъекта(Объект.Ссылка);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

Процедура ЗарегистрироватьЗаписьРегистраСведений(НаборЗаписей) Экспорт  
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Не ЗначениеЗаполнено(ТУРВ_РаботаСФункциямиКлиентСервер.Результат(ТУРВ_ОбменДаннымиПовтИсп.НастройкиСервиса()).АдресСервера) Тогда
		Возврат;
	КонецЕсли; 
	
	МассивПользователейЛК = ТУРВ_ОбменДаннымиПовтИсп.МассивПользователейЛК();
	ТипОбъекта	= ТУРВ_ОбменДаннымиПовтИсп.ТипыОбъектов().РСНЗ;
	ИмяОбъекта = НаборЗаписей.Метаданные().Имя;
	
	Если ИмяОбъекта = "КадроваяИсторияСотрудников" Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
						|	КадроваяИсторияСотрудников.Сотрудник КАК Сотрудник,
						|	КадроваяИсторияСотрудников.ФизическоеЛицо КАК ФизическоеЛицо
						|ИЗ
						|	РегистрСведений.ТУРБ_ПользователиЛК КАК ТУРБ_ПользователиЛК
						|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.КадроваяИсторияСотрудников КАК КадроваяИсторияСотрудников
						|		ПО (КадроваяИсторияСотрудников.ФизическоеЛицо = ТУРБ_ПользователиЛК.ФизическоеЛицо)
						|ГДЕ
						|	КадроваяИсторияСотрудников.Регистратор = &Регистратор";
		
		Запрос.УстановитьПараметр("Регистратор", НаборЗаписей.Отбор.Регистратор.Значение);
		
		Попытка
			ТЗ = Запрос.Выполнить().Выгрузить();	
		Исключение
			
			Объект = СтрШаблон(	"{name: ""%1""}", ИмяОбъекта);
								
			ТУРВ_ЛогированиеСервер.ДобавитьЗаписьВЛог(	ТУРВ_ОбменДаннымиПовтИсп.УровниЛога().Ошибка,
												ТУРВ_ОбменДаннымиПовтИсп.СобытияЛога().РегистрацияЗаданияОчередиОбмена, 
												ТУРВ_ОбменДаннымиПовтИсп.УровниСобытийЛога().Ошибка,				
												ТУРВ_ЛогированиеСервер.ДанныеJSONОбъектСтрока(ТУРВ_ОбменДаннымиПовтИсп.УровниЛога().Ошибка,
																					ТУРВ_ЛогированиеСервер.ТекущаяДатаЛК(),
																					,
																					ТипОбъекта, 
																					ИмяОбъекта, 
																					"РегистрыСведений.ЗарегистрироватьЗаписьРегистраСведений.ВыгрузкаДанныхЗапроса",
																					ОписаниеОшибки()));			
			УстановитьПривилегированныйРежим(Ложь);
			Возврат;
			
		КонецПопытки;
				
		Для Каждого Запись Из НаборЗаписей Цикл
			
			Если МассивПользователейЛК.Найти(Запись.ФизическоеЛицо) = Неопределено  Тогда
				Продолжить;
			КонецЕсли;	
			
			НоваяСтрокаТЗ = ТЗ.Добавить();
			НоваяСтрокаТЗ.Сотрудник      = Запись.Сотрудник;
			НоваяСтрокаТЗ.ФизическоеЛицо = Запись.ФизическоеЛицо;
			
		КонецЦикла;
		
		ТЗ.Свернуть("Сотрудник, ФизическоеЛицо");
		
		Для Каждого СтрокаТЗ Из Тз  Цикл	
			
			Структура = Новый Структура;
			Структура.Вставить("Сотрудник",      СтрокаТЗ.Сотрудник);
			Структура.Вставить("ФизическоеЛицо", СтрокаТЗ.ФизическоеЛицо);

			ДанныеJSON = ТУРВ_РаботаСJSONСервер.ЗаписьJSON(Структура);	
			
			ХешированиеДанных  = Новый ХешированиеДанных (ХешФункция.CRC32);
			ХешированиеДанных.Добавить(ДанныеJSON);
			ХешСумма = ХешированиеДанных.ХешСумма;
			
			РегистрыСведений.ТУРВ_ОчередьОбменаПроизвольнымиДанными.ЗарегистрироватьДобавлениеОбъекта(ТипОбъекта, ИмяОбъекта, ХешСумма, ДанныеJSON);
			
		КонецЦикла;
		
	КонецЕсли;
		
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры	

Процедура ЗарегистрироватьЗаписьРегистраНакоплений(НаборЗаписей) Экспорт  
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Не ЗначениеЗаполнено(ТУРВ_РаботаСФункциямиКлиентСервер.Результат(ТУРВ_ОбменДаннымиПовтИсп.НастройкиСервиса()).АдресСервера) Тогда
		Возврат;
	КонецЕсли; 
	
	МассивПользователейЛК = ТУРВ_ОбменДаннымиПовтИсп.МассивПользователейЛК();
	
	ИмяМетаданных = НаборЗаписей.Метаданные().Имя;
	ТипОбъекта = ТУРВ_ОбменДаннымиПовтИсп.ТипыОбъектов().РННЗ;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры	

#КонецОбласти