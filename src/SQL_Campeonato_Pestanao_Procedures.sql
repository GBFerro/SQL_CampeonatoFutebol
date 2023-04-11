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
    SELECT Nome, Apelido, Pontuacao, (Gols_Marcados - Gols_Recebidos) as Saldo_Gols FROM [Time] ORDER BY Pontuacao DESC, Saldo_Gols DESC
END
GO

CREATE OR ALTER PROC Campeao
AS
BEGIN
    SELECT TOP 1 Nome, Apelido, Pontuacao, (Gols_Marcados - Gols_Recebidos) as Saldo_Gols FROM [Time] ORDER BY Pontuacao DESC, Saldo_Gols DESC
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

CREATE OR ALTER PROC JogoComMaisGols
AS
BEGIN
    SELECT Id_Jogo, Casa, Visitante, (Gols_Casa + Gols_Visitante) AS Total_Gols FROM [Jogo] 
    WHERE (Gols_Casa + Gols_Visitante) = (SELECT MAX(Gols_Casa + Gols_Visitante) FROM Jogo) 
    -- WHERE (Gols_Casa + Gols_Visitante) = (SELECT TOP 1 (Gols_Casa + Gols_Visitante) as Total FROM Jogo ORDER BY Total DESC) 
END
GO

CREATE OR ALTER PROC MaisGolsEmUmJogo
AS
BEGIN
    SELECT Nome_Time, MAX(Gols) AS Gols
    FROM
    (    
    SELECT Casa AS Nome_Time, MAX(Gols_Casa) AS Gols FROM Jogo
    GROUP BY Casa
    UNION
    SELECT Visitante AS Nome_Time, MAX(Gols_Visitante) AS Gols FROM Jogo
    GROUP BY Visitante
    ) AS Gols
    GROUP BY Nome_Time, Gols
END
GO