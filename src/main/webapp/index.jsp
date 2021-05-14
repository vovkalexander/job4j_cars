<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>

<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>ShowList</title>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <!-- Bootstrap CSS -->

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
    <title>CarList</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <style>
        i {
            font-family: FontAwesome;
        }
    </style>
</head>

<body onload="showList()" >
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>
<script >
    setTimeout  (function showList() {
        $.ajax({
            type: 'GET',
            crossdomain: true,
            url: 'http://localhost:8080//cars/add.do',
            dataType: 'json'
        }).done(function (data) {
            var dataCar = JSON.stringify(data);
            var listCar = JSON.parse(dataCar);
            for (var i = 0; i < listCar.length; i++) {
                $('#table > tbody ').append('<tr>');
                $('#table > tbody ').append('<td><img src = "http://localhost:8080/cars/download?photoCar='+listCar[i].photo+'" height="150px" width = "200px"/>' +'</td>');
                $('#table > tbody ').append('<td>' + listCar[i].carModel + '</td>');
                $('#table > tbody ').append('<td>' + listCar[i].body.type + '</td>');
                $('#table > tbody ').append('<td>' + listCar[i].color.name + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].created + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].description + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].advert.name + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].advert.phone + '</td>');
                if (listCar[i].sold === true) {
                    let text = " продано";
                    $('#table > tbody ').append('<td><i class="fa fa-handshake-o">' + text + '</td>');
                } else {
                    let text = " не продано";
                    $('#table > tbody ').append('<td><i class="fa fa-car">' + text + '</td>');
                }
                $('#table > tbody ').append('/<tr>');
            }

        }).fail(function (err) {
            alert(err);
        });

    }, 1500);
</script>

<script >
    function showModel() {
        var rst = {'mod': $('#model').val()};
        var modelJson = JSON.stringify(rst);
        $.ajax({
            type: 'POST',
            crossdomain: true,
            url: 'http://localhost:8080//cars/model.do',
            data: modelJson,
            datatype: "json",
            contentType: "application/json",
            success: function (data) {
                $(document).ready(function () {
                    showList();
                });
            },
            error: function (xhr, str) {
                alert('Возникла ошибка: ' + xhr.responseCode);
            }
        });

    }
</script>

<script >
    function showFilter() {
        var rst = {'filter': $('#selectFilter').val()};
        var filterJson = JSON.stringify(rst);
        $.ajax({
            type: 'POST',
            crossdomain: true,
            url: 'http://localhost:8080//cars/filter.do',
            data: filterJson,
            datatype: "json",
            contentType: "application/json",
            success: function (data) {
                $(document).ready(function () {
                    showList();
                });
            },
            error: function (xhr, str) {
                alert('Возникла ошибка: ' + xhr.responseCode);
            }
        });

    }
</script>

<div class="container">
    <div class="row">
        <ul class="nav">
            <li class="nav-advert">
                <a class="nav-link" href="http://localhost:8080/cars/addAdvert.jsp">Добавить объявление</a>
            </li>
            <li class="nav-advert">
                <a class="nav-link" href="http://localhost:8080/cars/car/edit.jsp">Изменить состояние</a>
            </li>
            <li class="nav-advert">
                <a class="nav-link" href="http://localhost:8080/cars/login.jsp">Войти</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/exit.do"> <c:out value="${advert.name}"/> | Выйти</a>
            </li>
        </ul>
    </div>
</div>
<div>
    <form   method="POST">
        <input type = text id = "model" name = "model">
        <button type="submit"  id="search" onclick=" return showModel()"><i class="fa fa-search">Поиск по модели</i></button>
        <select name="filters" id = "selectFilter">
            <option value="" selected ></option>
            <option value="current"> Объявления за последний день </option>
            <option value="withPhoto">Объявления с фото </option>
        </select>
        <button type="submit"  onclick=" return showFilter()"><i class="fa fa-filter fa-lg"></i></button>
    </form>

</div>


<table id = "table" style="border: 1px solid #000000" border="1" cellpadding="1" cellspacing="0" width="450"  >
    <thead>
    <tr>
        <th>Фото</th>
        <th>Модель</th>
        <th>Тип кузова</th>
        <th>Цвет</th>
        <th>Дата производства</th>
        <th>Описание</th>
        <th>Имя Владельца</th>
        <th>Контакты</th>
        <th>Состояние</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
</body>
</html>