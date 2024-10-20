CREATE TABLE aula (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data DATE NOT NULL,
    sala_id INT NOT NULL FOREIGN KEY REFERENCES sala(id)
);

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabela de aulas', 
    @level0type = N'SCHEMA', @level0name = dbo, 
    @level1type = N'TABLE',  @level1name = aula;

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Identificador da aula', 
    @level0type = N'SCHEMA', @level0name = dbo, 
    @level1type = N'TABLE',  @level1name = aula, 
    @level2type = N'COLUMN', @level2name = id;

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Nome da aula', 
    @level0type = N'SCHEMA', @level0name = dbo, 
    @level1type = N'TABLE',  @level1name = aula, 
    @level2type = N'COLUMN', @level2name = nome;

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Data da aula', 
    @level0type = N'SCHEMA', @level0name = dbo, 
    @level1type = N'TABLE',  @level1name = aula, 
    @level2type = N'COLUMN', @level2name = data;

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Identificador da sala de aula', 
    @level0type = N'SCHEMA', @level0name = dbo, 
    @level1type = N'TABLE',  @level1name = aula, 
    @level2type = N'COLUMN', @level2name = sala_id;
