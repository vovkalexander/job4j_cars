[![Build Status](https://travis-ci.com/vovkalexander/job4j_cars.svg?branch=master)](https://travis-ci.com/vovkalexander/job4j_cars)
[![codecov](https://codecov.io/gh/vovkalexander/job4j_cars/branch/master/graph/badge.svg)](https://codecov.io/gh/vovkalexander/job4j_cars)


# job4j_cars

<p> Данное веб-приложение представляет площадку продаж машин, отображаемое  в одной странице index.html.
<p>

При загрузке Url сайта, появляется следующие:
![Image of Yaktocat](images/list.jpg)
* Вверху форма:

  ![Image of Yaktocat](images/add.jpg)
1) Добавить объявление, выполняется при авторизации заявителя,
   переход на сраницу для заполнения данных автомобиля.
   ![Image of Yaktocat](images/condition.jpg)
2) Изменить статус, выполняется при авторизации заявителя. Переход на другую
   страницу, появляется список всех авто заявителя и он может изменять статус продажи.
   ![Image of Yaktocat](images/authorisation.jpg)
3) Вход - авторизация заявителя.
4) Выход заявителя.

* Список всех автомобилей с данными.

<em> Tехнологии:</em>
<ol>
<li> Hibernate</li>
<li> Ajax(загружаться все данные), JavaScript, JSON, JQuery</li>
<li> Servlet, JSP, PostgresSql - подключение к БД  </li>
<li> Commons-fileupload -функционал добавления и скачивания файлов </li>
</ol>



