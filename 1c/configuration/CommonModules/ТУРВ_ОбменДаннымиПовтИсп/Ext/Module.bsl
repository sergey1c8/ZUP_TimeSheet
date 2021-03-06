﻿#Область ПрограммныйИнтерфейс

Функция МассивПользователейЛК() Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ТУРБ_ПользователиЛК.ФизическоеЛицо КАК ФизическоеЛицо
	               |ИЗ
	               |	РегистрСведений.ТУРБ_ПользователиЛК КАК ТУРБ_ПользователиЛК";
	
	МассивПользователей = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ФизическоеЛицо");
	
	Возврат МассивПользователей;
	
КонецФункции	

Функция УровниСобытийЛога() Экспорт
	
	Возврат ТУРВ_ЛогированиеСервер.УровниСобытийЛога();	

КонецФункции 

Функция СобытияЛога() Экспорт
	
	Возврат ТУРВ_ЛогированиеСервер.СобытияЛогаЛК();	

КонецФункции 

Функция УровниЛога() Экспорт
	
	Возврат ТУРВ_ЛогированиеСервер.УровниЛога();
	
КонецФункции

Функция ТипыОбъектов() Экспорт
	
	Возврат ТУРВ_ЛогированиеСервер.ТипыОбъектов();
	
КонецФункции

Функция ВидыОбъектов() Экспорт
	
	Возврат ТУРВ_ЛогированиеСервер.ВидыОбъектов();
	
КонецФункции

Функция МетодыЗапроса() Экспорт
	
	Структура = Новый Структура;
	Структура.Вставить("ГЕТ",  "GET");
	Структура.Вставить("ПОСТ", "POST");
	Структура.Вставить("ДЕЛ",  "DELETE");
	Структура.Вставить("ПУТ",  "PUT");
	Структура.Вставить("ПАТЧ", "PATCH");
	
	Возврат Структура;
	
КонецФункции

Функция НастройкиСервиса() Экспорт 
	
	Возврат РегистрыСведений.ТУРВ_НастройкиСервиса.НастройкиСервиса();
	
КонецФункции


#КонецОбласти