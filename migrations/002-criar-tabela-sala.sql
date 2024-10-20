create table sala (
    id serial primary key,
    nome varchar(255) not null,
    capacidade integer not null
);

comment on table sala is 'Tabela de salas de aula';
comment on column sala.id is 'Identificador da sala';
comment on column sala.nome is 'Nome da sala';
comment on column sala.capacidade is 'Capacidade de alunos da sala';

