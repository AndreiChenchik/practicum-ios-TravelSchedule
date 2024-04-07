# Техническое задание для мобильного приложения «Расписание Путешествий»

## 1. Введение

Техническое задание описывает требования и детали реализации мобильного приложения «Расписание Путешествий». Готовое приложение предоставляет расписание транспорта и информацию о маршрутах с использованием API Яндекс.Расписания.

## 2. Цели и задачи

Цель проекта — создать мобильное приложения для iOS, которое позволит пользователям искать и просматривать расписание движения транспортных средств в различных городах, а также получать информацию о перевозчиках.

**Основные задачи:**

- Разработать пользовательский интерфейс с четырьмя основными и четырьмя второстепенными экранами.
- Интегрировать в приложение API Яндекс.Расписания, чтобы получать данные о расписании.
- Реализовать систему сторис с новостным контентом.

## 3. Функциональные требования

### 3.1. Экраны приложения

- **Стартовый экран:**
  
  - Панель со сторис сверху экрана.
  - Поисковые строки для выбора городов по направлениям «откуда» и «куда».
  - **Алгоритмы и действия:**
    - Пользователь нажимает на строку с плэйсходрером «откуда» и переходит на экран поиска отправной точки.
    - Пользователь нажимает на строку с плэйсходрером «куда» и переходит на экран поиска города прибытия.
    - Пользователь тапает по иконке сторис для открытия полноэкранного просмотра.
    - Кнопка «найти» не отображается/скрыта до тех пор пока не заполнены обе строки «откуда» и «куда».
    - Если обе строки заполнены, то кнопка «найти» отображается. Нажав на неё, пользователь переходит на экран расписания/выбора рейса.

- **Экран «Выбор города»:**

  - Поисковая строка в верхней части экрана для ввода названия города.
  - Список городов под поисковой строкой, где пользователь может выбрать населённый пункт из предложенного списка.
  - **Алгоритмы и действия:**
    - Пользователь вводит название города в поисковую строку.
    - По мере ввода происходит автоматический поиск/фильтрация и отображение подходящих городов в реальном времени.
    - Пользователь выбирает город из предложенного списка, что приводит к переходу на следующий экран.

- **Экран станций:**
  
  - Список всех станций выбранного города.
  - Возможность выбора станции.
  - **Алгоритмы и действия:**
    - Пользователь вводит название станции в поисковую строку или просматривает список всех доступных станций.
    - Поиск станции также работает в режиме реального времени.
    - После выбора станции пользователь возвращается к экрану выбора городов по направлениям «откуда» и «куда», на котором уже отображается кнопка «найти».

- **Экран расписания:**
  
  - Отображение расписания по выбранным станциям.
  - Кнопка перехода на экран с фильтрами для настрокий сортировки по пересадкам и времени отправления.
  - **Алгоритмы и действия:**
    - На этом экране пользователь может просматривать все доступные рейсы из выбранной станции.
    - Пользователь выбирает рейс, чтобы увидеть подробную информацию о нем и о перевозчике.

- **Экран уточнения параметров маршрута:**
  
  - Отображение и выбор фильтров по времени отправления.
  - Включение/отключение показа маршрутов с пересадками.
  - **Алгоритмы и действия:**
    - Возможность уточнения поиска по времени отправления и наличию пересадок.

- **Экран информации о перевозчике:**
  
  - Информация о перевозчике, включая контактные данные.
  - **Алгоритмы и действия:**
    - На экране отображается подробная информация о выбранном перевозчике, включая логотип, название компании, веб-сайт и номер телефона.
    - Пользователь может перейти на сайт перевозчика или позвонить по номеру, используя соответствующие ссылки или кнопки.

- **Экран настроек:**
  
  - Переключение между светлой и тёмной темой интерфейса.
  - Переход на просмотр пользовательского соглашения.
  - Информация об использовании API Яндекс Расписания.
  - Информация о версии приложения.
  - **Алгоритмы и действия:**
    - Пользователь может изменить тему приложения с темной на светлую и обратно.
    - Возможность просмотра пользовательского соглашения.
    - Возможность просмотра версии приложения.
    - Информация о том, что приложение использует API Яндекс.Расписаний.

- **Экран «Сторис» (Stories Screen):**

  - Сторис содержит визуальные и текстовые истории, связанные с путешествиями, новостями или обновлениями.
  - В каждой сторис присутствуют изображения и связанный с ними текст.
  - В верхней части экрана присутствуют индикаторы: количество сториз и время до автоматического закрытия/перехода к следующей.
  - **Алгоритмы и доступные действия**:
    - В полноэкранном режиме пользователь может листать сторис вправо или влево, тапая по соответствующим сторонам экрана или свайпая по экрану в соотвествующем направлении.
    - Временные индикаторы на верхней части экрана показывают прогресс просмотра текущей сторис, показывая время до переключения на следующую сторис.
    - Время просмотра одной сторис 10 секунд.
    - Пользователь может закрыть сторис и вернуться на стартовый экран, тапнув по крестику в правом верхнем углу экрана или свайпнув сторис сниз.
    - Сторис автоматически переключаются после завершения времени просмотра, позволяя пользователю увидеть следующую сторис без вмешательства.
    - После просмотра последней сторис, экран автоматически закрывается.

