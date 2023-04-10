CREATE OR ALTER PROC IniciarCampeonato @NomeCamp VARCHAR(50), @AnoCamp INT
AS
BEGIN
    -- Insert rows into table 'TableName' in schema '[dbo]'
    INSERT INTO [dbo].[Campeonato]
    ( -- Columns to insert data into
    [Nome], [Ano]
    )
    VALUES
    ( -- First row: values for the columns in the list above
    @NomeCamp, @AnoCamp
    )
END
GO

CREATE OR ALTER PROCEDURE InserirTimes @NomeTime VARCHAR(100), @Apelido VARCHAR(100), @DataCriacao DATE 
AS
BEGIN
    INSERT INTO [dbo].[Time]
    ( -- Columns to insert data into
     [Nome], [Apelido], [DataCriacao]
    )
    VALUES
    ( -- First row: values for the columns in the list above
     @NomeTime, @Apelido, @DataCriacao
    )
END
GO

CREATE OR ALTER PROC IniciarJogo @NomeCamp VARCHAR(50), @AnoCamp INT
AS
BEGIN
    INSERT INTO [dbo].[Jogo]
    ( -- Columns to insert data into
     [Nome_Camp], [Ano_Camp]
    )
    VALUES
    ( -- First row: values for the columns in the list above
     @NomeCamp, @AnoCamp
    )
END
GO

CREATE OR ALTER PROC ClassificarPodio
AS
BEGIN
    SELECT Nome, Apelido, Pontuacao FROM [Time] ORDER BY Pontuacao DESC
END
GO

CREATE OR ALTER PROC Campeao
AS
BEGIN
    SELECT TOP 1 Nome, Apelido, Pontuacao FROM [Time] ORDER BY Pontuacao DESC
END
GO

CREATE OR ALTER PROC Artilheiro
AS
BEGIN
    SELECT TOP 1 Nome, Apelido, Gols_Marcados FROM [Time] ORDER BY Gols_Marcados DESC
END
GO

CREATE OR ALTER PROC Frangalha
AS
BEGIN
    SELECT TOP 1 Nome, Apelido, Gols_Recebidos FROM [Time] ORDER BY Gols_Recebidos DESC
END
GO
