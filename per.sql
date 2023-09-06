drop database peruacu;
create database peruacu;
use peruacu;

create table visitante_responsavel (
    id int not null auto_increment,
    nome varchar(100) not null,
    email varchar(100) not null,
    telefone int not null,
    motivo varchar(150) not null,
    cidade varchar(100) not null,
    estado varchar(100) not null,
    pais varchar(100) not null,
    primary key (id)
);

create table visita(
    id int not null auto_increment,
    data_v date not null,
    num_vi int not null,
    periodo enum('manha', 'tarde') not null,
    visitante_responsavel_id int not null,
    primary key (id),
    foreign key (visitante_responsavel_id) references visitante_responsavel(id)
);

create table local(
    id int not null auto_increment,
    nome varchar(100) not null,
    descricao varchar(150) not null,
    limite int not null,
    tempo int not null,
    primary key (id)
);

create table guia(
    id int not null auto_increment,
    nome varchar(100) not null,
    email varchar(100) not null,
    telefone int not null,
    localidade varchar(100) not null,
    info varchar(150) not null,
    linguas varchar(50) not null,
    primary key (id)
);

create table visita_local(
    visita_id int not null,
    local_id int not null,
    primary key (visita_id, local_id),
    foreign key (visita_id) references visita(id),
    foreign key (local_id) references local(id)
);

create table visita_guia(
    visita_id int not null,
    guia_id int not null,
    primary key (visita_id, guia_id),
    foreign key (visita_id) references visita(id),
    foreign key (guia_id) references guia(id)
);

create table guia_local(
    guia_id int not null,
    local_id int not null,
    primary key (guia_id, local_id),
    foreign key (guia_id) references guia(id),
    foreign key (local_id) references local(id)
);

-- local 

insert into local (nome, descricao, limite, tempo) values

 ('caminho da gruta do janelão','caminho', 50, 8),
 ('caminho da lapa dos desenhos','caminho', 80, 5),
 ('trilha do arco andre','caminho', 70, 5);

-- guia

insert into guia (nome, email, telefone, localidade, info, linguas) values

 ('joao', 'jj@gg.vom', 00123456789, 'januaria', 'ola minha descricao xxxxxx', 'espanhol'),
('maria', 'mm@gm.com', 00123456789, 'januaria', 'ola minha descricao e a xxxxxx', 'ingles'),
('tereza', 'lia@gg.vom', 00123456789, 'januaria', 'ola minha descricao xxxxxx', 'espanhol');

-- guia_local

insert into guia_local (guia_id, local_id) values

 (1, 1),
 (1, 2),
 (2, 3),
 (2, 1);

-- visitante_responsavel

insert into visitante_responsavel (nome, email, telefone, motivo, cidade, estado, pais) values

('lala', 'll@or.com', 00123456789, 'pesquisa', 'januaria', 'minas gerais', 'brasil'),
('tata', 'tt@if.com', 00123456788, 'turismo', 'diamantina', 'minas gerais', 'brasil'),
('lili', 'oit@if.com', 00123456788, 'turismo', 'são paulo', 'são paulo', 'brasil');

-- visita

insert into visita (data_v, num_vi, periodo, visitante_responsavel_id) values

('2023-10-10', 10, 'manha', 1),
('2023-10-10', 10, 'tarde', 2),
('2023-10-10', 20, 'tarde', 3);

-- visita_local

insert into visita_local (visita_id, local_id) values

(1, 1),
(1, 2),
(2, 3),
(2, 1),
(3, 2),
(3, 3);

-- visita_guia

insert into visita_guia (visita_id, guia_id) values

(1, 2),
 (1, 1),
 (2, 2),
 (3,2);


-- guias e seus locais

select g.nome as nome_guia, l.nome as local_, l.descricao from guia g inner join guia_local gl on g.id = gl.guia_id inner join local l on l.id = gl.local_id;

-- visitas e seus guias

select v.id as id_visita, g.nome as nome_guia, g.email as email_guia, g.telefone as telefone_guia from visita v inner join visita_guia vg on v.id = vg.visita_id inner join guia g on g.id = vg.guia_id;

-- locais e suas visitas

select l.nome as nome_local, v.data_v as data_visita, v.num_vi as numero_visitantes, v.periodo as periodo_visita from local l inner join visita_local vl on l.id = vl.local_id inner join visita v on v.id = vl.visita_id;