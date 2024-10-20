create table endereco (
    id serial primary key,
    logradouro varchar(255) not null,
    numero varchar(10) not null,
    complemento varchar(255),
    bairro varchar(255) not null,
    cidade varchar(255) not null,
    estado varchar(2) not null,
    cep varchar(8) not null
);

comment on table endereco is 'Tabela de endereços';
comment on column endereco.id is 'Identificador do endereço';
comment on column endereco.logradouro is 'Logradouro do endereço';
comment on column endereco.numero is 'Número do endereço';
comment on column endereco.complemento is 'Complemento do endereço';
comment on column endereco.bairro is 'Bairro do endereço';
comment on column endereco.cidade is 'Cidade do endereço';
comment on column endereco.estado is 'Estado do endereço';
comment on column endereco.cep is 'CEP do endereço';
