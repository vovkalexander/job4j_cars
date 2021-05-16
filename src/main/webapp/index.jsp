<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>

<html>
<head>
    <!-- Required meta tags -->
    <meta  charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>CarMarket</title>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <style>
        body {
            font-size: 17px;
        }
        #selectFilter {
            margin-left: 4%;

        }

        table th,td {text-align: center;}
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
            dataType: 'json',
            contentType: "charset = utf-8"
        }).done(function (data) {
            var dataCar = JSON.stringify(data);
            var listCar = JSON.parse(dataCar);
            for (var i = 0; i < listCar.length; i++) {
                $('#table > tbody ').append('<tr>');
                $('#table > tbody ').append('<td><img src = "http://localhost:8080/cars/download?photoCar='+listCar[i].photo+'" class="rounded"  height="150px" width = "200px"/>' +'</td>');
                $('#table > tbody ').append('<td>' + listCar[i].carModel + '</td>');
                $('#table > tbody ').append('<td>' + listCar[i].body.type + '</td>');
                $('#table > tbody ').append('<td>' + listCar[i].color.name + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].created + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].description + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].advert.name + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].advert.phone + '</td>');
                if (listCar[i].sold === true) {
                    let text = " продано";
                    $('#table > tbody ').append('<td><i class="fas fa-handshake fa-lg" ><span class="badge badge-pill badge-success">'+ text +'</span>' + '</td>');
                } else {
                    let text = " не продано";
                    $('#table > tbody ').append('<td><i class="fas fa-car-alt fa-lg" ><span class="badge badge-pill badge-info">' + text +'</span>' + '</td>');
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
            contentType: "application/json; charset = utf-8",
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
        <ul class="nav" >
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/cars/addAdvert.jsp">Добавить объявление</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/cars/car/edit.jsp">Изменить состояние</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/cars/login.jsp">Войти</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/exit.do"> <c:out value="${advert.name}"/> | Выйти</a>
            </li>
        </ul>
    </div>
</div>
<div class="container">
    <form   method="POST">
        <div class="input-group mb-3">
            <input type = text id = "model" name = "model" placeholder = "Поиск по модели">
            <div class="input-group-append">
                <button type="submit"  id="search" class="btn btn-info" onclick=" return showModel()"><i class="fa fa-search"> </i></button>
            </div>
            <select name="filters" id = "selectFilter" >
                <option value="" selected ></option>
                <option value="current"> Объявления за последний день </option>
                <option value="withPhoto">Объявления с фото </option>
            </select>
            <div class="input-group-append">
                <button type="submit" id = "button2" class="btn btn-info" onclick=" return showFilter()"><i class="fa fa-filter "></i></button>
            </div>
        </div>
    </form>

</div>

<div class="container">
    <table class="table table-striped" id = "table" >
        <thead>
        <tr >
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
</div>
</body>
</html>