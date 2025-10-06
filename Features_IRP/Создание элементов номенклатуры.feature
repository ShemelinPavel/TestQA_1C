#language: ru

@tree

Функционал: Создание элементов номенклатуры

Как Тестировщик я хочу
Создать 10 элементов спр. Номенклатура с разными наименованиями

Переменные:

КоличествоЭлементовСправочника = 10

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Создание элементов номенклатуры
	* Подготовительный этап
		//если база пустая - создадим тип номенклатуры и единицу измерения
		И я проверяю или создаю для справочника "ItemTypes" объекты:
			| 'Ref'                                                               | 'DeletionMark' | 'Parent' | 'IsFolder' | 'Code' | 'Type'                   | 'UseSerialLotNumber' | 'Description_en'            | 'Description_hash' | 'Description_ru' | 'Description_tr' | 'UniqueID'                          |
			| 'e1cib/data/Catalog.ItemTypes?ref=b762b13668d0905011eb76684b9f6879' | 'False'        | ''       | 'False'    | 2      | 'Enum.ItemTypes.Product' | 'False'              | 'Товар (без характеристик)' | ''                 | ''               | ''               | '_32c63d8e5ee94926b3c772ab02c5243e' |

		И я проверяю или создаю для справочника "Units" объекты:
			| 'Ref'                                                           | 'DeletionMark' | 'Code' | 'Item' | 'Quantity' | 'BasisUnit' | 'UOM' | 'Description_en' | 'Description_hash' | 'Description_ru' | 'Description_tr' | 'Height' | 'Length' | 'Volume' | 'Weight' | 'Width' |
			| 'e1cib/data/Catalog.Units?ref=b762b13668d0905011eb76684b9f687b' | 'False'        | 1      | ''     | 1          | ''          | ''    | 'шт'             | ''                 | ''               | ''               |          |          |          |          |         |

	* Генерация номенклатуры
		И Я запоминаю значение выражения '0' в переменную "Счетчик"
		И я делаю "$КоличествоЭлементовСправочника$" раз
			И Я запоминаю значение выражения '$Счетчик$ + 1' в переменную "Счетчик"
			И Я запоминаю значение выражения '"Товар № " + $Счетчик$' в переменную "НаименованиеТовара"
			И я проверяю или создаю для справочника "Items" объекты:
				| 'Ref'                                                                                                   | 'DeletionMark' | 'ItemType'                                                          | 'Unit'                                                          | 'Description_en'       | 'Description_ru'       |
				| '{СтрШаблон("e1cib/data/Catalog.Items?ref=%1", СтрЗаменить(Новый УникальныйИдентификатор(), "-", ""))}' | 'False'        | 'e1cib/data/Catalog.ItemTypes?ref=b762b13668d0905011eb76684b9f6879' | 'e1cib/data/Catalog.Units?ref=b762b13668d0905011eb76684b9f687b' | '$НаименованиеТовара$' | '$НаименованиеТовара$' |