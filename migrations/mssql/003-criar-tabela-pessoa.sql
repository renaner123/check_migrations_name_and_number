CREATE TABLE pessoa (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(255) NOT NULL
);

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabela de pessoas', 
    @level0type = N'SCHEMA', @level0name = 'dbo', 
    @level1type = N'TABLE',  @level1name = 'pessoa';

EXEC sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Identificador da pessoa',
    @level0type = N'SCHEMA', @level0name = 'dbo',
    @level1type = N'TABLE',  @level1name = 'pessoa',
    @level2type = N'COLUMN', @level2name = 'id';

EXEC sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Nome da pessoa',
    @level0type = N'SCHEMA', @level0name = 'dbo',
    @level1type = N'TABLE',  @level1name = 'pessoa',
    @level2type = N'COLUMN', @level2name = 'nome';

EXEC sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'Data de nascimento da pessoa',
    @level0type = N'SCHEMA', @level0name = 'dbo',
    @level1type = N'TABLE',  @level1name = 'pessoa',
    @level2type = N'COLUMN', @level2name = 'data_nascimento';

EXEC sp_addextendedproperty
    @name = N'MS_Description',
    @value = N'E-mail da pessoa',
    @level0type = N'SCHEMA', @level0name = 'dbo',
    @level1type = N'TABLE',  @level1name = 'pessoa',
    @level2type = N'COLUMN', @level2name = 'email';