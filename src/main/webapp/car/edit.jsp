<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>

<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3 Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2 poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft 2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>jopa</title>
</head>
<body onload="showAdvertList()">
<div class="container">
    <ul class="nav">
        <li class="nav-advert">
            <a class="nav-link" href="http://localhost:8080/cars/index.jsp">Главная страница</a>
        </li>

    </ul>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>

<script>
    function putTick(carId) {
        let tick;
        if ($('#yes').is(':checked')) {
            tick = $('#yes').val();
        } else if ($('#no').is(':checked')) {
            tick = $('#no').val();
        }
        $.ajax({
            type: 'POST',
            crossdomain: true,
            url: 'http://localhost:8080//cars/update.do',
            data: {'rst': tick,'id' : carId },
            success: function (data) {
                 alert(data);

            },
            error: function (xhr, str) {
                alert('Возникла ошибка: ' + xhr.responseCode);
            }

        });

    }

</script>
<script >
    function showAdvertList() {
        $.ajax({
            type: 'GET',
            crossdomain: true,
            url: 'http://localhost:8080//cars/adList.do',
            dataType: 'json'
        }).done(function (data) {
            var dataCar = JSON.stringify(data);
            var listCar = JSON.parse(dataCar);
            for (var i = 0; i < listCar.length; i++) {
                var id = listCar[i].id;
                $('#table > tbody ').append('<tr>');
                $('#table > tbody ').append('<td><img src = "http://localhost:8080/cars/download?photoCar='+listCar[i].photo+'" height="150px" width = "200px"/>' +'</td>');
                $('#table > tbody ').append('<td>' + listCar[i].carModel + '</td>');
                $('#table > tbody ').append('<td>' + listCar[i].body.type + '</td>');
                $('#table > tbody ').append('<td>' + listCar[i].color.name + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].created + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].description + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].advert.name + '</td>');
                $('#table > tbody ').append('<td>' +listCar[i].advert.phone + '</td>');
                $('#table > tbody ').append('<td><input type="radio"  id="yes" name = "radio" value="Yes"  onclick = "return putTick('+id+')">Продано'+
                    '<input type="radio"  id="no" name = "radio" value="No"  onclick = "return putTick('+id+')">Нет</td>');
                $('#table > tbody ').append('/<tr>');
            }

        }).fail(function (err) {
            alert(err);
        });

    }
</script>



<table id = "table" style="border: 1px solid #000000" border="1" cellpadding="1" cellspacing="0" width="420"  >
    <thead >
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
<form action= "http://localhost:8080//cars/date.do" method="post" enctype="multipart/form-data" >

</form>
</body>
</html>