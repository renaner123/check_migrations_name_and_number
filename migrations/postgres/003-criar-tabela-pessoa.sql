create table pessoa (
    id serial primary key,
    nome varchar(255) not null,
    data_nascimento date not null,
    email varchar(255) not null
);

comment on table pessoa is 'Tabela de pessoas';
comment on column pessoa.id is 'Identificador da pessoa';
comment on column pessoa.nome is 'Nome da pessoa';
comment on column pessoa.data_nascimento is 'Data de nascimento da pessoa';
comment on column pessoa.email is 'E-mail da pessoa';