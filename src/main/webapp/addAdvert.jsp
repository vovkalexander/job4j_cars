<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
    <title>CarSale</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
    #colortype {
        margin-top: 1%;
    }
    #model {
        margin-top: 1%;
    }

    #desc {
        margin-top: 1%;
    }
    #butt {
        margin-top: 1%;
    }

</style>

</head>
<body onload="chooseColor(); chooseBody()">
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>

<script>
    function chooseColor() {
        var $select = $('#color');
        $.ajax({
            type: 'GET',
            crossdomain: true,
            url: 'http://localhost:8080//cars/colors.do',
            dataType: 'json'
        }).done(function (data) {
            var dataCity = JSON.stringify(data);
            var listColors = JSON.parse(dataCity );
            $select.html('');
            $select.append('<option value="" selected ></option>')
            for (var i = 0; i < listColors.length; i++) {
                $select.append('<option value ="' + listColors[i].id + '">'
                    + listColors[i].name + '</option>')
            }
        }).fail(function (err) {
            alert(err);
        });
    }

</script>

<script>
    function chooseBody() {
        var $select = $('#body');
        $.ajax({
            type: 'GET',
            crossdomain: true,
            url: 'http://localhost:8080//cars/bodies.do',
            dataType: 'json'
        }).done(function (data) {
            var dataCity = JSON.stringify(data);
            var listBodies = JSON.parse(dataCity );
            $select.html('');
            $select.append('<option value="" selected ></option>')
            for (var i = 0; i < listBodies.length; i++) {
                $select.append('<option value ="' + listBodies[i].id + '">'
                    + listBodies[i].type + '</option>')
            }
        }).fail(function (err) {
            alert(err);
        });
    }

</script>


<div class = "container">
    <form action="<%=request.getContextPath()%>/add.do" method="post" enctype="multipart/form-data">
        <div id = model>
        <input type = "text" name = "carModel" placeholder="Марка" required >
        </div>
        <div id = "colortype">
            <label for="color">Цвет:</label>
            <select id="color" name = "colorCar" required >
                <option value=""></option>
            </select>
        </div>
        <div class = "bodytype">
            <label for="body">Тип кузова:</label>
            <select id="body" name = "bodyCar"  required>
                <option value=""></option>
            </select>
        </div>
        <div class = "dateCreate">
            <label for="body">Дата производства:</label>
            <input type="date"  id ="date" name = "dateCar" required>
        </div>
        <div class = "photocar">
            <input type="file"   id="photo" name="photoCar" >

        </div>
        <div class = "desc" id="desc">
            <input type="text" class="form-control" id="descCar" name="description"   placeholder="Описание авто" required>
        </div>
        <div id="butt">
        <button type="submit" class="btn btn-primary" >Добавить</button>
        </div>
    </form>
</div>
</body>
</html>