### 3.2. Навигация

- Навигация между экранами типа master-detail.
- Таббар для перехода к начальному экрану и экрану настроек.
- Для показа сторис окно отображается модально.

## 4. Нефункциональные требования

### 4.1. Технические требования

- Архитектура: MVVM
- Поддержка iOS версии 15.0 и выше.
- Язык программирования: Swift 5.x.
- Использование SwiftUI при имплементации интерфейса.
- Адаптивный дизайн для поддержки различных размеров экранов.
- Реактивное программирование с использованием Combine.
- Асинхронное программирование с использованием async/await.
- Кодогенерация сетевого слоя.
- Соответствие SOLID. Примение паттернов.

### 4.2. Дополнительные требования

- Для обеспечения полной функциональности приложения, нужно реализовать сетевой слой, используя кодогенерацию для всех необходимых запросов.
- Все запросы к API должны выполняться асинхронно с использованием структурированной многопоточности async/await. Ошибки должны корректно обрабатываться и отображаться пользователю в удобной форме.
- Должна быть предусмотрена обработка состояний загрузки, ошибок и пустых состояний.
- Интерфейс должен быть адаптирован для использования в темной и светлой теме.
- Должено быть реализовано сохранение выбранных пользователем настроек.
- Тексты и медиа для сторис должны загружаться из локальных источников.
- Необходимо внедрить систему аналитики для отслеживания поведения пользователя и улучшения приложения на основе этих данных.
- Приложение должно поддерживать адаптивный дизайн для различных размеров экранов и ориентаций.
- Все текстовые данные должны быть локализованы и поддерживать как минимум русский и английский языки.
- Документация кода и комментарии должны быть написаны на английском языке для универсальности и доступности.

### 4.5. Требования к дизайну

- Соответствие дизайну Human Interface Guidelines от Apple.
- Интуитивно понятные элементы управления и взаимодействие с ними.

### 4.5. Тестирование

- Необходимо разработать комплексный план тестирования, включающий unit-тесты, UI-тесты.
- Приложение должно пройти тестирование на реальных устройствах с различными версиями iOS.

## 5. Этапы и сроки реализации

### 5.1 Дизайн

- Проектирование и разработка пользовательского интерфейса: 6 недель.

## 5.2 API Яндекс Расписания

- Интеграция API Яндекс Расписания: 2 недели.
- [x] Дополните документ `openapi.yaml` данными о всех сервисах API «Яндекс Расписаний». Описание API сервисов находится на сайте сервиса [в разделе «Запросы к API»](https://yandex.ru/dev/rasp/doc/ru/).
- [x] Убедитесь, что документ сформирован корректно с помощью [редактора YAML](https://editor.swagger.io/). Редактор не должен выдавать ошибок после того, как вы закончите работу над документом.
- [x] Запустите сборку проекта Xcode с документом `openapi.yaml`, содержащим определения всех сервисов.
- [x] Добавьте вызовы каждого сервиса в проект Xcode хотя бы с минимальным набором входных параметров. Это нужно, чтобы убедиться, что он работает.

### 5.3 Сторис

- [x] tabbar, показывающий два основных экрана: поиск и настройки;
- [x] навигация типа master-detail между всеми экранами в дизайне;
- [x] сториз, которые открываются модально. 

Self-check:

- [x] Создан tabbar для переключения между главным экраном поиска поездок и экраном настроек.
- [x] В момент начала поиска организован полноэкранный показ выбора города с помощью `.fullScreenCover()`.
- [x] После выбора города реализован переход на экран выбора станции.
- [x] После выбора станции реализован возврат назад на главный экран.
- [x] При навигации на экраны выбора города и станции tabbar не отображается.
- [x] По нажатии на кнопку «Найти» происходит переход на экран выбора поездки.
- [x] По нажатию на «Уточнить время» происходит переход на экран выбора временных интервалов.
- [x] С экрана «Уточнить время» можно вернуться назад с помощью стрелки или по кнопке «Применить».
- [x] При выборе поездки открывается экран с детальной информацией о перевозчике с возможностью возврата назад.
- [x] При нажатии на сторис на главном экране они открываются в модальном окне.
- [x] Везде есть возможность вернуться на предыдущий экран.
