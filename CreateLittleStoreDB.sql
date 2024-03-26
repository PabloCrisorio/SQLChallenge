create database littleStore;
use littleStore;
create table vendedores (nombre varchar(25), apellido varchar(34), id integer identity primary key);

insert into vendedores (nombre, apellido) values ('pablo','criosrio'),('jose','alzueta');
create table productos (id integer identity primary key, nombre varchar(15), precio real);
insert into productos (nombre, precio) values ('camisa', 145),('pantalon',240);

create table ventas (id integer identity primary key, id_vendedor integer foreign key (id_vendedor) references vendedores(id), 
id_producto integer foreign key (id_producto) references productos(id));

insert into ventas (id_vendedor, id_producto) values (2,1),(1,2);

create view resumen_ventas
as 
select v.id as 'num_venta', ve.nombre , ve.apellido, p.nombre as 'producto', p.precio from
(vendedores ve INNER JOIN ventas v ON ve.id = v.id_vendedor)
INNER JOIN productos p ON p.id = v.id_vendedor;


