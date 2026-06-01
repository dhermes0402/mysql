use GBDturRural2015;

select CONCAT_WS(' ', nomcli, ape1cli, ape2cli) AS Nombre_Apellidos,
tlf_contacto, correoelectronico as email
from clientes

union 

select nompropietario as Nombre_Apellidos,
tlf_contacto,
correoelectronico as email
from propietarios

 
order by Nombre_Apellidos;

-- 
select nomcasa, nomzona, count(reservas.codcasa) as Numero_Reservas 
from casas 
left join reservas
on casas.codcasa = reservas.codcasa
join zonas
on casas.codzona = zonas.numzona
group by casas.codcasa, nomcasa, nomzona
order by Numero_Reservas desc;

--
select nomcasa, nomzona, count(reservas.codcasa) as Numero_Reservas 
from casas 
left join reservas
on casas.codcasa = reservas.codcasa
join zonas
on casas.codzona = zonas.numzona
group by casas.codcasa, nomcasa, nomzona
order by Numero_Reservas desc;



