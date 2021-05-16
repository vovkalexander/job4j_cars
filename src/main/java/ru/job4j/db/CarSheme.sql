create table Car (
id serial primary key,
car_model varchar(2000),
body_id int not null references body(id),
color_id int not null references color(id),
sold boolean,
created date,
photo text,
description text
advert_id int not null references Advertiser(id)
);

create table Advertiser(
id serial primary key,
name varchar(2000),
phone varchar(20),
email varchar(200),
password varchar(200)
);


Create table color (
id serial primary key,
name varchar(2000)
);

insert into color
(name)
values
('yellow'),
('red'),
('blue'),
('black'),
('white'),
('pink'),
('orange'),
('brown'),
('green'),
('gray'),
('silver');


Create table body
id serial primary key,
name varchar(2000)
);


insert into body
(type)
values
('sedan'),
('cabriolet'),
('coupe'),
('pickup'),
('SUV'),
('hatchback'),
('station wagon'),
('van'),
('minivan'),
('sports car');