create database exp_RO; #esse banco de dados será referente ao último experimento que fiz no laboratório
use exp_ro;
create table experimento(
id_experimento int auto_increment primary key not null,
data_experimento date not null
);
create table grupo(
id_grupo int primary key not null,
nome_grupo varchar (50),
id_experimento int not null, 
foreign key (id_experimento)
references experimento(id_experimento)
);
create table animal(
id_animal int auto_increment primary key not null,
nome_rato varchar (20) not null,
peso_rato decimal (5,2) not null,
caixa_rato int not null,
id_grupo int not null,
foreign key (id_grupo) 
references grupo(id_grupo)
);
create table dados_teste(
id_dados_teste int auto_increment primary key not null,
tempo_obj_novo decimal(6,2) not null,
tempo_obj_familiar decimal(6,2) not null,
id_animal int not null,
indice_discriminacao   decimal(5,4) as ((tempo_obj_novo - tempo_obj_familiar) / 
                                        (tempo_obj_novo + tempo_obj_familiar)) virtual,
foreign key (id_animal) 
references animal(id_animal)
);

