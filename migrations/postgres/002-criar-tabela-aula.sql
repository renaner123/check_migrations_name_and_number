create table aula (
    id serial primary key,
    nome varchar(255) not null,
    data date not null,
    sala_id integer not null references sala(id)
);

comment on table aula is 'Tabela de aulas';
comment on column aula.id is 'Identificador da aula';
comment on column aula.nome is 'Nome da aula';
comment on column aula.data is 'Data da aula';
comment on column aula.sala_id is 'Identificador da sala de aula';
