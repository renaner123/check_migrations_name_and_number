create table janela (
    id serial primary key,
    descricao varchar(255) not null,
    data_inicio date not null,
    data_fim date not null
);

comment on table janela is 'Tabela de janelas';
comment on column janela.id is 'Identificador da janela';
comment on column janela.descricao is 'Descrição da janela';
comment on column janela.data_inicio is 'Data de início da janela';
comment on column janela.data_fim is 'Data de fim da janela';