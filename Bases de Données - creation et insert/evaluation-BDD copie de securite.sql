
create database evaluationbdd
go
use evaluationbdd
go
create table client (
	cli_num int  primary key not null,
	cli_nom varchar(50) not null,
	cli_adresse varchar(50),
	cli_tel varchar(30)
)
go
create table produit (
	pro_num int primary key not null,
	pro_libelle varchar(50) not null,
	pro_description varchar(50)
)
go
create table commande(
	com_num int primary key not null,
	cli_num int references client(cli_num),
	com_date datetime not null,
	com_obs varchar(50)

)
go
create table est_compose(
	com_num int references commande(com_num) not null,
	pro_num int references produit(pro_num) not null,
	est_qte int not null,
	primary key (com_num,pro_num)

)
go

create unique index indexnomclient on client(cli_nom)
go

__________________________

script complet de la creation de la base Papyrus

create database Papyrus
go
use Papyrus
go

CREATE TABLE fournis(
	numfou INT  PRIMARY KEY  NOT NULL ,
	nomfou VARCHAR (30) NOT NULL ,
	ruefou VARCHAR (50) NOT NULL ,
	posfou VARCHAR (5)  NOT NULL ,
	vilfou VARCHAR (30) NOT NULL ,
	confou VARCHAR (15) NOT NULL ,
	satisf int, 
	check (satisf  between 1 and 10 )  
)

go

CREATE TABLE produit(
	codart	varchar (10)  PRIMARY KEY  NOT NULL ,
	libart VARCHAR (30) NOT NULL ,
	stkale INT  NOT NULL ,
	stkphy INT  NOT NULL ,
	qteann INT  NOT NULL ,
	unimes varchar(5)  NOT NULL 
	)
go
CREATE TABLE entcom (
	numcom         int identity primary key  NOT NULL ,
	datecom        smalldatetime  default getdate() NOT NULL ,
	obscom         VARCHAR(50) ,
	numfou         int references fournis(numfou)
)
go


CREATE TABLE vente(
	qte1   INT  NOT NULL ,
	qte2   INT  ,
	qte3   INT  ,
	prix1  DECIMAL (10,2)  NOT NULL ,
	prix2  DECIMAL (10,2)   ,
	prix3  DECIMAL (10,2)  ,
	delliv SMALLINT  NOT NULL ,
	codart varchar(10)  NOT NULL references  produit(codart) ,
	numfou int  NOT NULL references fournis(numfou) ,
	PRIMARY KEY (codart,numfou)
)
go

CREATE TABLE ligcom(
	numlig varchar(10)  NOT NULL ,
	qtecde INT  NOT NULL ,
	priuni DECIMAL (25,0)  NOT NULL ,
	derliv DATETIME NOT NULL ,
	qteliv INT  ,
	numcom int references entcom(numcom) NOT NULL ,
	codart varchar(10)  references produit(codart) NOT NULL ,
	PRIMARY KEY (numcom,numlig)
)



Go


___________________________


/* table FOURNIS */

insert into fournis (numfou,nomfou,ruefou,posfou,vilfou,confou,satisf) values(00120,'GROBRIGAN','20 rue du papier','92200','papercity','Georges',08)
insert into fournis (numfou,nomfou,ruefou,posfou,vilfou,confou,satisf) values(00540,'ECLIPSE','53 rue laisse flotter les rubans','78250','Bugbugville','Nestor',07)
insert into fournis (numfou,nomfou,ruefou,posfou,vilfou,confou,satisf) values(08700,'MEDICIS','120 rue des plantes','75014','Paris','Lison',null) 
insert into fournis (numfou,nomfou,ruefou,posfou,vilfou,confou,satisf) values(09120,'DISCOBOL','11 rue des sports','85100', 'La Roche sur Yon','Hercule',08) 
insert into fournis (numfou,nomfou,ruefou,posfou,vilfou,confou,satisf) values(09150,'DEPANPAP','26, avenue des locomotives','59987','Coroncountry','Pollux',05) 
insert into fournis (numfou,nomfou,ruefou,posfou,vilfou,confou,satisf) values(09180,'HURRYTAPE','68 boulevard des octets', '04044',' Dumpville','Track',null) 

/* table PRODUIT */

insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('I100',	'Papier 1 ex continu',100,557,3500,'B1000')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('I105',	'Papier 2 ex continu',75,5,2300,'B1000')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('I108',	'Papier 3 ex continu',200,557,3500,'B500')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('I110',	'Papier 4 ex continu',10,12,63,'B400')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('P220',	'Pré imprimé commande',500,2500,24500,'B500')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('P230',	'Pré imprimé facture',500,250,12500,'B500')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('P240',	'Pré imprimé bulletin paie',500,3000,6250,'B500')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('P250',	'Pré imprimé bon livraison',500,2500,24500,'B500')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('P270',	'Pré imprimé bon fabrication',500,2500,24500,'B500')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('R080',	'Ruban Epson 850',10,2,120,'unité')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('R132',	'Ruban imp1200 lignes',25,200,182,'unité')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('B002',	'Bande magnétique 6250',20,12,410,'unité')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('B001',	'Bande magnétique 1200',20,87,240,'unité')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('D035',	'CD R slim 80 mm',40,42,150,'B010')
insert into produit (codart, libart, stkale, stkphy, qteann, unimes) values ('D050',	'CD R-W 80mm',50,4,0,'B010' )


/* table ENTCOM */
set identity_insert entcom ON
insert into entcom (numcom,obscom,datecom,numfou) values (70010,null, '10/02/2007',00120)
insert into entcom (numcom,obscom,datecom,numfou) values (70011,'Commande urgente','01/03/2007',00540)
insert into entcom (numcom,obscom,datecom,numfou) values (70020,null,'25/04/2007',09180)
insert into entcom (numcom,obscom,datecom,numfou) values (70025,'Commande urgente','30/04/2007',09150)
insert into entcom (numcom,obscom,datecom,numfou) values (70210,'Commande cadencée','05/05/2007',00120)
insert into entcom (numcom,obscom,datecom,numfou) values (70300,null,'06/06/2007',09120)
insert into entcom (numcom,obscom,datecom,numfou) values (70250,'Commande cadencée','02/10/2007',08700)
insert into entcom (numcom,obscom,datecom,numfou) values (70620,null,'02/10/2007',00540)
insert into entcom (numcom,obscom,datecom,numfou) values (70625,null,'09/10/2007',00120)
insert into entcom (numcom,obscom,datecom,numfou) values (70629,null,'12/10/2007',09180)

set identity_insert entcom OFF



/* table VENTES*/
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I100',00120,90, 0, 700, 50, 600,120,500)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I100',00540,70, 0, 710, 60, 630,100,600)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I100',09120,60, 0, 800, 70, 600,90, 500)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I100',09150,90, 0, 650, 90, 600 ,200, 590)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I100',09180,30, 0, 720, 50, 670, 100, 490)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I105',00120,90, 10, 705, 50, 630, 120, 500)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I105',00540,70, 0, 810, 60, 645, 100, 600)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I105',09120,60, 0, 920, 70, 800 ,90, 700)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I105',09150,90, 0, 685, 90, 600 ,200, 590)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I105',08700,30, 0, 720, 50, 670 ,100, 510)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I108',00120,90, 5, 795, 30, 720 ,100, 680)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I108',09120,60, 0, 920, 70, 820 ,100, 780)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I110',09180,90, 0, 900, 70, 870 ,90 ,835)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('I110',09120,60, 0, 950, 70, 850, 90 ,790)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('D035',00120,0, 0, 40,null,null,null,null)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('D035',09120,5, 0, 40, 100, 30,null,null)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('P220',00120,15, 0, 3700, 100,3500,null,null)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('P230',00120,30, 0, 5200,100,5000,null,null)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('P240',00120,15, 0, 2200,100,2000,null,null)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('P250',00120,30, 0, 1500,100,1400,500,1200)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('P250',09120,30, 0, 1500,100, 1400 ,500, 1200)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('P220',08700,20, 50, 3500,100, 3350,null,null)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('P230',08700,60, 0, 5000,50, 4900,null,null)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('R080',09120,10, 0, 120, 100, 100,null,null)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('R132',09120,5, 0, 275,null,null,null,null)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('B001',08700,15, 0, 150, 50, 145 ,100 ,140)
insert into vente (codart,numfou,delliv,qte1,prix1,qte2,prix2,qte3,prix3) values ('B002',08700,15, 0, 210, 50, 200, 100, 185 )


/* table LIGCOM */ 

insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70010,01,'I100',3000,470,3000,'15/03/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70010,02,'I105',2000,485,2000,'05/07/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70010,03,'I108',1000,680,1000,'20/08/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70010,04,'D035',200,40, 250,'20/02/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70010,05,'P220',6000,3500,6000,'31/03/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70010,06,'P240',6000,2000,2000,'31/03/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70011,01,'I105',1000,600, 1000,'16/05/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70020,01,'B001',200,140,null,'31/12/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70020,02,'B002',200,140,null,'31/12/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70025,01,'I100',1000,590,1000,'15/05/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70025,02,'I105',500,590,500,'15/05/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70210,01,'I100',1000,470,1000,'15/07/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70300,01,'I110',50,790,50,'31/10/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70250,01,'P230',15000,4900,12000,'15/12/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70250,02,'P220',10000,3350,10000,'10/11/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70620,01,'I105',200,600,200,'01/11/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70625,01,'I100',1000,470,1000,'15/10/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70625,02,'P220',10000,3500, 10000,'31/10/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70629,01,'B001',200,140,null,'31/12/2007')
insert into ligcom(numcom,numlig,codart,qtecde,priuni,qteliv,derliv) values (70629,02,'B002',200,140,null,'31/12/2007' )


/*Papyrus
Sécurité

Exo 1
Create database Papyrus 

Suite : créer des logins */

create login util1 with password = 'pwd',
default_database=[master],
check_expiration=OFF,
check_policy=off

go
create login util2 with password = 'pwd',
default_database=[Papyrus],
check_expiration=OFF,
check_policy=off

go

create login util3 with password = 'pwd',
default_database=[Papyrus],
check_expiration=OFF,
check_policy=off

 go

/* créer des users (ouvrir la base d’abord avec use)  */
use Papyrus
create user util1 for login util1

create user util2 for login util2

create user util3 for login util3




/* donner des droits :
en utilisateur principal (pas en util1)
Papyrus
Sécurité

Exo 1 */

Create database test

/* Suite : créer des logins */
create login util1 with password = 'pwd',
default_database=[master],
check_expiration=OFF,
check_policy=off

go
create login util2 with password = 'pwd',
default_database=[Papyrus],
check_expiration=OFF,
check_policy=off

go

create login util3 with password = 'pwd',
default_database=[Papyrus],
check_expiration=OFF,
check_policy=off

 go


/* se connecter en utilisateur 1
créer des users (ouvrir la base d’abord avec use) */

use Papyrus
create user util1 for login util1

create user util2 for login util2

create user util3 for login util3




/* donner des droits :
en utilisateur principal (pas en util1)
use Papyrus */
grant select on fournis to util1
grant select on entcom to util1
grant select on vente to util1
grant select on ligcom to util1
grant select on produit to util1

grant insert on fournis to util1
grant insert on entcom to util1
grant insert on vente to util1
grant insert on ligcom to util1
grant insert on produit to util1


/*interdire une action*/

deny delete on fournis to util1
deny delete on entcom to util1
deny delete on vente to util1
deny delete on ligcom to util1
deny delete on produit to util1	


/*inserer une ligne  dans la table fournis
en utilisateur1 : util1 */

insert into fournis (numfou, nomfou, ruefou, posfou, vilfou, confou, satisf) values (1, 'bricotruc', 'rue de la republique', '80100','amiens', 'confortable', 5)


/*suppression d’une ligne (admin sinon en util1 ça marche pas, pas le droit) */
delete from fournis where numfou=1

/*la suppression ne fonctionne pas dans l’exercice car l’utilisateur util1 n’a pas les droits pour supprimer.*/



/*Partie 2
Autoriser le select à tous les utilisateurs sur toutes les tables */

grant select on fournis to public
grant select on entcom to public
grant select on vente to public
grant select on ligcom to public
grant select on produit to public

/*créer un role */
create role gestion
grant select on fournis to gestion
grant update on fournis to gestion
grant insert on fournis to gestion


/*donner les autorisations du role à l’utilisateur 3 : util3 */
execute sp_addrolemember 'gestion','util3'

/* mise à jour/modif de données */
update fournis 
set posfou=80000 
where numfou=1


/* l’util3 ne peut pas supprimer car n’a pas les autorisation*/

/* suppression d’une ligne pou remettre la base propre comme avant, en admin sinon en util1 ça marche pas, pas le droit */
delete from fournis where numfou=1

