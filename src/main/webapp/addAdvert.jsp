<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3 Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft 2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <title>CarSale</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
        <input type = "text" name = "carModel" placeholder="Марка" required>
        <div class = "form-group">
            <label for="color">Цвет:</label>
            <select id="color" name = "colorCar" required>
                <option value=""></option>
            </select>
        </div>
        <div class = "bodytype">
            <label for="body">Тип кузова:</label>
            <select id="body" name = "bodyCar" required>
                <option value=""></option>
            </select>
        </div>
        <div class = "dateCreate">
            <label for="body">Дата производства:</label>
            <input type="date"  id ="date" name = "dateCar" required>
        </div>
        <div class = "photocar">
            <input type="file"  id="photo" name="photoCar" required>
        </div>
        <div class = "desc">
            <input type="text" class="form-control" id="descCar" name="description"   placeholder="Описание авто" required>
        </div>
        <button type="submit" class="btn btn-primary" >Добавить</button>
    </form>
</div>
</body>
</html>
