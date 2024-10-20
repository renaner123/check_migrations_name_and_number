CREATE TABLE sala (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    capacidade INT NOT NULL
);

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabela de salas de aula', 
    @level0type = N'SCHEMA', @level0name = 'dbo', 
    @level1type = N'TABLE',  @level1name = 'sala';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Identificador da sala', 
    @level0type = N'SCHEMA', @level0name = 'dbo', 
    @level1type = N'TABLE',  @level1name = 'sala', 
    @level2type = N'COLUMN', @level2name = 'id';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Nome da sala', 
    @level0type = N'SCHEMA', @level0name = 'dbo', 
    @level1type = N'TABLE',  @level1name = 'sala', 
    @level2type = N'COLUMN', @level2name = 'nome';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Capacidade de alunos da sala', 
    @level0type = N'SCHEMA', @level0name = 'dbo', 
    @level1type = N'TABLE',  @level1name = 'sala', 
    @level2type = N'COLUMN', @level2name = 'capacidade';
