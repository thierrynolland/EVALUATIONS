/*EVALUATION BASE NORTHWIND */

/* I - REQUETES D'INTERROGATION DE LA BASE NORTHWIND */
use Northwind
go

/* 1 - Liste des contacts français : */

select * from customers where country ='France'

/*2 - Produits vendus par le fournisseur « Exotic Liquids » :*/

select ProductName as produit,UnitPrice as prix 
from products JOIN Suppliers on products.SupplierID = Suppliers.SupplierID
where CompanyName='Exotic Liquids'

/* 3 - Nombre de produits vendus par les fournisseurs Français dans l’ordre décroissant :*/

select Suppliers.CompanyName as Fournisseur,count(Products.productID)
FROM Suppliers	JOIN PRODUCTS ON Suppliers.SupplierID=Products.SupplierID
WHERE Suppliers.Country='France'
group by Suppliers.CompanyName
order by count(Products.productID) DESC


/*4 - Liste des clients Français ayant plus de 10 commandes : */

select Customers.CompanyName AS Client, count(orders.orderID) as 'Nombre de commandes'
from customers join orders ON Customers.CustomerID=Orders.CustomerID 
Where Customers.Country='France'
group by Customers.CompanyNAme
having count(orders.orderID)>10

/*5 - Liste des clients ayant un chiffre d’affaires > 30.000 :*/

select Customers.CompanyName AS Client, sum(([Order Details].UnitPrice * [Order Details].Quantity)) AS CA, Customers.Country AS Pays
from customers	JOIN Orders				ON Customers.CustomerID= Orders.CustomerID
				JOIN [Order Details]	ON Orders.OrderID=[Order Details].OrderID

GROUP BY Customers.CompanyName, Customers.country
HAVING sum(([Order Details].UnitPrice * [Order Details].Quantity)) >30000
order by sum(([Order Details].UnitPrice * [Order Details].Quantity)) DESC

/*6 – Liste des pays dont les clients ont passé commande de produits fournis par « Exotic
Liquids » : */


select Distinct Customers.Country as PAYS
from Suppliers
JOIN PRODUCTS		ON Suppliers.SupplierID=PRODUCTS.SupplierID
JOIN [Order Details]ON Products.ProductID= [Order Details].ProductID
JOIN ORDERS			ON [Order Details].OrderID=Orders.OrderID
JOIN CUSTOMERS		ON Orders.CustomerID=Customers.CustomerID

where Suppliers.CompanyName='Exotic Liquids'
ORDER BY Customers.Country ASC

/*7 – Montant des ventes de 1997 : */

select sum([Order Details].UnitPrice*[Order Details].Quantity)	AS 'MONTANT DES VENTES'
from [Order Details]
JOIN ORDERS	ON [Order Details].OrderID=Orders.OrderID
where year(Orders.OrderDate)=1997


/*8 – Montant des ventes de 1997 mois par mois :*/

select  month(Orders.OrderDate) AS 'Mois 97',sum([Order Details].UnitPrice*[Order Details].Quantity)	AS 'MONTANT DES VENTES'
from [Order Details]
JOIN ORDERS	ON [Order Details].OrderID=Orders.OrderID
where year(Orders.OrderDate)=1997
group by month(Orders.OrderDate)
order by month(Orders.OrderDate)

/*9 – Depuis quelle date le client « Du monde entier » n’a plus commandé ? */

select max(Orders.OrderDate) from 
customers JOIN ORDERS ON Customers.CustomerID=ORDERS.CustomerID
where customers.CompanyName ='Du monde entier'


/* 10 – Quel est le délai moyen de livraison en jours ? */

select avg(DateDiff(DAY,Orders.OrderDate,Orders.ShippedDate)) as 'délai moyen de livraison en jours'
from  ORDERS



/* II-PROCEDURES STOCKEES */

/*Codez deux procédures stockées correspondant aux requêtes 9 et 10
 Les procédures stockées doivent prendre en compte les éventuels paramètres.*/

/* procédure stockée pour la requete  */
create proc ClientMondeEntier
@nomClient varchar(100)
as
select max(Orders.OrderDate) from 
customers JOIN ORDERS ON Customers.CustomerID=ORDERS.CustomerID
where customers.CompanyName = @nomClient

go

exec ClientMondeEntier 'Du monde entier'



/* procédure stocvkée pour la requete 10 */
Create proc DelaiMoyenLivraison
as
select avg(DateDiff(DAY,Orders.OrderDate,Orders.ShippedDate)) as 'délai moyen de livraison en jours'
from  ORDERS

exec DelaiMoyenLivraison

/* III- MISE EN PLACE D'UNE REGLE DE GESTION*/

/*Pour tenir compte des coûts liés au transport,
on vérifiera que pour chaque produit d’une commande,
 le client réside dans la même région que le fournisseur du même produit*/

 On peut créer un Déclencheur sur la table [Oorder Details]
 faire des jointures qui va de CUSTOMERS à SUPPLIERS
 et comparer le Customers.Region au  Suplpiers.Region
 Si la région est différente ne pas accepter la saisie du produit ou au moins le signaler

 
