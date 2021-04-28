<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>

<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>ShowList</title>
    <!-- Bootstrap CSS -->
    <link crossorigin="anonymous"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" rel="stylesheet">
    <script src="https://cdn.deliver.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft 2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body onload="showList()">
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>
<script >
    function showList() {
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