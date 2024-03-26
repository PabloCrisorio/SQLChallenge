create database challenge

use challengeLeo
--crea tabla usuario
create table usuarios (
id integer identity primary key, 
nombre text not null, 
apellido text not null, 
telefono text not null);
--creat tabla productos
create table productos (
id integer identity primary key, 
nombre text not null, 
marca text not null, 
codigo text not null,
precio integer not null);
--crea tabla ventas
create table ventas (
id integer identity primary key, 
usuario_id integer foreign key (usuario_id) references usuarios(id), 
producto_id integer foreign key (producto_id) references productos(id))
--carga de datos
drop table productos
insert into usuarios (nombre, apellido, telefono)
values 
('pablo','crisorio','3815588060'),
 ('juan','sosa','3815512345'),
  ('pedro','pose','3815523456'),
   ('mario','nieva','3815534567');



insert into productos  (nombre, marca, codigo, precio)
values 
('jugo','tang','2425',100),
 ('sopa','maigc','1245',450),
  ('pan en rodajas','bimbo','1012',1600),
   ('detergente','ala','9457', 1250);

insert into ventas  (usuario_id, producto_id)
values 
(1,4),
 (2,1),
  (3,2),
   (4,1);



SELECT v.id as 'venta numero',u.nombre, u.apellido, p.nombre as 'producto' ,p.marca,p.precio FROM
(usuarios u INNER JOIN ventas v ON u.id = v.usuario_id)
INNER JOIN productos p ON p.id = v.usuario_id;


create view resumen_ventas
as 
select v.id as 'num_venta', u.nombre , u.apellido, p.nombre as 'producto', p.marca, p.precio from
(usuarios u INNER JOIN ventas v ON u.id = v.usuario_id)
INNER JOIN productos p ON p.id = v.usuario_id;

select * from resumen_ventas